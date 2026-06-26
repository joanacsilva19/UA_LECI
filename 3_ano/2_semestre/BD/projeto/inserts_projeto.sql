USE p7g1;
GO

-- Cliente (NIF, Nome_cliente, Email, Telefone)
INSERT INTO PROJETO_GESTAO_EVENTOS.Cliente VALUES
('100000001', 'Ana Costa', 'ana@empresa.com', '910000001'),
('100000002', 'Bruno Silva', 'bruno@gmail.com', '920000002'),
('100000003', 'Carla Dias', 'carla@hotmail.com', '930000003'),
('100000004', 'Diogo Santos', 'diogo@outlook.com', '960000004'),
('100000005', 'Elsa Rocha', 'elsa@empresa.pt', '915000005');

-- Local (ID_local, Nome_local, Morada, Max_capacidade, Preco_local)
INSERT INTO PROJETO_GESTAO_EVENTOS.[Local] VALUES 
(1, 'Auditório Principal', 'Rua de Aveiro, 10', 200, 1000.00),
(2, 'Jardim de Inverno', 'Av. Central, 45', 500, 1500.00),
(3, 'Salão de Festas', 'Praça da República, 5', 150, 600.00);

-- Tipo_evento (ID_tipo, Nome_tipo_evento)
INSERT INTO PROJETO_GESTAO_EVENTOS.Tipo_evento VALUES 
(1, 'Conferência'),
(2, 'Casamento'),
(3, 'Aniversário'),
(4, 'Gala Corporativa');

-- Menu (preco_menu, n_menu)
INSERT INTO PROJETO_GESTAO_EVENTOS.Menu VALUES 
(25.50, 10),
(45.00, 20),
(60.00, 30);

-- Tema (ID_tipo_tema, preco_tema, nome_tema)
INSERT INTO PROJETO_GESTAO_EVENTOS.Tema VALUES 
(150.00, 'Princesas'),
(300.00, 'Palhaços'),
(100.00, 'Super heróis');


-- Atividade (ID_atividade, Preco_atividade) -> Preço base inicial 0
INSERT INTO PROJETO_GESTAO_EVENTOS.Atividade (ID_atividade) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);


-- Musica (preco_musica, n_horas, ID_atividade_musica)
INSERT INTO PROJETO_GESTAO_EVENTOS.Musica VALUES 
(150.00, 4, 1),
(200.00, 5, 2),
(100.00, 3, 3);

-- Banda (preco_banda, ID_atividade_banda) -> Herda de Musica (1 e 2)
INSERT INTO PROJETO_GESTAO_EVENTOS.Banda VALUES 
(400.00, 1),
(600.00, 2);

-- DJ (preco_DJ, ID_atividade_DJ) -> Herda de Musica (3)
INSERT INTO PROJETO_GESTAO_EVENTOS.DJ VALUES 
(250.00, 3);

-- Fotografia (preco_fotografia, n_sessoes, altura_dia, preco_sessao, ID_atividade_fotografia)
INSERT INTO PROJETO_GESTAO_EVENTOS.Fotografia VALUES 
(200.00, 2, 'Manhã', 100.00, 4),
(300.00, 3, 'Dia Inteiro', 100.00, 5);

-- Animacao (preco_animacao, n_horas_animacao, n_animadores, ID_tipo_tema_animacao, ID_atividade_animacao)
INSERT INTO PROJETO_GESTAO_EVENTOS.Animacao VALUES 
(150.00, 3, 2, 5, 6),
(250.00, 4, 3, 6, 7);


-- Catering (preco_catering, n_menu_catering, ID_atividade_catering)
INSERT INTO PROJETO_GESTAO_EVENTOS.Catering VALUES 
(0.00, 10, 8),
(0.00, 20, 9),
(0.00, 30, 10);


-- Tem_atividade (Tipo_evento_tem_atividade, Atividade_tem_atividade)
INSERT INTO PROJETO_GESTAO_EVENTOS.Tem_atividade VALUES 
(1, 4), (1, 8),          -- Conferência pode ter Foto(4) e Catering(8)
(2, 1), (2, 5), (2, 9),  -- Casamento pode ter Banda(1), Foto(5) e Catering(9)
(3, 3), (3, 6), (3, 10), -- Aniversário pode ter DJ(3), Animação(6) e Catering(10)
(4, 2), (4, 5), (4, 7);  -- Gala pode ter Banda(2), Foto(5) e Animação(7)


-- Evento (Data_hora_evento, Duracao_horas_evento, Participantes, Cliente_evento, Local_evento, ID_tipo_evento)
INSERT INTO PROJETO_GESTAO_EVENTOS.Evento (Data_hora_evento, Duracao_horas_evento, Participantes, Cliente_evento, Local_evento, ID_tipo_evento) VALUES

('2026-08-01 17:00:00', 10, 300, '100000001', 1, 3) -- Aniversario
('2026-08-01 10:00:00', 6, 100, '100000001', 1, 1), -- Conferencia
('2026-08-02 14:00:00', 8, 120, '100000002', 2, 2), -- Casamento
('2026-08-03 18:00:00', 4, 50,  '100000003', 3, 3), -- Aniversario
('2026-08-04 19:00:00', 5, 80,  '100000004', 1, 4), -- Gala
('2026-08-05 09:00:00', 7, 150, '100000005', 2, 1), -- Conferencia
('2026-08-06 16:00:00', 10, 200, '100000001', 2, 2), -- Casamento
('2026-08-07 17:00:00', 5, 40,  '100000002', 3, 3), -- Aniversario
('2026-08-08 20:00:00', 6, 90,  '100000003', 1, 4), -- Gala
('2026-08-09 11:00:00', 4, 60,  '100000004', 3, 3), -- Aniversario
('2026-08-10 15:00:00', 8, 110, '100000005', 2, 2); -- Casamento


-- Inclui (ID_evento_inclui, ID_atividade_inclui)
INSERT INTO PROJETO_GESTAO_EVENTOS.Inclui VALUES 
(1, 4),           -- Evento 1 (Conf) inclui Foto(4)
(1, 8),           -- Evento 1 (Conf) inclui Catering(8)
(2, 1),           -- Evento 2 (Casam) inclui Banda(1)
(2, 9),           -- Evento 2 (Casam) inclui Catering(9)
(3, 6),           -- Evento 3 (Aniv) inclui Animação(6)
(4, 7),           -- Evento 4 (Gala) inclui Animação(7)
(5, 8),           -- Evento 5 (Conf) inclui Catering(8)
(6, 5), (6, 9),   -- Evento 6 (Casam) inclui Foto(5) e Catering(9)
(7, 3), (7, 10),  -- Evento 7 (Aniv) inclui DJ(3) e Catering(10)
(8, 2),           -- Evento 8 (Gala) inclui Banda(2)
(9, 6),           -- Evento 9 (Aniv) inclui Animação(6)
(10, 1), (10, 5); -- Evento 10 (Casam) inclui Banda(1) e Foto(5)
