
-- a) Todos os tuplos da tabela autores (authors);
-- SELECT * FROM authors;

-- b) O primeiro nome, o último nome e o telefone dos autores;
-- SELECT au_fname, au_lname, phone FROM authors;

-- c) Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente);
-- SELECT au_fname, au_lname, phone FROM authors ORDER BY au_fname, au_lname;

-- d) Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone);
-- SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone FROM authors;

-- e) Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’;
-- SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone, [state] as estado FROM authors WHERE ([state] = 'CA' AND au_lname <> 'Ringer');

-- f) Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome;
-- SELECT * FROM publishers WHERE pub_name LIKE '%Bo%';

-- g) Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’;
-- SELECT pub_name FROM publishers as p, titles as t WHERE p.pub_id = t.pub_id AND t.type = 'Business' GROUP BY pub_name;

-- h) Número total de vendas de cada editora;
-- SELECT pub_name, SUM(s.qty) as vendas FROM publishers, titles as t, sales as s WHERE s.title_id = t.title_id GROUP BY pub_name;

-- i) Número total de vendas de cada editora agrupado por título;
-- SELECT pub_name, t.title as titulo, SUM(qty) as vendas FROM publishers, titles as t, sales as s WHERE s.title_id = t.title_id GROUP BY t.title, pub_name;

-- j) Nome dos títulos vendidos pela loja ‘Bookbeat’;
-- SELECT title as title_name FROM stores as s, sales, titles WHERE s.stor_name = 'Bookbeat' AND s.stor_id = sales.stor_id AND sales.title_id = titles.title_id;

-- k) Nome de autores que tenham publicações de tipos diferentes;
-- SELECT au_fname, au_lname FROM authors as a, titleauthor as ta, titles as t WHERE a.au_id = ta.au_id AND ta.title_id <> t.title_id GROUP BY au_fname, au_lname;

-- l) Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo(type) e editora (pub_id); 
-- SELECT t.[type], t.pub_id, AVG(t.price) AS preco_medio, SUM(s.qty) AS total_vendas FROM titles AS t INNER JOIN sales AS s ON t.title_id = s.title_id GROUP BY t.[type], t.pub_id;

-- m) Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);
-- SELECT [type] FROM titles GROUP BY [type] HAVING MAX(advance) > (AVG(advance) * 1.5);

--n) Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;
-- SELECT t.title, SUM((t.price * t.ytd_sales) * (t.royalty / 100.0) * (ta.royaltyper / 100.0)) AS valor_arrecadado FROM authors AS a INNER JOIN titleauthor AS ta ON a.au_id = ta.au_id INNER JOIN titles AS t ON ta.title_id = t.title_id WHERE t.price IS NOT NULL AND t.ytd_sales IS NOT NULL GROUP BY t.title;
