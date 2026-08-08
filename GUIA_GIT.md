# Guia de Versionamento — Git e GitHub

Este guia mostra o passo a passo para versionar este projeto e publicá-lo
no GitHub, cumprindo os requisitos do módulo (commits frequentes e boas
práticas de versionamento).

## 1. Criar o repositório local

```bash
# Dentro da pasta do projeto (ecommerce-db)
git init
git add README.md
git commit -m "docs: adiciona README com descricao do projeto"
```

## 2. Criar o repositório no GitHub

1. Acesse https://github.com e clique em **New repository**.
2. Nomeie, por exemplo, `ecommerce-db-modulo3`.
3. Deixe como **público**, sem inicializar com README (o seu já existe
   localmente).
4. Copie a URL do repositório (ex.: `https://github.com/seu-usuario/ecommerce-db-modulo3.git`).

## 3. Conectar o repositório local ao GitHub

```bash
git branch -M main
git remote add origin https://github.com/seu-usuario/ecommerce-db-modulo3.git
git push -u origin main
```

## 4. Sequência sugerida de commits (histórico incremental)

Em vez de subir tudo de uma vez, faça commits separados por etapa — isso
demonstra a evolução do projeto, como pedido no enunciado:

```bash
# 1. Estrutura do banco (DDL)
git add schema.sql
git commit -m "feat: cria esquema do banco de dados (tabelas e constraints)"
git push

# 2. Dados de exemplo (INSERT)
git add dml_insercao.sql
git commit -m "feat: adiciona script de insercao de dados de exemplo"
git push

# 3. Consultas (SELECT)
git add consultas.sql
git commit -m "feat: adiciona consultas SQL de exemplo (joins e agregacoes)"
git push

# 4. Atualizacao e remocao (UPDATE/DELETE)
git add dml_atualizacao_remocao.sql
git commit -m "feat: adiciona scripts de atualizacao e remocao de dados"
git push

# 5. Documentacao final
git add README.md GUIA_GIT.md
git commit -m "docs: finaliza documentacao do projeto e guia de versionamento"
git push
```

## 5. Boas práticas usadas

- **Mensagens de commit claras**, no padrão `tipo: descrição curta`
  (`feat` para novas funcionalidades, `docs` para documentação, `fix` para
  correções).
- **Commits pequenos e frequentes**, cada um representando uma etapa
  lógica do projeto (schema → dados → consultas → manipulação → docs).
- **Arquivo `.gitignore`** (opcional) para não versionar arquivos
  temporários, se o projeto crescer com outra linguagem (ex. Python/Node).
- **README.md** completo, explicando o modelo de dados e como executar o
  projeto, para que qualquer pessoa entenda o repositório.

## 6. Exemplo de `.gitignore` (opcional)

```
# Arquivos temporários e de ambiente
*.log
.env
__pycache__/
node_modules/
```

## 7. Link do repositório

Depois de publicar, cole aqui o link para incluir no relatório final:

```
https://github.com/seu-usuario/ecommerce-db-modulo3
```
