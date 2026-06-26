--CREATE SCHEMA RENTCAR;
--GO

CREATE TABLE RENTCAR.Cliente(
NIF INT PRIMARY KEY NOT NULL,
Nome_Cliente VARCHAR(20) NOT NULL,
Endereco_Cliente VARCHAR(40),
Num_carta INT NOT NULL,
);

CREATE TABLE RENTCAR.Balcao(
Numero INT PRIMARY KEY NOT NULL,
Nome_Balcao VARCHAR(20) NOT NULL,
Endereco_Balcao VARCHAR(40) NOT NULL,
);

CREATE TABLE RENTCAR.Tipo_veiculo(
Codigo_veiculo INT PRIMARY KEY,
Designacao VARCHAR(40),
Ar_condicionado VARCHAR(10),
);

CREATE TABLE RENTCAR.Veiculo(
Matricula INT PRIMARY KEY NOT NULL,
Marca VARCHAR(20) NOT NULL,
Ano INT,
Tipo_veiculo_k INT REFERENCES RENTCAR.Tipo_veiculo(Codigo_veiculo) NOT NULL,
);


CREATE TABLE RENTCAR.Similaridade(
codigo_n INT REFERENCES RENTCAR.Tipo_veiculo(Codigo_veiculo),
codigo_m INT REFERENCES RENTCAR.Tipo_veiculo(Codigo_veiculo),
PRIMARY KEY (codigo_n,codigo_m),
);

CREATE TABLE RENTCAR.Ligeiro(
Codigo_veiculo_L_K INT REFERENCES RENTCAR.Tipo_veiculo(Codigo_veiculo),
N_lugares INT NOT NULL,
Portas INT NOT NULL,
Combustivel VARCHAR(20) NOT NULL,
);

CREATE TABLE RENTCAR.Pesado(
Codigo_veiculo_P_K INT REFERENCES RENTCAR.Tipo_veiculo(Codigo_veiculo),
Peso INT NOT NULL,
Passageiros INT NOT NULL,
);

CREATE TABLE RENTCAR.Aluguer(
Numero INT PRIMARY KEY NOT NULL,
Data_aluguer DATE,
Duracao TIME,
NIF_K INT REFERENCES RENTCAR.Cliente(NIF),
N_Balcao_K INT REFERENCES RENTCAR.Balcao(Numero),
Matricula_aluguer INT REFERENCES RENTCAR.Veiculo(Matricula),
);