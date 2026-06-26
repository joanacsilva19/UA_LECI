--CREATE DATABASE Encomendas;
USE Encomendas;

CREATE TABLE tipo_fornecedor (
    codigo INT PRIMARY KEY,
    designacao VARCHAR(100)
);

CREATE TABLE fornecedor (
    nif INT PRIMARY KEY,
    nome VARCHAR(100),
    fax VARCHAR(20),
    endereco VARCHAR(200),
    condpag VARCHAR(50),
    tipo INT,
    FOREIGN KEY (tipo) REFERENCES tipo_fornecedor(codigo)
);

CREATE TABLE produto (
    codigo INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10, 2),
    iva INT,
    unidades INT
);

CREATE TABLE encomenda (
    numero INT PRIMARY KEY,
    data DATE,
    fornecedor INT,
    FOREIGN KEY (fornecedor) REFERENCES fornecedor(nif)
);

CREATE TABLE item (
    numEnc INT,
    codProd INT,
    unidades INT,
    PRIMARY KEY (numEnc, codProd),
    FOREIGN KEY (numEnc) REFERENCES encomenda(numero),
    FOREIGN KEY (codProd) REFERENCES produto(codigo)
);