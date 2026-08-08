-- =========================================================
-- Arquivo: dml_insercao.sql
-- Descrição: Inserção de dados de exemplo (INSERT) no banco
--            ecommerce_db, para testar o modelo.
-- =========================================================

USE ecommerce_db;

-- ---------------------------------------------------------
-- Clientes
-- ---------------------------------------------------------
INSERT INTO clientes (nome, email, telefone, endereco) VALUES
('Ana Souza',     'ana.souza@email.com',     '69999990001', 'Rua das Flores, 100 - São Miguel do Guaporé/RO'),
('Bruno Lima',    'bruno.lima@email.com',    '69999990002', 'Av. Brasil, 500 - Porto Velho/RO'),
('Carla Mendes',  'carla.mendes@email.com',  '69999990003', 'Rua XV de Novembro, 20 - Ji-Paraná/RO'),
('Diego Alves',   'diego.alves@email.com',   '69999990004', 'Rua dos Andradas, 45 - Vilhena/RO');

-- ---------------------------------------------------------
-- Categorias
-- ---------------------------------------------------------
INSERT INTO categorias (nome, descricao) VALUES
('Eletrônicos', 'Dispositivos e acessórios eletrônicos'),
('Informática', 'Computadores, periféricos e componentes'),
('Livros',      'Livros físicos e digitais'),
('Casa',        'Utensílios e itens para o lar');

-- ---------------------------------------------------------
-- Produtos
-- ---------------------------------------------------------
INSERT INTO produtos (nome, descricao, preco, estoque, categoria_id) VALUES
('Smartphone X200',        'Smartphone 128GB, tela 6.5"',       1899.90, 15, 1),
('Fone Bluetooth Pro',     'Fone de ouvido sem fio',              199.90, 40, 1),
('Notebook UltraSlim',     'Notebook 16GB RAM, SSD 512GB',       4299.00,  8, 2),
('Mouse Gamer RGB',        'Mouse óptico 6 botões',                89.90, 60, 2),
('Livro: Banco de Dados',  'Introdução a modelagem de dados',      79.90, 25, 3),
('Jogo de Panelas Inox',   'Conjunto com 5 peças',                349.90, 12, 4);

-- ---------------------------------------------------------
-- Pedidos
-- ---------------------------------------------------------
INSERT INTO pedidos (cliente_id, status, valor_total) VALUES
(1, 'PAGO',                 2099.80),
(2, 'AGUARDANDO_PAGAMENTO',  349.90),
(3, 'ENVIADO',              4388.90);

-- ---------------------------------------------------------
-- Itens do pedido (relaciona pedidos e produtos)
-- ---------------------------------------------------------
-- Pedido 1: Ana comprou Smartphone + Fone Bluetooth
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 1899.90),
(1, 2, 1, 199.90);

-- Pedido 2: Bruno comprou Jogo de Panelas
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(2, 6, 1, 349.90);

-- Pedido 3: Carla comprou Notebook + Livro
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(3, 3, 1, 4299.00),
(3, 5, 1, 79.90);

-- ---------------------------------------------------------
-- Pagamentos
-- ---------------------------------------------------------
INSERT INTO pagamentos (pedido_id, forma_pagamento, valor, status) VALUES
(1, 'PIX',            2099.80, 'APROVADO'),
(3, 'CARTAO_CREDITO',  4388.90, 'APROVADO');
-- Observação: o pedido 2 ainda não possui pagamento registrado,
-- pois está com status 'AGUARDANDO_PAGAMENTO'.
