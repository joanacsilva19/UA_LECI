CREATE SCHEMA GESTAO_CONF
GO

CREATE TABLE GESTAO_CONF.Instituicao (
    Nome VARCHAR(150) PRIMARY KEY,
    Endereco VARCHAR(255)
);

CREATE TABLE GESTAO_CONF.Autor (
    Email VARCHAR(100) PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Nome_Instituicao VARCHAR(150),
    FOREIGN KEY (Nome_Instituicao) REFERENCES GESTAO_CONF.Instituicao(Nome)
);

CREATE TABLE GESTAO_CONF.Artigo_Cientifico (
    Numero_Registo INT PRIMARY KEY,
    Titulo VARCHAR(255) NOT NULL
);

CREATE TABLE GESTAO_CONF.Escreve (
    Email_Autor VARCHAR(100),
    Num_Registo_Artigo INT,
    PRIMARY KEY (Email_Autor, Num_Registo_Artigo),
    FOREIGN KEY (Email_Autor) REFERENCES GESTAO_CONF.Autor(Email),
    FOREIGN KEY (Num_Registo_Artigo) REFERENCES GESTAO_CONF.Artigo_Cientifico(Numero_Registo)
);

CREATE TABLE GESTAO_CONF.Participante (
    Email VARCHAR(100) PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Morada VARCHAR(255),
    Data_Inscricao DATE,
    Nome_Instituicao VARCHAR(150),
    FOREIGN KEY (Nome_Instituicao) REFERENCES GESTAO_CONF.Instituicao(Nome)
);

CREATE TABLE GESTAO_CONF.Estudante (
    Email_Participante VARCHAR(100) PRIMARY KEY,
    Localizacao_Comprovativo VARCHAR(255),
    FOREIGN KEY (Email_Participante) REFERENCES GESTAO_CONF.Participante(Email)
);


CREATE TABLE GESTAO_CONF.Nao_Estudante (
    Email_Participante VARCHAR(100) PRIMARY KEY,
    Referencia_Bancaria VARCHAR(50),
    FOREIGN KEY (Email_Participante) REFERENCES GESTAO_CONF.Participante(Email)
);

