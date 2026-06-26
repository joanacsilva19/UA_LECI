
INSERT INTO tipo_fornecedor (codigo, designacao) VALUES 
(1, 'Grossista'), (2, 'Fabricante'),
(3, 'Importador'), (4, 'Distribuidor'),
(5, 'Prestador');

INSERT INTO fornecedor (nif, nome, fax, endereco, condpag, tipo) VALUES 
(5001, 'Tech PT', '2101', 'Lisboa', '30 dias', 1), (5002, 'Art Wood', '2201', 'Porto', 'Pronto', 2),
(5003, 'Euro Imp', '2102', 'Lisboa', '60 dias', 3), (5004, 'Sul Dist', '2891', 'Faro', '30 dias', 4),
(5005, 'Papelaria', '2391', 'Coimbra', 'Pronto', 5), (5006, 'Chips SA', '2202', 'Maia', '30 dias', 1),
(5007, 'Fast Log', '2103', 'Alverca', '45 dias', 4), (5008, 'Cadeiras LX', '2104', 'Sintra', '60 dias', 2),
(5009, 'World El', '2105', 'Cascais', '90 dias', 3), (5010, 'Norte Supr', '2531', 'Braga', '30 dias', 5);

INSERT INTO produto (codigo, nome, preco, iva, unidades) VALUES 
(101, 'Monitor', 200.00, 23, 50), (102, 'Teclado', 50.00, 23, 100), 
(103, 'Rato', 25.00, 23, 200), (104, 'Secretaria', 300.00, 23, 10),
(105, 'Cadeira', 150.00, 23, 15), (106, 'Candeeiro', 40.00, 23, 30),
(107, 'Cabo USB', 10.00, 23, 500), (108, 'Impressora', 250.00, 23, 5),
(109, 'Toner', 60.00, 23, 40), (110, 'Webcam', 80.00, 23, 25),
(111, 'Suporte', 20.00, 23, 60), (112, 'Tapete', 15.00, 23, 120),
(113, 'Hub USB', 35.00, 23, 45), (114, 'Gavetas', 70.00, 23, 8),
(115, 'Quadro', 50.00, 23, 12);

INSERT INTO encomenda (numero, data, fornecedor) VALUES 
(1, '2024-01-10', 5001), (2, '2024-01-11', 5003),
(3, '2024-01-12', 5002), (4, '2024-01-13', 5006),
(5, '2024-01-14', 5009), (6, '2024-01-15', 5005),
(7, '2024-01-16', 5004), (8, '2024-01-17', 5008),
(9, '2024-01-18', 5010), (10, '2024-01-19', 5007);


INSERT INTO item (numEnc, codProd, unidades) VALUES 
(1, 101, 5), (2, 107, 100), (3, 104, 2), (4, 110, 10), (5, 113, 15),
(6, 115, 3), (7, 103, 50), (8, 105, 10), (9, 109, 20), (10, 112, 30);

