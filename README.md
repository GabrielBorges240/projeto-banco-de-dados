# Sistema de E-commerce — Banco de Dados

Projeto do Módulo 3: modelagem e manipulação de banco de dados com controle
de versão em Git/GitHub.

## 1. Descrição do sistema

Banco de dados relacional para um sistema de e-commerce simples, contemplando
o cadastro de clientes, categorias e produtos, o registro de pedidos com
seus itens, e o controle de pagamentos.

## 2. Entidades e relacionamentos

| Entidade         | Descrição                                            |
|------------------|-------------------------------------------------------|
| `clientes`       | Pessoas que compram no sistema                        |
| `categorias`     | Categorias às quais os produtos pertencem              |
| `produtos`       | Itens disponíveis para venda                           |
| `pedidos`        | Compras realizadas pelos clientes                      |
| `itens_pedido`   | Tabela associativa entre `pedidos` e `produtos` (N:N)  |
| `pagamentos`     | Pagamento referente a cada pedido (1:1 com `pedidos`)  |

**Relacionamentos:**
- Um cliente pode fazer vários pedidos (1:N entre `clientes` e `pedidos`).
- Um pedido pode conter vários produtos, e um produto pode estar em vários
  pedidos — relação N:N resolvida pela tabela `itens_pedido`.
- Uma categoria pode ter vários produtos (1:N entre `categorias` e `produtos`).
- Cada pedido possui, no máximo, um pagamento (1:1 entre `pedidos` e
  `pagamentos`).

### Diagrama (representação textual)

```
clientes (1) ────< (N) pedidos (1) ────< (N) itens_pedido (N) >──── (1) produtos (N) >──── (1) categorias
                                │
                                └──── (1:1) pagamentos
```

## 3. Restrições (constraints) aplicadas

- Chaves primárias (`PRIMARY KEY`) em todas as tabelas, com auto incremento.
- Chaves estrangeiras (`FOREIGN KEY`) garantindo integridade referencial.
- `UNIQUE` no e-mail do cliente e no nome da categoria.
- `NOT NULL` em campos obrigatórios.
- `CHECK` para impedir preços/estoque/quantidades inválidos (negativos ou zero).
- `ENUM` para restringir valores de status e forma de pagamento a um conjunto
  fixo de opções válidas.
- `ON DELETE RESTRICT` em relações críticas (não permite apagar categoria ou
  cliente que já tenha produtos/pedidos vinculados), e `ON DELETE CASCADE`
  em `itens_pedido` e `pagamentos` (dependem diretamente do pedido).

## 4. Arquivos do projeto

| Arquivo                          | Conteúdo                                            |
|-----------------------------------|-----------------------------------------------------|
| `schema.sql`                      | Criação do banco e das tabelas (DDL)                |
| `dml_insercao.sql`                | Inserção de dados de exemplo (INSERT)               |
| `dml_atualizacao_remocao.sql`     | Atualizações e remoções (UPDATE / DELETE)           |
| `consultas.sql`                   | Consultas de exemplo (SELECT), incluindo JOINs e agregações |

## 5. Como executar

1. Instale um SGBD (ex.: MySQL, MariaDB) ou use uma ferramenta como o
   [DB Fiddle](https://www.db-fiddle.com/) / [DBeaver](https://dbeaver.io/).
2. Execute `schema.sql` para criar o banco e as tabelas.
3. Execute `dml_insercao.sql` para popular o banco com dados de teste.
4. Execute `consultas.sql` para ver exemplos de consultas.
5. Execute `dml_atualizacao_remocao.sql` para ver exemplos de update/delete.

## 6. Controle de versão

Consulte o arquivo `GUIA_GIT.md` para o passo a passo de como este projeto
foi versionado com Git e publicado no GitHub.

## 7. Autor

Gabriel Borges
