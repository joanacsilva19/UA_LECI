CREATE SCHEMA GESTAO_STOCK
GO

CREATE TABLE GESTAO_STOCK.Fornecedor(
NIF INT PRIMARY KEY NOT NULL,
Endereco VARCHAR(40),
Nome_fornecedor VARCHAR(40),
Fax INT,
);

CREATE TABLE GESTAO_STOCK.Tipo_fornecedor(
ID_fornecedor INT REFERENCES GESTAO_STOCK.Fornecedor(NIF),
Designacao_fornecedor VARCHAR(40),
);

CREATE TABLE GESTAO_STOCK.Metodo_pagamento(
ID_pagamento INT REFERENCES GESTAO_STOCK.Fornecedor(NIF),
Designacao_pagamento VARCHAR(40),
);

CREATE TABLE GESTAO_STOCK.Encomenda(
N_encomenda INT PRIMARY KEY NOT NULL,
N_fornecedor INT REFERENCES GESTAO_STOCK.Fornecedor(NIF),
Data_encomenda DATE,
);

CREATE TABLE GESTAO_STOCK.Produto(
Codigo_produto INT PRIMARY KEY NOT NULL,
Nome_produto VARCHAR(40),
Preco_produto FLOAT,
Taxa_IVA INT,
Stock INT,
);

CREATE TABLE GESTAO_STOCK.Tem(
N_encomenda_tem INT REFERENCES GESTAO_STOCK.Encomenda(N_encomenda),
Codigo_produto_tem INT REFERENCES GESTAO_STOCK.Produto(Codigo_produto),
Quantidade INT,
PRIMARY KEY(N_encomenda_tem, Codigo_produto_tem),
);


