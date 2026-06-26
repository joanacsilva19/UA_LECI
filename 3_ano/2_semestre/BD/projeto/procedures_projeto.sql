USE p7g1;
GO

CREATE PROCEDURE PROJETO_GESTAO_EVENTOS.sp_SincronizarPrecosAtividades
AS
BEGIN
    UPDATE A
    SET A.Preco_atividade = V.PrecoFinal
    FROM PROJETO_GESTAO_EVENTOS.Atividade A
    INNER JOIN PROJETO_GESTAO_EVENTOS.vw_PrecosAtividades V ON A.ID_atividade = V.ID_atividade;
END;
GO

-- fatura com recurso a um cursor
CREATE OR ALTER PROCEDURE PROJETO_GESTAO_EVENTOS.sp_GerarFaturaEvento
    @ID_Evento INT
AS
BEGIN

    DECLARE @Data_evento DATETIME;
    DECLARE @NIF_Cliente VARCHAR(9);
    DECLARE @Nome_Local VARCHAR(20);
    DECLARE @Custo_Local DECIMAL(10,2);
    DECLARE @Custo_Total_Calculado DECIMAL(10,2);

    DECLARE @ID_atividade INT;
    DECLARE @Preco_Atividade DECIMAL(10,2);

    SELECT 
        @Data_evento = E.Data_hora_evento,
        @NIF_Cliente = E.Cliente_evento,
        @Nome_Local = L.nome_local,
        @Custo_Local = L.preco_local
    FROM PROJETO_GESTAO_EVENTOS.Evento E
    INNER JOIN PROJETO_GESTAO_EVENTOS.[Local] L ON E.Local_evento = L.ID_local
    WHERE E.ID_evento = @ID_Evento;

    IF @Data_evento IS NULL
    BEGIN
        RAISERROR('Evento não encontrado.', 16, 1);
        RETURN;
    END

    SET @Custo_Total_Calculado = PROJETO_GESTAO_EVENTOS.fn_CalcularCustoTotalEvento(@ID_Evento);

    PRINT '======================================================================';
    PRINT '                           FATURA DO EVENTO                           ';
    PRINT '======================================================================';
    PRINT 'ID Evento:    ' + CAST(@ID_Evento AS VARCHAR(10));
    PRINT 'Data/Hora:    ' + CONVERT(VARCHAR(20), @Data_evento, 120);
    PRINT 'NIF Cliente:  ' + @NIF_Cliente;
    PRINT 'Local:        ' + @Nome_Local + ' (Custo Base: ' + CAST(@Custo_Local AS VARCHAR(15)) + '€)';
    PRINT '----------------------------------------------------------------------';
    PRINT '                           DETALHE DOS ITENS                          ';
    PRINT '----------------------------------------------------------------------';

    DECLARE cursor_detalhe_fatura CURSOR FOR
    SELECT 
        A.ID_atividade,
        V.PrecoFinal
    FROM PROJETO_GESTAO_EVENTOS.Inclui I
    INNER JOIN PROJETO_GESTAO_EVENTOS.Atividade A ON I.ID_atividade_inclui = A.ID_atividade
    INNER JOIN PROJETO_GESTAO_EVENTOS.vw_PrecosAtividades V ON A.ID_atividade = V.ID_atividade
    WHERE I.ID_evento_inclui = @ID_Evento;

    OPEN cursor_detalhe_fatura;

    FETCH NEXT FROM cursor_detalhe_fatura INTO @ID_atividade, @Preco_Atividade;

    IF @@FETCH_STATUS <> 0
    BEGIN
        PRINT '  (Sem atividades extra adicionadas a este evento)';
    END

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT '  Item: Atividade Extra (ID: ' + CAST(@ID_atividade AS VARCHAR(10)) + 
              ') -> Valor: ' + CAST(@Preco_Atividade AS VARCHAR(15)) + '€';

        FETCH NEXT FROM cursor_detalhe_fatura INTO @ID_atividade, @Preco_Atividade;
    END;

    CLOSE cursor_detalhe_fatura;
    DEALLOCATE cursor_detalhe_fatura;

    PRINT '----------------------------------------------------------------------';
    PRINT ' VALOR TOTAL A PAGAR: ' + CAST(@Custo_Total_Calculado AS VARCHAR(15)) + '€';
    PRINT '======================================================================';
END;
GO