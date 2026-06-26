USE p7g1;
GO

--CREATE DATABASE PROJETO_GESTAO_EVENTOS;
--GO
----------------------- DDL --------------------------

CREATE TABLE PROJETO_GESTAO_EVENTOS.Cliente(
NIF VARCHAR(9) PRIMARY KEY NOT NULL,
Nome_cliente VARCHAR(40) NOT NULL,
Email VARCHAR(40) NOT NULL,
Telefone VARCHAR(9) NOT NULL,
);

ALTER TABLE PROJETO_GESTAO_EVENTOS.Cliente
ADD CONSTRAINT DF_EMAIL_CHECK
CHECK (Email LIKE '%@%.%');

ALTER TABLE PROJETO_GESTAO_EVENTOS.Cliente
ADD CONSTRAINT CHK_NIF_Numerico
CHECK (NIF NOT LIKE '%[^0-9]%');

ALTER TABLE PROJETO_GESTAO_EVENTOS.Cliente
ADD CONSTRAINT CHK_Telefone_Numerico
CHECK (Telefone NOT LIKE '%[^0-9]%');

CREATE TABLE PROJETO_GESTAO_EVENTOS.[Local](
ID_local INT PRIMARY KEY NOT NULL,
Nome_local VARCHAR(20) NOT NULL,
Morada VARCHAR(40) NOT NULL,
Max_capacidade INT NOT NULL,
Preco_local DECIMAL(10,2) NOT NULL,
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Atividade(
ID_atividade INT PRIMARY KEY NOT NULL,
Preco_atividade DECIMAL(10,2) NOT NULL DEFAULT 0,
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Tipo_evento(
ID_tipo INT PRIMARY KEY NOT NULL,
Nome_tipo_evento VARCHAR(20) NOT NULL,
);

-- associa o tipo de evento às suas atividades extra possíveis.
CREATE TABLE PROJETO_GESTAO_EVENTOS.Tem_atividade(
Tipo_evento_tem_atividade INT REFERENCES PROJETO_GESTAO_EVENTOS.Tipo_evento(ID_tipo),
Atividade_tem_atividade INT REFERENCES PROJETO_GESTAO_EVENTOS.Atividade(ID_atividade),
PRIMARY KEY (Tipo_evento_tem_atividade, Atividade_tem_atividade),
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Evento(
ID_evento INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
Data_hora_evento DATETIME NOT NULL,
Duracao_horas_evento INT NOT NULL,
Data_hora_fim_evento AS (DATEADD(HOUR, Duracao_horas_evento, Data_hora_evento)) PERSISTED, -- calcular o dia e a hora a que o evento termina
Participantes INT NOT NULL,
Cliente_evento VARCHAR(9) REFERENCES PROJETO_GESTAO_EVENTOS.Cliente(NIF),
Local_evento INT REFERENCES PROJETO_GESTAO_EVENTOS.[Local](ID_local),
ID_tipo_evento INT REFERENCES PROJETO_GESTAO_EVENTOS.Tipo_evento(ID_tipo)
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Inclui(
ID_evento_inclui INT REFERENCES PROJETO_GESTAO_EVENTOS.Evento(ID_evento),
ID_atividade_inclui INT REFERENCES PROJETO_GESTAO_EVENTOS.Atividade(ID_atividade),
PRIMARY KEY (ID_evento_inclui, ID_atividade_inclui),
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Musica(
preco_musica DECIMAL(10,2) NOT NULL DEFAULT 0,
n_horas INT NOT NULL DEFAULT 0,
ID_atividade_musica INT REFERENCES PROJETO_GESTAO_EVENTOS.Atividade(ID_atividade),
PRIMARY KEY(ID_atividade_musica),
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Banda(
preco_banda DECIMAL(10,2) NOT NULL,
ID_atividade_banda INT REFERENCES PROJETO_GESTAO_EVENTOS.Musica(ID_atividade_musica),
PRIMARY KEY (ID_atividade_banda),
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.DJ(
preco_DJ DECIMAL(10,2) NOT NULL,
ID_atividade_DJ INT REFERENCES PROJETO_GESTAO_EVENTOS.Musica(ID_atividade_musica),
PRIMARY KEY (ID_atividade_DJ),
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Fotografia(
preco_fotografia DECIMAL(10,2) NOT NULL DEFAULT 0,
n_sessoes INT NOT NULL,
altura_dia VARCHAR(20) NOT NULL,
preco_sessao DECIMAL(10,2) NOT NULL,
ID_atividade_fotografia INT REFERENCES PROJETO_GESTAO_EVENTOS.Atividade(ID_atividade),
PRIMARY KEY (ID_atividade_fotografia),
);

ALTER TABLE PROJETO_GESTAO_EVENTOS.Fotografia
ADD CONSTRAINT CHK_n_sessoes_positivo CHECK (n_sessoes > 0);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Tema(
ID_tipo_tema INT PRIMARY KEY NOT NULL,
preco_tema DECIMAL(10,2) NOT NULL,
);

ALTER TABLE PROJETO_GESTAO_EVENTOS.Tema
ADD nome_tema VARCHAR(30) NOT NULL;

CREATE TABLE PROJETO_GESTAO_EVENTOS.Animacao(
preco_animacao DECIMAL(10,2) NOT NULL DEFAULT 0,
n_horas_animacao INT NOT NULL DEFAULT 0,
n_animadores INT NOT NULL DEFAULT 0,
ID_tipo_tema_animacao INT REFERENCES PROJETO_GESTAO_EVENTOS.Tema(ID_tipo_tema),
ID_atividade_animacao INT REFERENCES PROJETO_GESTAO_EVENTOS.Atividade(ID_atividade),
PRIMARY KEY (ID_atividade_animacao),
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Menu(
preco_menu DECIMAL(10,2) NOT NULL,
n_menu INT PRIMARY KEY NOT NULL,
);

CREATE TABLE PROJETO_GESTAO_EVENTOS.Catering(
preco_catering DECIMAL(10,2) NOT NULL DEFAULT 0,
n_menu_catering INT REFERENCES PROJETO_GESTAO_EVENTOS.Menu(n_menu),
ID_atividade_catering INT REFERENCES PROJETO_GESTAO_EVENTOS.Atividade(ID_atividade),
PRIMARY KEY (ID_atividade_catering),
);
GO
