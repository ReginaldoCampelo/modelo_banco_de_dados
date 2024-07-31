# Universidade Estácio

**Aluno:** Reginaldo Campelo Ilário  
**Matrícula:** 202306141719  
**Curso:** Desenvolvimento Full Stack  
**Campus:** Caucaia

## Introdução

O objetivo desta prática é modelar e implementar um banco de dados simples utilizando o SQL Server. O foco está na compreensão e aplicação de conceitos de modelagem de dados, SQL DDL (Data Definition Language) e SQL DML (Data Manipulation Language). A prática foi realizada individualmente, seguindo as orientações e requisitos especificados.

## Objetivo da Prática

Desenvolver habilidades básicas na modelagem de bancos de dados relacionais e na utilização da sintaxe SQL para criação de estruturas de banco de dados e manipulação de dados. O sistema proposto inclui:

- Cadastro de usuários
- Cadastro de produtos
- Cadastro de pessoas físicas e jurídicas
- Gestão de movimentações de compra e venda

## Desenvolvimento da Prática

### Modelagem do Banco de Dados

Foi utilizado o **DBDesigner Fork** para a modelagem inicial do banco de dados, incluindo as seguintes tabelas:

- **Usuarios:** Para armazenar informações dos operadores do sistema.
- **Pessoas:** Tabela genérica para pessoas físicas e jurídicas, diferenciadas pelo campo "tipo".
- **PessoasFisicas:** Armazena dados específicos de pessoas físicas.
- **PessoasJuridicas:** Armazena dados específicos de pessoas jurídicas.
- **Produtos:** Detalha os produtos disponíveis para compra e venda.
- **Movimentacoes:** Registra as transações de entrada (compras) e saída (vendas) de produtos.

### Implementação no SQL Server

A implementação foi realizada no **SQL Server Management Studio**, com a criação das tabelas usando DDL e a inserção de dados de exemplo usando DML.

#### Criação de Tabelas

```sql
CREATE TABLE Usuarios (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome NVARCHAR(100),
    senha NVARCHAR(100)
);

CREATE TABLE Pessoas (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome NVARCHAR(100),
    endereco NVARCHAR(255),
    telefone NVARCHAR(20),
    tipo NVARCHAR(10)
);

CREATE TABLE PessoasFisicas (
    id INT PRIMARY KEY,
    cpf NVARCHAR(11),
    pessoa_id INT FOREIGN KEY REFERENCES Pessoas(id)
);

CREATE TABLE PessoasJuridicas (
    id INT PRIMARY KEY,
    cnpj NVARCHAR(14),
    pessoa_id INT FOREIGN KEY REFERENCES Pessoas(id)
);

CREATE TABLE Produtos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome NVARCHAR(100),
    quantidade INT,
    preco_venda DECIMAL(10, 2)
);

CREATE TABLE Movimentacoes (
    id INT PRIMARY KEY IDENTITY(1,1),
    tipo NVARCHAR(10),
    produto_id INT FOREIGN KEY REFERENCES Produtos(id),
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    total AS (quantidade * preco_unitario),
    operador_id INT FOREIGN KEY REFERENCES Usuarios(id),
    pessoa_id INT FOREIGN KEY REFERENCES Pessoas(id)
);
```

Inserção de Dados
```sql
INSERT INTO Usuarios (nome, senha) VALUES 
    ('op1', 'op1'), 
    ('op2', 'op2');

INSERT INTO Produtos (nome, quantidade, preco_venda) VALUES 
    ('Produto A', 100, 10.00), 
    ('Produto B', 50, 20.00);

INSERT INTO Pessoas (nome, endereco, telefone, tipo) VALUES 
    ('João Silva', 'Rua A, 123', '123456789', 'Física'),
    ('Empresa X', 'Rua B, 456', '987654321', 'Jurídica');

INSERT INTO PessoasFisicas (id, cpf, pessoa_id) VALUES 
    (1, '12345678901', 1);

INSERT INTO PessoasJuridicas (id, cnpj, pessoa_id) VALUES 
    (2, '12345678000199', 2);

INSERT INTO Movimentacoes (tipo, produto_id, quantidade, preco_unitario, operador_id, pessoa_id) VALUES 
    ('Entrada', 1, 10, 9.00, 1, 2),
    ('Saída', 1, 5, 10.00, 2, 1);
```

Resultados
Os dados foram inseridos com sucesso e as consultas realizadas apresentaram os resultados esperados. Abaixo estão algumas das consultas realizadas e seus resultados:

Consulta de pessoas físicas:
```sql
SELECT * FROM Pessoas p 
JOIN PessoasFisicas pf ON p.id = pf.pessoa_id;
```
Consulta de pessoas jurídicas:
```sql
SELECT * FROM Pessoas p
JOIN PessoasJuridicas pj ON p.id = pj.pessoa_id;
```
Consulta de movimentações de entrada:
```sql
SELECT * FROM Movimentacoes m
JOIN Produtos p ON m.produto_id = p.id
WHERE tipo = 'Entrada';
```
Consulta de movimentações de saída:
```sql
SELECT * FROM Movimentacoes m
JOIN Produtos p ON m.produto_id = p.id
WHERE tipo = 'Saída';
```

Análise e Conclusão
Nesta prática, foram abordados conceitos essenciais de modelagem de banco de dados e SQL, incluindo:

Definição de tabelas, chaves primárias e estrangeiras
Consultas SQL básicas
Uso de sequences e identidades para geração de IDs
Importância das chaves estrangeiras para a consistência dos dados
O SQL Server Management Studio facilitou a criação e gestão do banco de dados, provendo uma interface intuitiva para administração e execução de scripts SQL.
