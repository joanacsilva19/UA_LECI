# BD: Guião 7


## ​7.2 
 
### *a)*

```
A relação está na forma normal 1 (NF1), pois os seus atributos são atómicos e não existem relações dentro de relações.  
```

### *b)* 

```
*1NF - relação inicial*

Livro (_Titulo_Livro_, _Nome_Autor_, Afliacao_Autor, Tipo_Livro, Preco, NoPaginas, Editor, Endereco_Editor, Ano_Publicacao)

*2NF - remover DF parciais*

R1 (_Nome_Autor_, Afiliacao_Autor)
Livro (_Titulo_Livro_, _Nome_Autor_, Tipo_Livro, Preco, NoPaginas, Editor, Endereco_Editor, Ano_Publicacao)

*3NF - remover DF transitivas*

R1 (_Nome_Autor_, Afiliacao_Autor)
R2 (_Tipo_Livro_, _NoPaginas_, Preco)
R3 (_Editor_, Endereco_Editor)
Livro (_Titulo_Livro_, _Nome_Autor_, Tipo_Livro, NoPaginas, Editor, Ano_Publicacao)

```




## ​7.3
 
### *a)*

```
A chave da relação R é {A,B}.
```


### *b)* 

```
*2NF*
R1 (_A_, D, E, I, J)
R2 (_B_, F, G, H)
R (_A_, _B_, C)
```


### *c)* 

```
R1 (_A_, D, E)
R3 (_D_, I, J)
R2 (_B_, F)
R4 (_F_, G, H)
R (_A_, _B_, C)
```


## ​7.4
 
### *a)*

```
A chave da relação R é {A,B} ou {B, C}.
```


### *b)* 

```
R1 (_D_, E)
R2 (_A_, _B_, C, D)
```


### *c)* 

```
R1 (_D_, E)
R3 (_C_, A)
R4 (_B_, _C_, D)
```



## ​7.5
 
### *a)*

```
A chave da relação R é {A,B}.
```

### *b)* 

```
R1 (_A_, C, D)
R2 (_A_, _B_, E)
```


### *c)* 

```
R1a (_C_, D)
R1b (_A_, C)
R2 (_A_, _B_, E)
```

### *d)* 

```
R1 (_C_, D)
R2 (_A_, C)
R3 (_A_, _B_, E)
```
