USE p7g1;
GO

-- Cliente e Local na tabela Evento
CREATE NONCLUSTERED INDEX IX_Evento_Cliente_Local 
ON PROJETO_GESTAO_EVENTOS.Evento (Cliente_evento, Local_evento);

-- Data na tabela Evento
CREATE NONCLUSTERED INDEX IX_Evento_Data 
ON PROJETO_GESTAO_EVENTOS.Evento (Data_hora_evento);

-- Email e Nome na tabela Cliente
CREATE NONCLUSTERED INDEX IX_Cliente_Email 
ON PROJETO_GESTAO_EVENTOS.Cliente (Email);

CREATE NONCLUSTERED INDEX IX_Cliente_Nome 
ON PROJETO_GESTAO_EVENTOS.Cliente (Nome_cliente);

-- Atividade na tabela Inclui
CREATE NONCLUSTERED INDEX IX_Inclui_Atividade 
ON PROJETO_GESTAO_EVENTOS.Inclui (ID_atividade_inclui);
GO