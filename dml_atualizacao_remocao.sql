-- =========================================================
-- Arquivo: dml_atualizacao_remocao.sql
-- Descrição: Exemplos de UPDATE e DELETE sobre o banco
--            ecommerce_db.
-- =========================================================

USE ecommerce_db;

-- ---------------------------------------------------------
-- UPDATE: atualizar o telefone de um cliente
-- ---------------------------------------------------------
UPDATE clientes
SET telefone = '69988887777'
WHERE email = 'ana.souza@email.com';

-- ---------------------------------------------------------
-- UPDATE: registrar pagamento do pedido 2 (Bruno) e mudar status
-- ---------------------------------------------------------
INSERT INTO pagamentos (pedido_id, forma_pagamento, valor, status)
VALUES (2, 'BOLETO', 349.90, 'APROVADO');

UPDATE pedidos
SET status = 'PAGO'
WHERE pedido_id = 2;

-- ---------------------------------------------------------
-- UPDATE: reduzir estoque após confirmação de venda
-- (normalmente feito via trigger/aplicação; aqui é manual)
-- ---------------------------------------------------------
UPDATE produtos
SET estoque = estoque - 1
WHERE produto_id IN (1, 2, 6, 3, 5);

-- ---------------------------------------------------------
-- UPDATE: aplicar reajuste de 10% no preço de produtos
-- da categoria "Informática"
-- ---------------------------------------------------------
UPDATE produtos
SET preco = preco * 1.10
WHERE categoria_id = (SELECT categoria_id FROM categorias WHERE nome = 'Informática');

-- ---------------------------------------------------------
-- DELETE: remover um item específico de um pedido
-- (ex.: cliente desistiu de um dos produtos do carrinho)
-- ---------------------------------------------------------
DELETE FROM itens_pedido
WHERE pedido_id = 3 AND produto_id = 5;

-- ---------------------------------------------------------
-- DELETE: cancelar e remover um pedido sem pagamento
-- (a exclusão em cascata remove também os itens_pedido)
-- ---------------------------------------------------------
-- Exemplo hipotético: pedido de teste criado por engano
-- DELETE FROM pedidos WHERE pedido_id = 99;

-- ---------------------------------------------------------
-- DELETE: remover um cliente sem pedidos associados
-- (a FK com ON DELETE RESTRICT impede remover clientes
--  que já possuem pedidos, garantindo integridade)
-- ---------------------------------------------------------
-- DELETE FROM clientes WHERE cliente_id = 4;
