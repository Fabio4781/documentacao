
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
