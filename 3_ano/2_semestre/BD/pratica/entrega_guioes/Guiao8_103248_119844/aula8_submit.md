# BD: Guião 8


## ​8.1
 
### *a)*

```
CREATE PROCEDURE 8_1_A @Ssn INT
AS
BEGIN
    DELETE FROM dependent 
    WHERE Essn = @Ssn;

    DELETE FROM works_on 
    WHERE Essn = @Ssn;

    DELETE FROM employee
    WHERE Ssn = @Ssn;
END;

No storage procedure, para além do foi mencionado, deve ter se em atenção se o que se está a eliminar realmente existe na tabela antes de ser eliminado. Também se o formato da variável @Ssn está correto.
```

### *b)* 

```
CREATE PROCEDURE 8_1_B
AS
BEGIN
    SELECT 
        e.Ssn, 
        e.Fname,
        e.Lname,
        d.Dname,
        DATEDIFF(YEAR, d.Mgr_start_date, GETDATE()) AS years_as_manager
    FROM employee AS e, 
    JOIN department AS d ON e.Ssn = d.Mgr_ssn;

    SELECT TOP 1 
        @OldestSSN = e.Ssn,
        @OldestYears = DATEDIFF(YEAR, d.Mgr_start_date, GETDATE())
    FROM employee AS e
    JOIN department AS d ON e.Ssn = d.Mgr_ssn ORDER BY d.Mgr_start_date ASC;
END;
```

### *c)* 

```
CREATE TRIGGER 8_1_C
ON department
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT Mgr_ssn
        FROM department
        WHERE Mgr_ssn IS NOT NULL
        GROUP BY Mgr_ssn
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR ('Erro: Este funcionário já é gestor de outro departamento.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
```

### *d)* 

```
CREATE TRIGGER 8_1_D
ON employee
AFTER INSERT, UPDATE
AS
BEGIN
    IF UPDATE(salary) OR UPDATE(Dno)
    BEGIN
        UPDATE e
        SET e.Salary = mgr.Salary - 1
        FROM employee AS e
        INNER JOIN inserted i ON e.Ssn = i.Ssn
        INNER JOIN department d ON i.Dno = d.Dnumber
        INNER JOIN employee mgr ON d.Mgr_ssn = mgr.Ssn
        WHERE i.Salary > mgr.Salary 
        AND i.Ssn <> mgr.Ssn;
    END
END;
GO
```

### *e)* 

```
CREATE FUNCTION 8_1_E (@EmployeeSSN VARCHAR(20)) RETURNS TABLE
AS
    RETURN
    (SELECT 
        p.Pname AS ProjectName, 
        p.Plocation AS ProjectLocation
    FROM PROJECT AA p
    INNER JOIN WORKS_ON AS w ON p.Pnumber = w.Pno
    WHERE w.Essn = @EmployeeSSN
    );
GO
```

### *f)* 

```
CREATE FUNCTION 8_1_F (@Dno INT) RETURNS TABLE
AS
    RETURN
    (SELECT 
        e.Fname, 
        e.Lname, 
        e.Ssn, 
        e.Salary
    FROM EMPLOYEE e
    WHERE e.Dno = @Dno
      AND e.Salary > (
          SELECT AVG(Salary)
          FROM EMPLOYEE
          WHERE Dno = @Dno
        )
);
```

### *g)* 

```
CREATE FUNCTION 8_1_G (@Dno INT) RETURNS @ResultTable TABLE 
(
    pname VARCHAR(50),
    pnumber INT,
    plocation VARCHAR(50),
    dnum INT,
    budget DECIMAL(10,2),
    totalbudget DECIMAL(10,2)
)
AS
BEGIN
    DECLARE @pname VARCHAR(50), @pnumber INT, @plocation VARCHAR(50), @dnum INT;
    DECLARE @budget DECIMAL(10,2);
    DECLARE @totalbudget DECIMAL(10,2) = 0;
    DECLARE cur_Projetos CURSOR FOR
        SELECT 
            P.Pname, 
            P.Pnumber, 
            P.Plocation, 
            P.Dnum,
            ISNULL(SUM((E.Salary / 40.0) * W.Hours), 0) AS budget
        FROM PROJECT P
        LEFT JOIN WORKS_ON W ON P.Pnumber = W.Pno
        LEFT JOIN EMPLOYEE E ON W.Essn = E.Ssn
        WHERE P.Dnum = @Dno
        GROUP BY P.Pname, P.Pnumber, P.Plocation, P.Dnum
        ORDER BY P.Pnumber;

    OPEN cur_Projetos;
    FETCH NEXT FROM cur_Projetos INTO @pname, @pnumber, @plocation, @dnum, @budget;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @totalbudget = @totalbudget + @budget;
        INSERT INTO @ResultTable (pname, pnumber, plocation, dnum, budget, totalbudget)
        VALUES (@pname, @pnumber, @plocation, @dnum, @budget, @totalbudget);
        FETCH NEXT FROM cur_Projetos INTO @pname, @pnumber, @plocation, @dnum, @budget;
    END;

    CLOSE cur_Projetos;
    DEALLOCATE cur_Projetos;

    RETURN;
END;
```

### *h)* 

```
CREATE TRIGGER 8_1_G_AD ON DEPARTMENT AFTER DELETE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'department_deleted')
    BEGIN
        CREATE TABLE dbo.department_deleted (
            Dname VARCHAR(50),
            Dnumber INT,
            Mgr_ssn INT,
            Mgr_start_date DATE
        );
    END
    INSERT INTO dbo.department_deleted (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
    SELECT Dname, Dnumber, Mgr_ssn, Mgr_start_date
    FROM deleted;
END;

CREATE TRIGGER 8_1_G_ID ON DEPARTMENT INSTEAD OF DELETE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'department_deleted')
    BEGIN
        CREATE TABLE dbo.department_deleted (
            Dname VARCHAR(50),
            Dnumber INT,
            Mgr_ssn INT,
            Mgr_start_date DATE
        );
    END

    INSERT INTO dbo.department_deleted (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
    SELECT Dname, Dnumber, Mgr_ssn, Mgr_start_date
    FROM deleted;
    DELETE FROM DEPARTMENT
    WHERE Dnumber IN (SELECT Dnumber FROM deleted);
END;

A principal diferença entre as duas abordagens está no momento de execução e no nível de controlo. O trigger AFTER é mais simples e direto, uma vez que delega a verificação de integridade referencial ao SGBD, mas tem a desvantagem de não chegar a ser executado caso a instrução de eliminação falhe por violação de chaves estrangeiras, bloqueando qualquer tentativa automática de resolver essas dependências. O trigger INSTEAD OF intercepta a operação antes da validação das restrições, permitindo implementar lógicas complexas, no entanto, tem a desvantagem de ser mais suscetível a erros de programação, pois a omissão da instrução de DELETE faz com que a operação reporte sucesso enquanto o registo original permanece indevidamente intacto na base de dados.
```

### *i)* 

```
Ambas as ferramentas são fundamentais no desenvolvimento de bases de dados relacionais, desenhadas para modularizar código SQL e promover a sua reutilização. Apesar das suas diferenças estruturais, ambas partilham benefícios cruciais, como a otimização de desempenho, uma vez que guardam o plano de execução na cache , tornando as execuções seguintes muito mais rápidas. Reduzem significativamente o tráfego de rede, permitindo que uma aplicação envie apenas uma chamada simples à base de dados em vez de dezenas de instruções complexas. Reforçam a segurança ao permitir a atribuição de permissões granulares de execução, evitando ataques de injeção SQL e sem necessidade de expor diretamente o acesso de leitura ou escrita nas tabelas subjacentes.

A principal diferença entre as duas ferramentas está no seu propósito, uma SP atua como um procedimento de automação que pode alterar o estado do sistema, enquanto uma UDF funciona como uma função matemática pura focada apenas na leitura, cálculo e formatação de dados. As SP permitem a modificação de dados através de instruções de criação, atualização e eliminação, suportam a gestão de transações e permitem o uso de blocos de tratamento de erros. Elas são a escolha ideal para executar ações transacionais ou gerir processos complexos com múltiplas etapas, com a garantia de que, se algo falhar, a operação é revertida na sua totalidade. São igualmente indicadas para rotinas de manutenção estruturais ou eliminações em cascata.

Por outro lado, as UDF estão estritamente limitadas a operações de leitura e estão proibidas de alterar qualquer estado na base de dados. Não suportam gestão de transações nem tratamento de erros, e exigem obrigatoriamente, o retorno de um resultado. Distinguem-se pela capacidade de serem integradas de forma perfeitamente natural dentro de instruções SQL padrão, podendo ser chamadas diretamente nas cláusulas de seleção, filtragem ou junção de dados. Assim, as UDF devem ser utilizadas sempre que for necessário encapsular lógicas de cálculo ou filtros que se pretendam reaproveitar. Exemplos de utilização incluem funções para calcular impostos sobre salários linha a linha numa lista de funcionários, funções de validação para verificar a formatação de um número de identificação fiscal, ou funções de tabela que atuem como vistas parametrizadas, como uma função que devolva rapidamente a lista de projetos associados a um determinado departamento para ser imediatamente cruzada com outras tabelas do sistema.
```
