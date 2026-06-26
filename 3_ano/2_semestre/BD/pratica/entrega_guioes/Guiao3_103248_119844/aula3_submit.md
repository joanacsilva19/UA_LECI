# BD: Guião 3


## ​Problema 3.1
 
### *a)*

```

CLIENTE(nome, endereco, num_carta, NIF)
ALUGUER(data, numero, duracao, NIF_id, N_balcao_id, matricula_id)
BALCAO(nome, numero, endereco)
VEICULO(marca, matricula, ano, codigo_tipo_veiculo)
TIPO_VEICULO(designacao, arcondicionado, codigo)
SIMILARIDADE(codigo_tipo_veiculo_N, codigo_tipo_veiculo_M)
LIGEIRO(codigo_tipo_veiculo, num_lugares, portas, combustivel)
PESADO(codigo_tipo_veiculo, peso, passageiros)

```


### *b)* 

```
CLIENTE(nome, endereco, num_carta, NIF)

Chaves candidatas: NIF, num_carta
Chave primária: NIF
Chave estrangeira: 


ALUGUER(data, numero, duracao, NIF_id, N_balcao_id, matricula_id)

Chaves candidatas: numero
Chave primária: numero
Chave estrangeira: NIF_id, N_balcao_id, matricula_id


BALCAO(nome, numero, endereco)

Chaves candidatas: numero
Chave primária: numero
Chave estrangeira: 


VEICULO(marca, matricula, ano, codigo_tipo_veiculo)

Chaves candidatas: matricula
Chave primária: matricula
Chave estrangeira: codigo_tipo_veiculo


TIPO_VEICULO(designacao, arcondicionado, codigo)

Chaves candidatas: codigo
Chave primária: codigo
Chave estrangeira:


SIMILARIDADE(codigo_tipo_veiculo_N, codigo_tipo_veiculo_M)

Chaves candidatas: codigo_tipo_veiculo_N, codigo_tipo_veiculo_M
Chave primária: (codigo_tipo_veiculo_N, codigo_tipo_veiculo_M)
Chave estrangeira: codigo_tipo_veiculo_N, codigo_tipo_veiculo_M


LIGEIRO(codigo_tipo_veiculo, num_lugares, portas, combustivel)

Chaves candidatas: codigo_tipo_veiculo
Chave primária: codigo_tipo_veiculo
Chave estrangeira:


PESADO(codigo_tipo_veiculo, peso, passageiros)

Chaves candidatas: codigo_tipo_veiculo
Chave primária: codigo_tipo_veiculo
Chave estrangeira:

```


### *c)* 

![ex_3_1c!](ex_3_1c.jpg "AnImage")


## ​Problema 3.2

### *a)*

```
AIRPORT(Airport_code, City, State, Name)
AIRPLANE_TYPE(Type_name, Max_seats, Company)
AIRPLANE(Airplane_id, Total_no_of_seats, Type_name)
FLIGHT(Number, Airline, Weekdays)
FLIGHT_LEG(Flight_number, Leg_no, Sch_dep_timne, Sch_arr_time, Dep_airport_code, Arr_airport_code)
LEG_INSTANCE(Flight_number, Leg_no, DAte, No_of_avail_seats, Airplane_id, Dep_airport_code, Arr_airport_code, Dep_time, Arr_time)
FARE(Flight_number, Code, Amount, Restrictions)
RESERVATION(Flight_number, Leg_no, Date, Seat_no, Customer_name, Cphone)
CAN_LAND(Airport_code, Type_name)

```


### *b)* 

```
AIRPORT(Airport_code, City, State, Name)

Chaves candidatas: Airport_code
Chave primária: Airport_code
Chave estrangeira: 


AIRPLANE_TYPE(Type_name, Max_seats, Company)

Chaves candidatas: Type_name
Chave primária: Type_name
Chave estrangeira:


AIRPLANE(Airplane_id, Total_no_of_seats, Type_name)

Chaves candidatas: Airplane_id
Chave primária: Airplane_id
Chave estrangeira: Type_name


FLIGHT(Number, Airline, Weekdays)

Chaves candidatas: Number
Chave primária: Number
Chave estrangeira: 


FLIGHT_LEG(Flight_number, Leg_no, Sch_dep_timne, Sch_arr_time, Dep_airport_code, Arr_airport_code)

Chaves candidatas: (Flight_number, Leg_no)
Chave primária: (Flight_number, Leg_no)
Chave estrangeira: Flight_number, Dep_airport_code, Arr_airport_code


LEG_INSTANCE(Flight_number, Leg_no, DAte, No_of_avail_seats, Airplane_id, Dep_airport_code, Arr_airport_code, Dep_time, Arr_time)

Chaves candidatas: (Flight_number, Leg_no, Date)
Chave primária: (Flight_number, Leg_no, Date)
Chave estrangeira: (Flight_number, Leg_no), Airplane_id, Dep_airport_code, Arr_airport_code


FARE(Flight_number, Code, Amount, Restrictions)

Chaves candidatas: (Flight_number, Code)
Chave primária: (Flight_number, Code)
Chave estrangeira: Flight_number


RESERVATION(Flight_number, Leg_no, Date, Seat_no, Customer_name, Cphone)

Chaves candidatas: (Flight_number, Leg_no, Date, Seat_no)
Chave primária: (Flight_number, Leg_no, Date, Seat_no)
Chave estrangeira: (Flight_number, Leg_no, Date)


CAN_LAND(Airport_code, Type_name)

Chaves candidatas: (Airport_code, Type_name)
Chave primária: (Airport_code, Type_name)
Chave estrangeira: Airport_code, Type_name

```


### *c)* 

![ex_3_2c!](ex_3_2c.jpg "AnImage")


## ​Problema 3.3


### *a)* 2.1

![ex_3_3_a!](ex_3_3a.jpg "AnImage")

### *b)* 2.2

![ex_3_3_b!](ex_3_3b.jpg "AnImage")

### *c)* 2.3

![ex_3_3_c!](ex_3_3c.jpg "AnImage")

### *d)* 2.4

![ex_3_3_d!](ex_3_3d.jpg "AnImage")