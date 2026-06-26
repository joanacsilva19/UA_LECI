# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
SELECT * FROM authors;

```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
SELECT au_fname, au_lname, phone FROM authors;
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
SELECT au_fname, au_lname, phone FROM authors ORDER BY au_fname, au_lname;
```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone FROM authors;
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone, [state] as estado FROM authors WHERE ([state] = 'CA' AND au_lname <> 'Ringer');
```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
SELECT * FROM publishers WHERE pub_name LIKE '%Bo%';
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
SELECT pub_name FROM publishers as p, titles as t WHERE p.pub_id = t.pub_id AND t.type = 'Business' GROUP BY pub_name;
```

### *h)* Número total de vendas de cada editora; 

```
SELECT pub_name, SUM(s.qty) as vendas FROM publishers, titles as t, sales as s WHERE s.title_id = t.title_id GROUP BY pub_name;
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
SELECT pub_name, t.title as titulo, SUM(qty) as vendas FROM publishers, titles as t, sales as s WHERE s.title_id = t.title_id GROUP BY t.title, pub_name;
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
SELECT title as title_name FROM stores as s, sales, titles WHERE s.stor_name = 'Bookbeat' AND s.stor_id = sales.stor_id AND sales.title_id = titles.title_id;
```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
SELECT au_fname, au_lname FROM authors as a, titleauthor as ta, titles as t WHERE a.au_id = ta.au_id AND ta.title_id <> t.title_id GROUP BY au_fname, au_lname;
```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
SELECT t.[type], t.pub_id, AVG(t.price) AS preco_medio, SUM(s.qty) AS total_vendas FROM titles AS t INNER JOIN sales AS s ON t.title_id = s.title_id GROUP BY t.[type], t.pub_id;
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
SELECT [type] FROM titles GROUP BY [type] HAVING MAX(advance) > (AVG(advance) * 1.5);
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
SELECT t.title, SUM((t.price * t.ytd_sales) * (t.royalty / 100.0) * (ta.royaltyper / 100.0)) AS valor_arrecadado FROM authors AS a INNER JOIN titleauthor AS ta ON a.au_id = ta.au_id INNER JOIN titles AS t ON ta.title_id = t.title_id WHERE t.price IS NOT NULL AND t.ytd_sales IS NOT NULL GROUP BY t.title;
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
SELECT title, ytd_sales, (ytd_sales * price) AS faturacao, (ytd_sales * price * royalty / 100) AS auth_revenue, (ytd_sales * price * (100 - royalty) / 100) AS publisher_revenue FROM titles WHERE ytd_sales IS NOT NULL AND price IS NOT NULL;
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
SELECT t.title, t.ytd_sales, a.au_fname + ' ' + a.au_lname AS author, (t.ytd_sales * t.price * t.royalty / 100) * (ta.royaltyper / 100.0) AS auth_revenue,(t.ytd_sales * t.price) * (1 - t.royalty / 100.0) AS publisher_revenue FROM titles t INNER JOIN titleauthor ta ON t.title_id = ta.title_id INNER JOIN authors a ON ta.au_id = a.au_id WHERE t.ytd_sales IS NOT NULL AND t.price IS NOT NULL;
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
SELECT s.stor_name FROM stores s INNER JOIN sales sa ON s.stor_id = sa.stor_id GROUP BY s.stor_id, s.stor_name HAVING COUNT(DISTINCT sa.title_id) = (SELECT COUNT(*) FROM titles);
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
SELECT s.stor_name, SUM(sa.qty) FROM stores s INNER JOIN sales sa ON s.stor_id = sa.stor_id GROUP BY s.stor_id, s.stor_name HAVING SUM(sa.qty) > (SELECT AVG(VendasPorLoja.TotalVendido) FROM ( SELECT SUM(qty) FROM sales GROUP BY stor_id));
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
SELECT title FROM titles WHERE title_id NOT IN ( SELECT sa.title_id FROM sales sa INNER JOIN stores s ON sa.stor_id = s.stor_id WHERE s.stor_name = 'Bookbeat');
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
SELECT p.pub_name, s.stor_name FROM publishers p CROSS JOIN stores s WHERE NOT EXISTS ( SELECT 1 FROM sales sa INNER JOIN titles t ON sa.title_id = t.title_id WHERE sa.stor_id = s.stor_id AND t.pub_id = p.pub_id) ORDER BY p.pub_name, s.stor_name;
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT Pname, Ssn, Fname, Minit, Lname FROM project, works_on, employee WHERE Pnumber = Pno AND Essn = Ssn;
```

##### *b)* 

```
SELECT sub.Fname, sub.Minit, sub.Lname FROM employee sub INNER JOIN employee sup ON sub.Super_ssn = sup.Ssn WHERE sup.Fname = 'Carlos' AND sup.Minit = 'D' AND sup.Lname = 'Gomes';
```

##### *c)* 

```
SELECT p.Pname, SUM(w.Hours) AS Total_Horas FROM project p INNER JOIN works_on w ON p.Pnumber = w.Pno GROUP BY p.Pname;
```

##### *d)* 

```
SELECT e.Fname, e.Minit, e.Lname FROM employee e INNER JOIN works_on w ON e.Ssn = w.Essn INNER JOIN project p ON w.Pno = p.Pnumber WHERE e.Dno = 3 AND w.Hours > 20 AND p.Pname = 'Aveiro Digital';
```

##### *e)* 

```
SELECT Fname, Minit, LnameFROM employee WHERE Ssn NOT IN (SELECT Essn FROM works_on WHERE Essn IS NOT NULL);
```

##### *f)* 

```
SELECT d.Dname, AVG(e.Salary) AS Media_Salarial FROM employee e INNER JOIN department d ON e.Dno = d.Dnumber WHERE e.Sex = 'F'GROUP BY d.Dname;
```

##### *g)* 

```
SELECT e.Fname, e.Minit, e.Lname FROM employee e INNER JOIN dependent d ON e.Ssn = d.Essn GROUP BY e.Ssn, e.Fname, e.Minit, e.Lname HAVING COUNT(d.Dependent_name) > 2;
```

##### *h)* 

```
SELECT e.Fname, e.Minit, e.Lname FROM employee e INNER JOIN department d ON e.Ssn = d.Mgr_ssn WHERE NOT EXISTS (SELECT 1 FROM dependent dep WHERE dep.Essn = e.Ssn);
```

##### *i)* 

```
SELECT Fname, Minit, Lname, Address FROM employee WHERE Ssn IN (SELECT w.Essn FROM works_on w INNER JOIN project p ON w.Pno = p.Pnumber WHERE p.Plocation = 'Aveiro') AND Ssn NOT IN (SELECT e.Ssn FROM employee e INNER JOIN dept_location dl ON e.Dno = dl.Dnumber WHERE dl.Dlocation = 'Aveiro' AND e.Ssn IS NOT NULL);
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT Nome_fornecedor FROM Fornecedor WHERE NIF NOT IN (SELECT N_fornecedor FROM Encomendas WHERE N_fornecedor IS NOT NULL);
```

##### *b)* 

```
SELECT p.Nome, AVG(t.Quantidade) AS Media_Unidades FROM Produto p INNER JOIN tem t ON p.Código = t.Código_produto GROUP BY p.Nome;
```


##### *c)* 

```
SELECT AVG(CAST(Contagem.Num_Produtos AS FLOAT)) AS Media_Produtos_Por_Encomenda FROM (SELECT N_encomenda, COUNT(Código_produto) AS Num_Produtos FROM tem GROUP BY N_encomenda);
```


##### *d)* 

```
SELECT f.Nome_fornecedor, p.Nome, t.Quantidade FROM Fornecedor f INNER JOIN Encomendas e ON f.NIF = e.N_fornecedor INNER JOIN tem t ON e.N_encomenda = t.N_encomenda INNER JOIN Produto p ON t.Código_produto = p.Código;
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT numUtente, nome FROM paciente WHERE numUtente NOT IN (SELECT numUtente FROM prescricao WHERE numUtente IS NOT NULL);
```

##### *b)* 

```
SELECT m.especialidade, COUNT(p.numPresc) AS total FROM medico m INNER JOIN prescricao p ON m.numMedico = p.numMedico GROUP BY m.especialidade;
```


##### *c)* 

```
SELECT f.nome, COUNT(p.numPresc) AS total FROM farmacia f INNER JOIN prescricao p ON f.numFarmacia = p.numFarmacia GROUP BY f.nome;
```


##### *d)* 

```
SELECT nomeFarmaco FROM presc_farmaco WHERE numRegFarm NOT IN (SELECT numReg FROM farmaceutica WHERE numReg = 906);
```

##### *e)* 

```
SELECT p.farmacia, f.nome, COUNT(fm.numRegFarm) AS total FROM prescricao p INNER JOIN farmaco fm ON p.numPresc = fm.numPresc INNER JOIN farmaceutica f ON fm.numRegFarm = f.numReg GROUP BY p.farmacia, f.nome;
```

##### *f)* 

```
SELECT pa.nome FROM paciente pa INNER JOIN prescricao pr ON pa.numUtente = pr.numUtente GROUP BY pa.numUtente, pa.nome HAVING COUNT(DISTINCT pr.numMedico) >= 2;
```
