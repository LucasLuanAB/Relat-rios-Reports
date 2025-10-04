CREATE DATABASE deposito_bebidas;
USE deposito_bebidas;


CREATE TABLE fornecedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20)
)ENGINE=InnoDB;

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    tipo VARCHAR(50),      -- Ex: cerveja, refrigerante, suco
    preco DECIMAL(10,2),
    estoque INT
)ENGINE=InnoDB;

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20)
)ENGINE=InnoDB;

CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    quantidade INT,
    data_venda DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
)ENGINE=InnoDB;

CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fornecedor_id INT,
    produto_id INT,
    quantidade INT,
    data_compra DATE,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
)ENGINE=InnoDB;

DESCRIBE compras;



INSERT INTO fornecedores (nome, telefone) VALUES
('Cervejaria Brasil', '99999-1001'),
('Refrigerantes Norte', '99999-1002');

INSERT INTO produtos (nome, tipo, preco, estoque) VALUES
('Cerveja Skol', 'Cerveja', 5.50, 100),
('Cerveja Brahma', 'Cerveja', 6.00, 80),
('Refrigerante Coca-Cola', 'Refrigerante', 4.00, 120),
('Suco Del Valle', 'Suco', 3.50, 50);

INSERT INTO clientes (nome, telefone) VALUES
('Bar do João', '98888-0001'),
('Restaurante da Maria', '98888-0002');

INSERT INTO vendas (cliente_id, produto_id, quantidade, data_venda) VALUES
(1, 1, 20, '2025-09-20'),
(1, 3, 10, '2025-09-21'),
(2, 2, 15, '2025-09-22'),
(2, 4, 5, '2025-09-23');

INSERT INTO compras (fornecedor_id, produto_id, quantidade, data_compra, preco_unitario) VALUES
(1, 1, 50, '2025-09-18', 4.00),
(1, 2, 40, '2025-09-18', 4.50),
(2, 3, 60, '2025-09-19', 3.00),
(2, 4, 30, '2025-09-19', 2.80);

-- vendas por clientes 
SELECT c.nome AS cliente, p.nome AS produto, v.quantidade, p.preco,
       (v.quantidade * p.preco) AS total, v.data_venda
FROM vendas v
 JOIN clientes c ON v.cliente_id = c.id
 JOIN produtos p ON v.produto_id = p.id;

-- compras  por fornecedor 

SELECT f.nome AS fornecedor, p.nome AS produto, c.quantidade, c.preco_unitario,
       (c.quantidade * c.preco_unitario) AS total, c.data_compra
FROM compras c
JOIN fornecedores f ON c.fornecedor_id = f.id
JOIN produtos p ON c.produto_id = p.id;

-- estoque atual
SELECT nome as produto, tipo,estoque
FROM produtos
ORDER BY estoque desc; 

SHOW TABLE STATUS WHERE Name = 'vendas';
