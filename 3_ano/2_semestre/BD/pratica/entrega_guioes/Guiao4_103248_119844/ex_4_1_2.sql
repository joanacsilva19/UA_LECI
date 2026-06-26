--CREATE SCHEMA RESERVAS_VOOS;
--GO

CREATE TABLE RESERVAS_VOOS.Airport(
Airport_code INT PRIMARY KEY,
City VARCHAR(20) NOT NULL,
[State] VARCHAR(20) NOT NULL,
Name_airport VARCHAR(20) NOT NULL,
);

CREATE TABLE RESERVAS_VOOS.Airplane_type(
[Type_name] VARCHAR(20) PRIMARY KEY,
Max_seats INT NOT NULL,
Company VARCHAR(40),
);

CREATE TABLE RESERVAS_VOOS.Can_land(
Airport_code_can_land INT REFERENCES RESERVAS_VOOS.Airport(Airport_code),
Type_name_can_land VARCHAR(20) REFERENCES RESERVAS_VOOS.Airplane_type([Type_name]),
PRIMARY KEY (Airport_code_can_land,Type_name_can_land),
);

CREATE TABLE RESERVAS_VOOS.Airplane(
Airplane_ID INT PRIMARY KEY,
Total_n_seats INT NOT NULL,
Type_name_k VARCHAR(20) REFERENCES RESERVAS_VOOS.Airplane_type([Type_name]),
);

CREATE TABLE RESERVAS_VOOS.Flight(
Number INT PRIMARY KEY,
Airline VARCHAR(20) NOT NULL,
Type_name_flight VARCHAR(20) NOT NULL,
);

CREATE TABLE RESERVAS_VOOS.Flight_leg(
Flight_number INT,
Leg_number INT NOT NULL,
Sch_dep_time TIME NOT NULL,
Sch_arr_time TIME NOT NULL,
Dep_airport_code INT REFERENCES RESERVAS_VOOS.Airport(Airport_code) NOT NULL,
Arr_airport_code INT REFERENCES RESERVAS_VOOS.Airport(Airport_code) NOT NULL,
FOREIGN KEY (Flight_number) REFERENCES RESERVAS_VOOS.Flight(Number),
PRIMARY KEY (Flight_number,Leg_number),
);

CREATE TABLE RESERVAS_VOOS.Leg_instance(
Flight_number_instance INT,
Leg_number_instance INT,
Date_leg_instance DATE NOT NULL,
Num_avaliable_seats INT NOT NULL,
Airplane_ID_instance INT REFERENCES RESERVAS_VOOS.Airplane(Airplane_ID),
Dep_airport_code_instance INT REFERENCES RESERVAS_VOOS.Airport(Airport_code) NOT NULL,
Arr_airport_code_instance INT REFERENCES RESERVAS_VOOS.Airport(Airport_code) NOT NULL,
PRIMARY KEY(Flight_number_instance,Leg_number_instance,Date_leg_instance),
FOREIGN KEY(Flight_number_instance,Leg_number_instance) REFERENCES RESERVAS_VOOS.Flight_leg(Flight_number,Leg_number),
);

CREATE TABLE RESERVAS_VOOS.Fare(
Flight_number_fare INT,
Code INT,
Amount INT,
Restrictions TEXT,
FOREIGN KEY(Flight_number_fare) REFERENCES RESERVAS_VOOS.Flight(Number),
PRIMARY KEY (Flight_number_fare, Code),
);

CREATE TABLE RESERVAS_VOOS.Reservation(
Flight_number_reservation INT,
Leg_number_reservation INT,
Date_reservation DATE,
Seat_number INT,
Customer_name TEXT,
C_phone INT,
FOREIGN KEY (Flight_number_reservation, Leg_number_reservation) REFERENCES RESERVAS_VOOS.Flight_leg(Flight_number,Leg_number),
PRIMARY KEY (Flight_number_reservation,Leg_number_reservation),
);