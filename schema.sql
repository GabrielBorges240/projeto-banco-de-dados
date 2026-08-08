-- =========================================================
-- PROJETO: Banco de Dados para Sistema de E-commerce
-- Arquivo: schema.sql
-- Descrição: Criação das tabelas, chaves primárias, chaves
--            estrangeiras e restrições (constraints) do sistema.
-- SGBD alvo: MySQL 8+ (compatível com pequenos ajustes no PostgreSQL)
-- =========================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- ---------------------------------------------------------
-- Tabela: clientes
-- ---------------------------------------------------------
CREATE TABLE clientes (
    cliente_id      INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(120) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    telefone        VARCHAR(20),
    endereco        VARCHAR(200),
    data_cadastro   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- Tabela: categorias
-- ---------------------------------------------------------
CREATE TABLE categorias (
    categoria_id    INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(80) NOT NULL UNIQUE,
    descricao       VARCHAR(255)
);

-- ---------------------------------------------------------
-- Tabela: produtos
-- Relacionamento: N produtos pertencem a 1 categoria (N:1)
-- ---------------------------------------------------------
CREATE TABLE produtos (
    produto_id      INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    descricao       VARCHAR(255),
    preco           DECIMAL(10,2) NOT NULL CHECK (preco > 0),
    estoque         INT NOT NULL DEFAULT 0 CHECK (estoque >= 0),
    categoria_id    INT NOT NULL,
    CONSTRAINT fk_produtos_categoria
        FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ---------------------------------------------------------
-- Tabela: pedidos
-- Relacionamento: N pedidos pertencem a 1 cliente (N:1)
-- ---------------------------------------------------------
CREATE TABLE pedidos (
    pedido_id       INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id      INT NOT NULL,
    data_pedido     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status          ENUM('AGUARDANDO_PAGAMENTO','PAGO','ENVIADO','ENTREGUE','CANCELADO')
                    NOT NULL DEFAULT 'AGUARDANDO_PAGAMENTO',
    valor_total     DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (valor_total >= 0),
    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ---------------------------------------------------------
-- Tabela: itens_pedido (tabela associativa)
-- Relacionamento: resolve o N:N entre pedidos e produtos
-- ---------------------------------------------------------
CREATE TABLE itens_pedido (
    item_id         INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id       INT NOT NULL,
    produto_id      INT NOT NULL,
    quantidade      INT NOT NULL CHECK (quantidade > 0),
    preco_unitario  DECIMAL(10,2) NOT NULL CHECK (preco_unitario > 0),
    CONSTRAINT fk_itens_pedido
        FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_itens_produto
        FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uk_pedido_produto UNIQUE (pedido_id, produto_id)
);

-- ---------------------------------------------------------
-- Tabela: pagamentos
-- Relacionamento: 1 pedido possui 1 pagamento (1:1)
-- ---------------------------------------------------------
CREATE TABLE pagamentos (
    pagamento_id    INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id       INT NOT NULL UNIQUE,
    forma_pagamento ENUM('CARTAO_CREDITO','CARTAO_DEBITO','PIX','BOLETO') NOT NULL,
    valor           DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    data_pagamento  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status          ENUM('PENDENTE','APROVADO','RECUSADO','ESTORNADO')
                    NOT NULL DEFAULT 'PENDENTE',
    CONSTRAINT fk_pagamentos_pedido
        FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- Índices auxiliares para consultas frequentes
-- ---------------------------------------------------------
CREATE INDEX idx_produtos_categoria ON produtos(categoria_id);
CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX idx_pedidos_status ON pedidos(status);
