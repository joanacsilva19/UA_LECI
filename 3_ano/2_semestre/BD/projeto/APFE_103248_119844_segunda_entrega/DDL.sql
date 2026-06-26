-- CREATE DATABASE GESTAO_EVENTOS;

USE GESTAO_EVENTOS;
GO

----------------------- DDL --------------------------

CREATE TABLE Cliente(
NIF VARCHAR(9) PRIMARY KEY NOT NULL,
Nome_cliente VARCHAR(40) NOT NULL,
Email VARCHAR(40) NOT NULL,
Telefone VARCHAR(9) NOT NULL,
);

ALTER TABLE Cliente
ADD CONSTRAINT DF_EMAIL_CHECK
CHECK (Email LIKE '%@%.%');

ALTER TABLE Cliente
ADD CONSTRAINT CHK_NIF_Numerico
CHECK (NIF NOT LIKE '%[^0-9]%');

ALTER TABLE Cliente
ADD CONSTRAINT CHK_Telefone_Numerico
CHECK (Telefone NOT LIKE '%[^0-9]%');

CREATE TABLE [Local](
ID_local INT PRIMARY KEY NOT NULL,
Nome_local VARCHAR(20) NOT NULL,
Morada VARCHAR(40) NOT NULL,
Max_capacidade INT NOT NULL,
Preco_local INT NOT NULL,
);

CREATE TABLE Atividade(
ID_atividade INT PRIMARY KEY NOT NULL,
Preco_atividade INT NOT NULL,
);

ALTER TABLE Atividade
ADD CONSTRAINT DF_Preco_atividade_zero
DEFAULT 0 FOR Preco_atividade;


CREATE TABLE Tipo_evento(
ID_tipo_evento INT PRIMARY KEY NOT NULL,
Nome_tipo_evento VARCHAR(20) NOT NULL,
);

CREATE TABLE Tem_atividade(
Tipo_evento_tem_atividade INT REFERENCES Tipo_evento(ID_tipo_evento),
Atividade_tem_atividade INT REFERENCES Atividade(ID_atividade),
PRIMARY KEY (Tipo_evento_tem_atividade, Atividade_tem_atividade),
);

CREATE TABLE Evento(
ID_evento INT PRIMARY KEY NOT NULL,
Data_evento DATE NOT NULL,
Hora_evento TIME NOT NULL,
Participantes INT NOT NULL,
Cliente_evento VARCHAR(9) REFERENCES Cliente(NIF),
Local_evento INT REFERENCES [Local](ID_local),
);

-- ter a certeza de que a data do evento existe atualmente
ALTER TABLE Evento 
ADD CONSTRAINT CHK_Data_Futura 
CHECK (Data_evento >= CAST(GETDATE() AS DATE));

-- pode ser um casamento, batizado, festa de anos, etc etc...
CREATE TABLE Classifica(
ID_tipo_classifica INT REFERENCES Tipo_evento(ID_tipo_evento),
ID_evento_classifica INT REFERENCES Evento(ID_evento),
PRIMARY KEY (ID_tipo_classifica, ID_evento_classifica),
);

CREATE TABLE Inclui(
ID_evento_inclui INT REFERENCES Evento(ID_evento),
ID_atividade_inclui INT REFERENCES Atividade(ID_atividade),
PRIMARY KEY (ID_evento_inclui, ID_atividade_inclui),
);

CREATE TABLE Musica(
preco_musica INT NOT NULL,
n_horas INT NOT NULL,
ID_atividade_musica INT REFERENCES Atividade(ID_atividade),
PRIMARY KEY(ID_atividade_musica),
);

ALTER TABLE Musica
ADD CONSTRAINT DF_DEFAULT_PRECO_MUSICA_0
DEFAULT 0 FOR preco_musica;

ALTER TABLE Musica
ADD CONSTRAINT DF_DEFAULT_N_HORAS_0
DEFAULT 0 FOR n_horas;


CREATE TABLE Banda(
preco_banda INT NOT NULL,
ID_atividade_banda INT REFERENCES Musica(ID_atividade_musica),
PRIMARY KEY (ID_atividade_banda),
);

CREATE TABLE DJ(
preco_DJ INT NOT NULL,
ID_atividade_DJ INT REFERENCES Musica(ID_atividade_musica),
PRIMARY KEY (ID_atividade_DJ),
);

CREATE TABLE Fotografia(
preco_fotografia INT NOT NULL,
n_sessoes INT NOT NULL,
altura_dia VARCHAR(20) NOT NULL,
preco_sessao INT NOT NULL,
ID_atividade_fotografia INT REFERENCES Atividade(ID_atividade),
PRIMARY KEY (ID_atividade_fotografia),
);

ALTER TABLE Fotografia
ADD CONSTRAINT DF_Preco_fotografia_0
DEFAULT 0 FOR preco_fotografia;

ALTER TABLE Fotografia
ADD CONSTRAINT DF_n_sessoes_1
DEFAULT 1 FOR n_sessoes;


CREATE TABLE Tema(
ID_tipo_tema INT PRIMARY KEY NOT NULL,
preco_tema INT NOT NULL,
);

CREATE TABLE Animacao(
preco_animacao INT NOT NULL,
n_horas_animacao INT NOT NULL,
n_animadores INT NOT NULL,
ID_tipo_tema_animacao INT REFERENCES Tema(ID_tipo_tema),
ID_atividade_animacao INT REFERENCES Atividade(ID_atividade),
PRIMARY KEY (ID_atividade_animacao),
);

ALTER TABLE Animacao
ADD CONSTRAINT DF_PRECO_ANIMACAO_0
DEFAULT 0 FOR preco_animacao;

ALTER TABLE Animacao
ADD CONSTRAINT DF_N_HORAS_ANIMACAO_1
DEFAULT 1 FOR n_horas_animacao;

ALTER TABLE Animacao
ADD CONSTRAINT DF_N_ANIMADORES_1
DEFAULT 1 FOR n_animadores;


CREATE TABLE Menu(
preco_menu INT NOT NULL,
n_menu INT PRIMARY KEY NOT NULL,
);

CREATE TABLE Catering(
preco_catering INT NOT NULL,
n_menu_catering INT REFERENCES Menu(n_menu),
ID_atividade_catering INT REFERENCES Atividade(ID_atividade),
PRIMARY KEY (ID_atividade_catering),
);

ALTER TABLE Catering
ADD CONSTRAINT DF_PRECO_CATERING_0
DEFAULT 0 FOR preco_catering;
