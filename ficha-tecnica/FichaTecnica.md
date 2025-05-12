
# Micro SaaS de Ficha Técnica com Receitas Compostas

## Objetivo

Permitir que usuários cadastrem matérias-primas, produtos, tamanhos, receitas (com composições de ingredientes ou outras receitas), gerenciem custos e categorizações de forma eficiente e escalável.

---

## Dicas de Desenvolvimento

* **Código limpo e modularizado** para alta manutenibilidade.
* **Responsividade** para uso como site desktop e aplicativo mobile (PWA).
* **Arquitetura escalável** com separação clara entre módulos de dados e UI.

---

## Interface

* **Menu** lateral retratil com os icones dos modulos quando recolhido e descrição ao ser expandido, nome do sistema e logo no topo do menu.
  * Os botões deverão ficar alterar a cor suavemente ao passar o mouse por cima e ao serem selecionados deven alterar a cor para um tom mais escuro.
* **Layout** cabeçalho com titulo do modulo selecionado centralizado, no canto direito deve conter um icone de mensagens e um icone de login com menu suspenso e com as opções de logout e configurações e plano assinado pelo usuario.
* **temas** com opção de dark mode

---

## Módulos do Sistema (MVP)

### 1. Pagina principal

* Funcionalidades:
  * deve conter um resumo dos produtos, materias primas, receitas, com gráficos.

---

### 2. Cadastro de Matéria-Prima

* Tabelas:
  * `materia_prima`
  * `tipo_materia_prima`
  * `medidas_materia_prima`
  * `custo_materia_prima`
* Funcionalidades:
  * Registro de matérias-primas.
  * Classificação por tipo (ex: ingrediente, embalagem, decoração).
  * Definição de unidade de medida padrão.
  * Controle de custos históricos e atualizados.

---

### 3. Cadastro de Produtos

* Tabelas:
  * `produto`
  * `produto_items`
  * `categoria_produto`
  * `tamanho_produto`
* Funcionalidades:
  * Cadastro de produtos finais (ex: brigadeiro, bolo, cesta de doces).
  * Definição de categorias para organização dos produtos.
  * Definição de tamanhos e variações (ex: pequeno, médio, grande).
  * Associação de múltiplas matérias-primas e/ou receitas ao produto.

---

### 4. Cadastro de Receitas

* Tabelas:
  * `receitas`
  * `receitas_ingredientes`
  * `tipo_receita`
* Funcionalidades:
  * Criação de receitas simples ou compostas.
  * Associação de ingredientes (matéria-prima) ou outras receitas como ingredientes.
  * Organização das receitas por tipo (ex: massas, recheios, coberturas).
  * Controle de rendimento e custo automático.

---

## Estrutura de Banco de Dados (Base Atual)

| Tabela                          | Finalidade Principal                                            |
| ------------------------------- | --------------------------------------------------------------- |
| **materia_prima**         | Cadastro de matérias-primas usadas em receitas ou produtos     |
| **tipo_materia_prima**    | Classificação das matérias-primas                            |
| **medidas_materia_prima** | Definição das unidades de medida para matérias-primas        |
| **custo_materia_prima**   | Histórico e controle de custos por matéria-prima              |
| **produto**               | Cadastro de produtos finais                                     |
| **produto_items**         | Associação entre produtos e suas matérias-primas ou receitas |
| **categoria_produto**     | Organização dos produtos em categorias                        |
| **tamanho_produto**       | Definição de variações de tamanho para produtos             |
| **receitas**              | Cadastro de receitas (preparações técnicas)                  |
| **receitas_ingredientes** | Itens que compõem uma receita (ingredientes ou sub-receitas)   |
| **tipo_receita**          | Classificação das receitas                                    |



SQL:

```

CREATE TABLE categoria_produto
(
  id           INT       NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  nome         TEXT      NOT NULL,
  data_criacao TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN categoria_produto.nome IS 'marmita, doces de festa, sobremesa';

COMMENT ON COLUMN categoria_produto.data_criacao IS 'automatico';

CREATE TABLE custo_materia_prima
(
  id               INT           NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  materia_prima_id INT           NOT NULL,
  custo            NUMERIC(10,2) NOT NULL,
  quantidade       NUMERIC(10,2) NOT NULL,
  data_criacao     TIMESTAMP     NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON TABLE custo_materia_prima IS 'custo da materia prima';

COMMENT ON COLUMN custo_materia_prima.data_criacao IS 'automatico';

CREATE TABLE itens_lista_compras
(
  id_itens   INT           NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  lista_id   INT           NOT NULL,
  produto_id INT          ,
  quantidade NUMERIC(10,2),
  unidade    TEXT         ,
  comprado   BOOLEAN      ,
  PRIMARY KEY (id_itens)
);

CREATE TABLE lista_compras
(
  id_lista     INT       NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  nome         TEXT     ,
  data_geracao TIMESTAMP,
  receitas_ids JSONB    ,
  status       TEXT     ,
  PRIMARY KEY (id_lista)
);

CREATE TABLE materia_prima
(
  id           INT           NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  nome         TEXT          NOT NULL,
  medida_id    INT           NOT NULL,
  tipo_id      INT           NOT NULL,
  custo        NUMERIC(10,2) NOT NULL,
  fornecedor   TEXT         ,
  descricao    TEXT         ,
  data_criacao TIMESTAMP     NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN materia_prima.data_criacao IS 'automatico';

CREATE TABLE medidas_materia_prima
(
  id           INT           NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  nome         TEXT          NOT NULL,
  descricao    TEXT         ,
  conversao    NUMERIC(10,4) NOT NULL,
  data_criacao TIMESTAMP     NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON TABLE medidas_materia_prima IS 'tabela com dados já imputados';

COMMENT ON COLUMN medidas_materia_prima.nome IS 'kg, g, l, ml';

COMMENT ON COLUMN medidas_materia_prima.data_criacao IS 'automatico';

CREATE TABLE produto
(
  id             INT           NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  categoria_id   INT           NOT NULL,
  nome           TEXT          NOT NULL,
  custo_unitario NUMERIC(10,2) NOT NULL,
  fornecedor     TEXT         ,
  valor_venda    NUMERIC(10,2) NOT NULL,
  margem         INT           NOT NULL,
  lucro          NUMERIC(10,2) NOT NULL,
  data_criacao   TIMESTAMP     NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN produto.custo_unitario IS 'calculado';

COMMENT ON COLUMN produto.margem IS 'procentagem';

COMMENT ON COLUMN produto.lucro IS 'calculado';

COMMENT ON COLUMN produto.data_criacao IS 'automatico';

CREATE TABLE produto_items
(
  id               INT           NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  produto_id       INT           NOT NULL,
  receita_id       INT          ,
  materia_prima_id INT          ,
  quantidade       NUMERIC(10,2) NOT NULL,
  data_criacao     TIMESTAMP     NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN produto_items.receita_id IS 'fk';

COMMENT ON COLUMN produto_items.materia_prima_id IS 'fk';

COMMENT ON COLUMN produto_items.data_criacao IS 'automatico';

CREATE TABLE receita_ingredientes
(
  id               INT           NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  receita_id       INT           NOT NULL,
  materia_prima_id INT          ,
  quantidade       NUMERIC(10,2) NOT NULL,
  data_criacao     TIMESTAMP     NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN receita_ingredientes.data_criacao IS 'automatico';

CREATE TABLE receitas
(
  id             INT           NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  tipo_id        INT           NOT NULL,
  nome           TEXT          NOT NULL,
  modo_preparo   TEXT         ,
  rendimento     TEXT          NOT NULL,
  custo_receita  NUMERIC(10,2) NOT NULL,
  fator_correcao NUMERIC(10,2),
  peso_bruto     NUMERIC(10,2),
  peso_liquido   NUMERIC(10,2),
  descricao      TEXT         ,
  data_criacao   TIMESTAMP     NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN receitas.custo_receita IS 'calculado';

COMMENT ON COLUMN receitas.data_criacao IS 'automatico';

CREATE TABLE tamanho_produto
(
  id           INT       NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  produto_id   INT       NOT NULL,
  nome         TEXT      NOT NULL,
  descricao    TEXT     ,
  data_criacao TIMESTAMP NOT NULL,
  id           INT       NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN tamanho_produto.data_criacao IS 'automatico';

CREATE TABLE tipo_materia_prima
(
  id           INT       NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  nome         TEXT      NOT NULL,
  descricao    TEXT     ,
  data_criacao TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN tipo_materia_prima.nome IS 'embalagem, confeito, ingrediente';

COMMENT ON COLUMN tipo_materia_prima.data_criacao IS 'automatico';

CREATE TABLE tipo_receita
(
  id           INT       NOT NULL GENERATED ALWAYS AS IDENTITY UNIQUE,
  nome         TEXT      NOT NULL,
  descricao    TEXT     ,
  data_criacao TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN tipo_receita.nome IS 'doce, salgado, base, recheio';

COMMENT ON COLUMN tipo_receita.data_criacao IS 'automatico';

ALTER TABLE materia_prima
  ADD CONSTRAINT FK_medidas_materia_prima_TO_materia_prima
    FOREIGN KEY (medida_id)
    REFERENCES medidas_materia_prima (id);

ALTER TABLE materia_prima
  ADD CONSTRAINT FK_tipo_materia_prima_TO_materia_prima
    FOREIGN KEY (tipo_id)
    REFERENCES tipo_materia_prima (id);

ALTER TABLE custo_materia_prima
  ADD CONSTRAINT FK_materia_prima_TO_custo_materia_prima
    FOREIGN KEY (materia_prima_id)
    REFERENCES materia_prima (id);

ALTER TABLE itens_lista_compras
  ADD CONSTRAINT FK_lista_compras_TO_itens_lista_compras
    FOREIGN KEY (lista_id)
    REFERENCES lista_compras (id_lista);

ALTER TABLE produto
  ADD CONSTRAINT FK_categoria_produto_TO_produto
    FOREIGN KEY (categoria_id)
    REFERENCES categoria_produto (id);

ALTER TABLE produto_items
  ADD CONSTRAINT FK_produto_TO_produto_items
    FOREIGN KEY (produto_id)
    REFERENCES produto (id);

ALTER TABLE receita_ingredientes
  ADD CONSTRAINT FK_receitas_TO_receita_ingredientes
    FOREIGN KEY (receita_id)
    REFERENCES receitas (id);

ALTER TABLE receitas
  ADD CONSTRAINT FK_tipo_receita_TO_receitas
    FOREIGN KEY (tipo_id)
    REFERENCES tipo_receita (id);

ALTER TABLE tamanho_produto
  ADD CONSTRAINT FK_produto_TO_tamanho_produto
    FOREIGN KEY (id)
    REFERENCES produto (id);

```
