
INSERT INTO medico (numSNS, nome, especialidade) VALUES 
(1001, 'Dr. João Silva', 'Clínica Geral'),
(1002, 'Dra. Maria Santos', 'Pediatria'),
(1003, 'Dr. Ricardo Pereira', 'Cardiologia'),
(1004, 'Dra. Ana Costa', 'Dermatologia'),
(1005, 'Dr. Paulo Jorge', 'Neurologia');

INSERT INTO paciente (numUtente, nome, dataNasc, endereco) VALUES 
(2001, 'Carlos Meireles', '1985-05-12', 'Rua de Aveiro, 10'),
(2002, 'Beatriz Sousa', '1992-11-23', 'Av. Dr. Lourenço Peixinho, 45'),
(2003, 'Fernando Rocha', '1970-02-08', 'Rua Direita, 102'),
(2004, 'Helena Ramos', '1965-09-15', 'Praceta das Flores, 5'),
(2005, 'Tiago Almeida', '2000-12-01', 'Rua do Sol, 22'),
(2006, 'Margarida Vale', '1998-03-30', 'Bairro de Santiago, Bloco B'),
(2007, 'José Manuel', '1955-07-20', 'Rua da Estação, 89'),
(2008, 'Sofia Lopes', '1988-10-10', 'Travessa do Porto, 12'),
(2009, 'Rui Mendes', '1995-01-25', 'Rua das Oliveiras, 33'),
(2010, 'Inês Antunes', '2015-06-05', 'Av. da República, 100');

INSERT INTO farmaceutica (numReg, nome, endereco, telefone) VALUES 
(3001, 'PharmaCore SA', 'Zona Industrial de Coimbra', '239400500'),
(3002, 'BioMedica Portugal', 'Parque das Nações, Lisboa', '210900800'),
(3003, 'EuroHealth Lda', 'Maia Business Park', '220700600'),
(3004, 'GlobalMeds', 'Estrada de Sintra, 50', '219500400'),
(3005, 'Vitalis Lab', 'Rua de Braga, 12', '253100200');

INSERT INTO farmacia (nif, nome, endereco, telefone) VALUES 
(500000001, 'Farmácia Central de Aveiro', 'Praça da República', '234101202'),
(500000002, 'Farmácia Moderna', 'Rua do Comércio, Porto', '220303404'),
(500000003, 'Farmácia Saúde Viva', 'Av. de Roma, Lisboa', '210505606'),
(500000004, 'Farmácia Alentejana', 'Rua Direita, Évora', '266707808'),
(500000005, 'Farmácia do Povo', 'Rua Principal, Faro', '289909010');

INSERT INTO farmaco (numRegFarm, nome, formula) VALUES 
(3001, 'Paracetamol Pharma', 'C8H9NO2'),
(3001, 'Ibuprofeno Core', 'C13H18O2'),
(3002, 'Amoxicilina Bio', 'C16H19N3O5S'),
(3002, 'Bio-Zinco', 'Zn-Formula-B'),
(3003, 'Euro-Insulina', 'Peptídeo-H'),
(3003, 'Aspirina Euro', 'C9H8O4'),
(3004, 'Global-Statina', 'S-Comp-01'),
(3004, 'Global-Relief', 'R-Comp-X'),
(3005, 'Vital-Vitamina C', 'C6H8O6'),
(3005, 'Vital-Dorme', 'Melatonina-V');

INSERT INTO prescricao (numPresc, data, numUtente, numMedico, nifFarmacia, dataProc) VALUES 
(10001, '2024-04-01', 2001, 1001, 500000001, '2024-04-02'),
(10002, '2024-04-05', 2002, 1002, 500000002, '2024-04-05'),
(10003, '2024-04-10', 2003, 1003, NULL, NULL),
(10004, '2024-04-12', 2004, 1004, 500000003, '2024-04-13'),
(10005, '2024-04-15', 2005, 1005, 500000005, '2024-04-16'),
(10006, '2024-04-18', 2006, 1001, NULL, NULL),
(10007, '2024-04-20', 2007, 1003, 500000001, '2024-04-20'),
(10008, '2024-04-21', 2008, 1002, 500000004, '2024-04-22'),
(10009, '2024-04-22', 2009, 1004, NULL, NULL),
(10010, '2024-04-23', 2010, 1002, 500000002, '2024-04-24');

INSERT INTO presc_farmaco (numPresc, numRegFarm, nomeFarmaco) VALUES 
(10001, 3001, 'Paracetamol Pharma'),
(10001, 3001, 'Ibuprofeno Core'),
(10002, 3002, 'Amoxicilina Bio'),
(10003, 3003, 'Euro-Insulina'),
(10004, 3004, 'Global-Statina');