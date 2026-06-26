USE p7g1;
GO

-- proibir que o evento seja marcado para uma data/hora não existente(s).
CREATE TRIGGER [PROJETO_GESTAO_EVENTOS].[TRG_CheckDataFutura]
ON [PROJETO_GESTAO_EVENTOS].[Evento]
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted I WHERE I.Data_hora_evento < GETDATE())
    BEGIN
        RAISERROR ('Não pode agendar eventos com data/hora já passadas.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Prevenção de overbooking (não pode existir 2 eventos na mesma data, hora e local)
CREATE TRIGGER [PROJETO_GESTAO_EVENTOS].[TRG_prevenir_overbooking]
ON [PROJETO_GESTAO_EVENTOS].[Evento]
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM PROJETO_GESTAO_EVENTOS.Evento E
        INNER JOIN inserted I ON E.Local_evento = I.Local_evento
        WHERE E.ID_evento <> I.ID_evento
        AND E.Data_hora_evento < I.Data_hora_fim_evento
        AND E.Data_hora_fim_evento > I.Data_hora_evento
    )
    BEGIN
        RAISERROR ('Já existe um evento agendado para este local no mesmo intervalo de tempo.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


-- Limite de lotação: o numero de pessoas no evento não pode ser superior à capacidade máxima do local escolhido.
CREATE TRIGGER [PROJETO_GESTAO_EVENTOS].[TRG_capacidade_maxima]
ON [PROJETO_GESTAO_EVENTOS].[Evento]
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted I
        INNER JOIN PROJETO_GESTAO_EVENTOS.[Local] L ON I.Local_evento = L.ID_local
        WHERE I.Participantes > L.Max_capacidade
    )
    BEGIN
        RAISERROR ('Limite de lotação. O número de participantes do evento ultrapassa a capacidade máxima do local escolhido.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Restrição de atividades para cada tipo de evento: cada tipo de evento tem atividades extra especificas e apenas essas podem ser adicionadas a esse tipo de evento.
CREATE TRIGGER [PROJETO_GESTAO_EVENTOS].[TRG_restricao_atividade_tipo_evento]
ON [PROJETO_GESTAO_EVENTOS].[Inclui]
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS(
        SELECT 1
        FROM inserted I
        INNER JOIN PROJETO_GESTAO_EVENTOS.Evento E ON I.ID_evento_inclui = E.ID_evento
        LEFT JOIN PROJETO_GESTAO_EVENTOS.Tem_atividade TA ON TA.Tipo_evento_tem_atividade = E.ID_tipo_evento
        AND I.ID_atividade_inclui = TA.Atividade_tem_atividade
        WHERE TA.Atividade_tem_atividade IS NULL
    )
    BEGIN
        RAISERROR ('Esta atividade não é permitida para o tipo de evento selecionado.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO