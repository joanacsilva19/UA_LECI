USE p7g1;
GO

CREATE FUNCTION PROJETO_GESTAO_EVENTOS.fn_CalcularCustoTotalEvento (@ID_Evento INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @CustoLocal DECIMAL(10,2);
    DECLARE @CustoAtividades DECIMAL(10,2);
    DECLARE @Total DECIMAL(10,2);

    -- 1. Obter custo do local através da ligação Evento - Local
    SELECT @CustoLocal = ISNULL(L.preco_local, 0)
    FROM PROJETO_GESTAO_EVENTOS.Evento E
    INNER JOIN PROJETO_GESTAO_EVENTOS.Local L ON E.Local_evento = L.ID_local
    WHERE E.ID_evento = @ID_Evento;

    -- 2. Somar custo das atividades extra (da tabela Inclui + Atividade)
    SELECT @CustoAtividades = ISNULL(SUM(V.PrecoFinal), 0)
    FROM PROJETO_GESTAO_EVENTOS.Inclui I
    INNER JOIN PROJETO_GESTAO_EVENTOS.vw_PrecosAtividades V ON I.ID_atividade_inclui = V.ID_atividade
    WHERE I.ID_evento_inclui = @ID_Evento;

    SET @Total = ISNULL(@CustoLocal, 0) + ISNULL(@CustoAtividades, 0);

    RETURN @Total;
END;
GO