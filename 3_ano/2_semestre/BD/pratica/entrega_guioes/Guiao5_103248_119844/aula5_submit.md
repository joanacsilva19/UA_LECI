# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
π Pname, Ssn, Fname, Minit, Lname (σ Pnumber=Pno and Essn=Ssn (project ⨯ works_on ⨯ employee))

```


### *b)* 

```
π Fname, Minit, Lname (σ Super_ssn=Ssn_sup (employee ⨯ (ρ Ssn_sup←Ssn (π Ssn (σ Fname='Carlos' and Minit='D' and Lname='Gomes' (employee))))))

```


### *c)* 

```
γ Pname; sum(Hours)->Total_Horas (project ⨝ Pnumber=Pno works_on)

```


### *d)* 

```
π Fname, Minit, Lname (σ Dno=3 and Hours>20 and Pname='Aveiro Digital' and Ssn=Essn and Pno=Pnumber (employee ⨯ works_on ⨯ project))

```


### *e)* 

```
π Fname, Minit, Lname (employee ⨝ (π Ssn (employee) - ρ Ssn←Essn (π Essn (works_on))))

```


### *f)* 

```
γ Dname; avg(Salary)->Media_Salarial (σ Dno=Dnumber and Sex='F' (employee ⨯ department))

```


### *g)* 

```
π Fname, Minit, Lname (employee ⨝ (σ Num_Deps > 2 (ρ Ssn←Essn (γ Essn; count(Dependent_name)->Num_Deps (dependent)))))

```


### *h)* 

```
π Fname, Minit, Lname (employee ⨝ ( (ρ Ssn←Mgr_ssn (π Mgr_ssn (department))) - (ρ Ssn←Essn (π Essn (dependent))) ))

```


### *i)* 

```
π Fname, Minit, Lname, Address (employee ⨝ ( (ρ Ssn←Essn (π Essn (σ Pno=Pnumber and Plocation='Aveiro' (works_on ⨯ project)))) - (π Ssn (σ Dno=Dnumber and Dlocation='Aveiro' (employee ⨯ dept_location))) ))

```


## ​Problema 5.2

### *a)*

```
π Nome_fornecedor (Fornecedor ⨝ ( (π NIF (Fornecedor)) - (ρ NIF←N_fornecedor (π N_fornecedor (Encomendas))) ))

```

### *b)* 

```
γ Nome; avg(Quantidade)->Media_Unidades (Produto ⨝ Código=Código_produto tem)

```


### *c)* 

```
γ avg(Num_Produtos)->Media_Produtos_Por_Encomenda (γ N_encomenda; count(Código_produto)->Num_Produtos (tem))
```


### *d)* 

```
π Nome_fornecedor, Nome, Quantidade (Fornecedor ⨝ NIF=N_fornecedor (Encomendas ⨝ N_encomenda=N_encomenda (tem ⨝ Código_produto=Código Produto)))

```


## ​Problema 5.3

### *a)*

```
π numUtente,nome ((π numUtente (paciente) - π numUtente (prescricao)) ⨝ paciente)
```

### *b)* 

```
γ especialidade; count(numPresc) -> total (medico ⨝ prescricao)

```


### *c)* 

```
γ nome; count(numPresc) -> total (farmacia ⨝ prescricao)

```


### *d)* 

```
π nomeFarmaco (presc_farmaco ⨝ numRegFarm ≠ numReg (σ farmaceutica.numReg = 906 (farmaceutica)))

```

### *e)* 

```
π prescricao.farmacia, farmaceutica.nome, total (γ prescricao.farmacia, farmaceutica.nome; count(farmaco.numRegFarm) -> total (prescricao ⨝ farmaco ⨝ numRegFarm = numReg (farmaceutica)))

```

### *f)* 

```
π nome (paciente ⨝ (π P1.numUtente (σ P1.numMedico ≠ P2.numMedico (ρ P1 (prescricao) ⨝ P1.numUtente = P2.numUtente ρ P2 (prescricao)))))

```
