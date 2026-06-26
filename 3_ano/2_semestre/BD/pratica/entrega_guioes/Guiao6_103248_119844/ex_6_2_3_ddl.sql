--CREATE DATABASE Medicamentos;
USE Medicamentos;

CREATE TABLE medico (
    numSNS INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50)
);

CREATE TABLE paciente (
    numUtente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    dataNasc DATE,
    endereco VARCHAR(200)
);

CREATE TABLE farmaceutica (
    numReg INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(20)
);

CREATE TABLE farmacia (
    nif INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200),
    telefone VARCHAR(20)
);

CREATE TABLE farmaco (
    numRegFarm INT,
    nome VARCHAR(100),
    formula VARCHAR(255),
    PRIMARY KEY (numRegFarm, nome),
    FOREIGN KEY (numRegFarm) REFERENCES farmaceutica(numReg)
);

CREATE TABLE prescricao (
    numPresc INT PRIMARY KEY,
    data DATE NOT NULL,
    numUtente INT NOT NULL,
    numMedico INT NOT NULL,
    nifFarmacia INT,
    dataProc DATE,
    FOREIGN KEY (numUtente) REFERENCES paciente(numUtente),
    FOREIGN KEY (numMedico) REFERENCES medico(numSNS),
    FOREIGN KEY (nifFarmacia) REFERENCES farmacia(nif)
);

CREATE TABLE presc_farmaco (
    numPresc INT,
    numRegFarm INT,
    nomeFarmaco VARCHAR(100),
    PRIMARY KEY (numPresc, numRegFarm, nomeFarmaco),
    FOREIGN KEY (numPresc) REFERENCES prescricao(numPresc),
    FOREIGN KEY (numRegFarm, nomeFarmaco) REFERENCES farmaco(numRegFarm, nome)
);