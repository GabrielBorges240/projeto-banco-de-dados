-- =========================================================
-- Arquivo: consultas.sql
-- Descrição: Consultas (SELECT) demonstrando o uso do
--            modelo de dados do e-commerce.
-- =========================================================

USE ecommerce_db;

-- 1) Listar todos os clientes cadastrados
SELECT cliente_id, nome, email, data_cadastro
FROM clientes
ORDER BY nome;

-- 2) Listar produtos com estoque baixo (menos de 10 unidades)
SELECT nome, estoque
FROM produtos
WHERE estoque < 10
ORDER BY estoque ASC;

-- 3) Valor total de pedidos por cliente
SELECT c.nome AS cliente,
       COUNT(p.pedido_id) AS total_pedidos,
       SUM(p.valor_total) AS valor_total_gasto
FROM clientes c
JOIN pedidos p ON p.cliente_id = c.cliente_id
GROUP BY c.cliente_id, c.nome
ORDER BY valor_total_gasto DESC;

-- 4) Detalhes completos de um pedido (itens + produtos + cliente)
SELECT pd.pedido_id,
       c.nome AS cliente,
       pr.nome AS produto,
       ip.quantidade,
       ip.preco_unitario,
       (ip.quantidade * ip.preco_unitario) AS subtotal
FROM pedidos pd
JOIN clientes c        ON c.cliente_id = pd.cliente_id
JOIN itens_pedido ip   ON ip.pedido_id = pd.pedido_id
JOIN produtos pr       ON pr.produto_id = ip.produto_id
WHERE pd.pedido_id = 1;

-- 5) Produtos mais vendidos (quantidade total)
SELECT pr.nome,
       SUM(ip.quantidade) AS quantidade_vendida
FROM itens_pedido ip
JOIN produtos pr ON pr.produto_id = ip.produto_id
GROUP BY pr.produto_id, pr.nome
ORDER BY quantidade_vendida DESC;

-- 6) Pedidos com status de pagamento pendente
SELECT p.pedido_id, c.nome AS cliente, p.status, p.valor_total
FROM pedidos p
JOIN clientes c ON c.cliente_id = p.cliente_id
WHERE p.status = 'AGUARDANDO_PAGAMENTO';

-- 7) Faturamento total aprovado (soma de pagamentos aprovados)
SELECT SUM(valor) AS faturamento_aprovado
FROM pagamentos
WHERE status = 'APROVADO';

-- 8) Quantidade de produtos cadastrados por categoria
SELECT cat.nome AS categoria,
       COUNT(pr.produto_id) AS qtd_produtos
FROM categorias cat
LEFT JOIN produtos pr ON pr.categoria_id = cat.categoria_id
GROUP BY cat.categoria_id, cat.nome
ORDER BY qtd_produtos DESC;

-- 9) Clientes que ainda não realizaram nenhum pedido
SELECT c.nome, c.email
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.cliente_id
WHERE p.pedido_id IS NULL;

-- 10) Ticket médio (valor médio) por pedido
SELECT ROUND(AVG(valor_total), 2) AS ticket_medio
FROM pedidos;
