CREATE SCHEMA PRESC_MEDIC
GO

CREATE TABLE PRESC_MEDIC.Medico (
    No_SNS INT PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    Especialidade VARCHAR(100)
);

CREATE TABLE PRESC_MEDIC.Paciente (
    No_utente INT PRIMARY KEY,
    Nome_paciente VARCHAR(150) NOT NULL,
    Data_paciente DATE,
    Endereco_paciente VARCHAR(255)
);

CREATE TABLE PRESC_MEDIC.Farmacia (
    NIF INT PRIMARY KEY,
    Nome_farmacia VARCHAR(150) NOT NULL,
    Telefone_farmacia VARCHAR(20),
    Endereco_farmacia VARCHAR(255)
);

CREATE TABLE PRESC_MEDIC.Farmaceutica (
    No_registo INT PRIMARY KEY,
    Nome_farmaceutica VARCHAR(150) NOT NULL,
    Telefone_farmaceutica VARCHAR(20),
    Endereco_farmaceutica VARCHAR(255)
);

CREATE TABLE PRESC_MEDIC.Farmaco (
    Nome_farmaco VARCHAR(150) PRIMARY KEY,
    Formula TEXT,
    No_registo_farmaceutica_k INT,
    FOREIGN KEY (No_registo_farmaceutica_k) REFERENCES PRESC_MEDIC.Farmaceutica(No_registo)
);

CREATE TABLE PRESC_MEDIC.Prescricao (
    No_prescricao INT PRIMARY KEY,
    Data_prescricao DATE NOT NULL,
    No_SNS_k INT,
    No_utente_k INT,
    NIF_farmacia_k INT,
    FOREIGN KEY (No_SNS_k) REFERENCES PRESC_MEDIC.Medico(No_SNS),
    FOREIGN KEY (No_utente_k) REFERENCES PRESC_MEDIC.Paciente(No_utente),
    FOREIGN KEY (NIF_farmacia_k) REFERENCES PRESC_MEDIC.Farmacia(NIF)
);

CREATE TABLE PRESC_MEDIC.Vende (
    NIF_k INT,
    Nome_farmaco_k VARCHAR(150),
    PRIMARY KEY (NIF_k, Nome_farmaco_k),
    FOREIGN KEY (NIF_k) REFERENCES PRESC_MEDIC.Farmacia(NIF),
    FOREIGN KEY (Nome_farmaco_k) REFERENCES PRESC_MEDIC.Farmaco(Nome_farmaco)
);

CREATE TABLE PRESC_MEDIC.Tem (
    No_prescricao_k INT,
    Nome_farmaco_k VARCHAR(150),
    PRIMARY KEY (No_prescricao_k, Nome_farmaco_k),
    FOREIGN KEY (No_prescricao_k) REFERENCES PRESC_MEDIC.Prescricao(No_prescricao),
    FOREIGN KEY (Nome_farmaco_k) REFERENCES PRESC_MEDIC.Farmaco(Nome_farmaco)
);

