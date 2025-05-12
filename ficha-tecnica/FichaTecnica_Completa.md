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

---

## 📐 Arquitetura Técnica do Projeto

### 📁 Estrutura Raiz

* `src/modules/` – Contém os módulos de funcionalidades principais do sistema.
* `src/shared/` – Componentes e utilitários compartilhados entre os módulos.
* `src/app/` – Arquivos centrais da aplicação.
* `src/api/` – Camada de integração com APIs.
* `src/services/` – Camada de lógica de negócio.
* `src/routes/` – Configuração de rotas.

### 📦 Estrutura dos Módulos (para cada módulo funcional)

Cada módulo funcional (como `materiaprima`, `produtos`, `receitas`) segue a mesma estrutura dentro de `src/modules/[nome_do_módulo]/`, e contém tudo relacionado àquela funcionalidade/domínio:

* `components/` – Componentes de UI específicos deste módulo
  * `index.ts` – Arquivo barril que exporta todos os componentes
  * `[Componente].tsx` – Componentes individuais que vieram da estrutura antiga
* `hooks/` – Hooks React personalizados para este módulo
  * `index.ts` – Vazio por enquanto; exportará hooks quando forem criados
* `types/` – Definições de tipos TypeScript específicas deste módulo
  * `index.ts` – Contém os tipos extraídos do arquivo original de tipos
* `utils/` – Funções utilitárias específicas deste módulo
  * (Vazio no momento; pode conter funções auxiliares no futuro)
* `context/` – Gerenciamento de estado para este módulo
  * `[Modulo]Context.tsx` – Provedor de contexto para gerenciar o estado do módulo (estado, reducer, provider e hook customizado)
* `index.ts` – Arquivo barril que exporta a API pública do módulo

### 🔄 Camada Compartilhada

**`src/shared/`** – Contém código compartilhado entre vários módulos:

* `components/` – Componentes de UI reutilizáveis
  * (Inclui componentes migrados de `src/components/ui/`)
* `hooks/` – Hooks reutilizáveis
  * `index.ts` – Vazio por enquanto
* `types/` – Tipos TypeScript compartilhados
  * `index.ts` – Definições comuns
* `utils/` – Funções utilitárias compartilhadas
  * `calculations.ts` – Migrado da pasta original de utilitários

### 🧩 Camada da Aplicação

**`src/app/`** – Contém código de escopo global da aplicação:

* `layout/` – Componentes de layout
  * (Migrados de `src/components/layout/`)
* `components/` – Componentes de nível de aplicação
  * `Dashboard.tsx` – Migrado de `pages/Dashboard.tsx`
* `providers/` – Providers globais da aplicação
  * (Vazio no momento; pode incluir providers de tema, autenticação etc.)
* `routes/` – Roteamento da aplicação
  * (Vazio no momento; as rotas estão em `src/routes/`)

### 🔌 Camadas de API e Serviços

**`src/api/`** – Camada de integração com a API:

* `materiaPrima.ts`, `produtos.ts`, `receitas.ts` – Chamadas de API para cada módulo
  * Contêm funções de operações CRUD que se conectam com o backend

**`src/services/`** – Camada de lógica de negócio:

* `materiaPrimaService.ts`, `produtosService.ts`, `receitasService.ts` – Lógica de negócio para cada módulo
  * Contêm validações, transformações e regras entre a UI e a API

### 🌐 Roteamento

**`src/routes/`** – Configuração de rotas:

* `index.ts` – Configuração principal do roteador
* `materiaPrima.routes.ts`, `produtos.routes.ts`, `receitas.routes.ts` – Rotas específicas de cada módulo

### 📄 Arquivos Especiais

* `src/App.new.tsx` – Nova versão do componente `App` usando React Router
  * Contém os providers de contexto e a estrutura de layout

### ✅ Benefícios desta Arquitetura

* **Encapsulamento:** cada módulo contém tudo o que precisa
* **Separação de responsabilidades:** UI, lógica e acesso a dados estão separados
* **Facilidade de localização:** arquivos organizados por funcionalidade
* **Escalabilidade:** adicionar novos módulos segue um padrão claro
* **Reusabilidade:** o código compartilhado está bem isolado
* **Testabilidade:** fronteiras claras facilitam os testes

### ➕ Para adicionar um novo módulo (ex: "fornecedores"):

1. Crie uma pasta com a estrutura descrita em `src/modules/fornecedores`
2. Crie os arquivos de API e serviços em `src/api/` e `src/services/`
3. Adicione as rotas em `src/routes/`
4. Inclua o provider do contexto no `App.tsx`

---

## 🧱 Detalhamento dos Formulários por Módulo

### 📦 Matéria-Prima

* O formulário de matéria-prima deve conter:
  * Campo `quantidade` (relacionado à tabela `custo_materia_prima`).
  * Campo `descrição` da matéria-prima.
  * Campo `tipo` com um botão que abre um formulário modal para cadastrar, excluir e editar tipos de matéria-prima.
  * Campo `medida` deve listar as medidas existentes na tabela `medidas_materia_prima`.

### 🧪 Receita

* O formulário de receita será no formato **mestre-detalhe**, permitindo:
  * Adição de itens de matéria-prima.
  * Cálculo automático do custo com base nos ingredientes inseridos.
  * Cálculo do **peso bruto** como a soma dos pesos convertidos de todas as matérias-primas.
  * Campo `peso líquido` informado pelo usuário; se vazio, será assumido o valor do peso bruto.
  * Cálculo do **fator de correção (CF)** como `peso_bruto / peso_liquido`.
  * Campo `tipo` com um botão para abrir um formulário modal para cadastrar, excluir e editar os tipos de receita.

### 🧁 Produto

* O formulário de produto será também **mestre-detalhe** e deve permitir:
  * Associação de receitas e matérias-primas com suas respectivas quantidades.
  * Um produto poderá conter vários tamanhos definidos pelo usuário.
  * Cada tamanho terá:
    * Custos próprios com base nos itens associados.
    * Valor de venda específico informado pelo usuário.
  * A modelagem de tabelas deve permitir múltiplos tamanhos associados a um produto, com seus respectivos itens e custos.
  * Campo `categoria` com um botão que abre um formulário modal para cadastrar, excluir e editar categorias de produto.
