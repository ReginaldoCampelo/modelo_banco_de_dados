CREATE DATABASE LojaDB;
GO
USE LojaDB;
GO

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
    tipo NVARCHAR(10) -- Física ou Jurídica
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
    tipo NVARCHAR(10), -- Entrada ou Saída
    produto_id INT FOREIGN KEY REFERENCES Produtos(id),
    quantidade INT,
    preco_unitario DECIMAL(10, 2),
    total AS (quantidade * preco_unitario),
    operador_id INT FOREIGN KEY REFERENCES Usuarios(id),
    pessoa_id INT FOREIGN KEY REFERENCES Pessoas(id)
);

INSERT INTO Usuarios (nome, senha) VALUES ('op1', 'op1'), ('op2', 'op2');

INSERT INTO Produtos (nome, quantidade, preco_venda) VALUES 
('Produto A', 100, 10.00),
('Produto B', 50, 20.00);

INSERT INTO Pessoas (nome, endereco, telefone, tipo) VALUES
('João Silva', 'Rua A, 123', '123456789', 'Física'),
('Empresa X', 'Rua B, 456', '987654321', 'Jurídica');

INSERT INTO PessoasFisicas (id, cpf, pessoa_id) VALUES (1, '12345678901', 1);
INSERT INTO PessoasJuridicas (id, cnpj, pessoa_id) VALUES (2, '12345678000199', 2);

INSERT INTO Movimentacoes (tipo, produto_id, quantidade, preco_unitario, operador_id, pessoa_id) VALUES
('Entrada', 1, 10, 9.00, 1, 2), -- Compra de Produto A
('Saída', 1, 5, 10.00, 2, 1); -- Venda de Produto A

SELECT * FROM Pessoas p
JOIN PessoasFisicas pf ON p.id = pf.pessoa_id;

SELECT * FROM Pessoas p
JOIN PessoasJuridicas pj ON p.id = pj.pessoa_id;

SELECT * FROM Movimentacoes m
JOIN Produtos p ON m.produto_id = p.id
WHERE tipo = 'Entrada';

SELECT * FROM Movimentacoes m
JOIN Produtos p ON m.produto_id = p.id
WHERE tipo = 'Saída';