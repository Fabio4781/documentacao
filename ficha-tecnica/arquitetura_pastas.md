
# Ficha-tecnica

### 📁 Estrutura Raiz

* `src/modules/` – Contém os módulos de funcionalidades principais do sistema.
* `src/shared/` – Componentes e utilitários compartilhados entre os módulos.
* `src/app/` – Arquivos centrais da aplicação.
* `src/api/` – Camada de integração com APIs.
* `src/services/` – Camada de lógica de negócio.
* `src/routes/` – Configuração de rotas.

---

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

---

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

---

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

---

### 🔌 Camadas de API e Serviços

**`src/api/`** – Camada de integração com a API:

* `materiaPrima.ts`, `produtos.ts`, `receitas.ts` – Chamadas de API para cada módulo
  * Contêm funções de operações CRUD que se conectam com o backend

**`src/services/`** – Camada de lógica de negócio:

* `materiaPrimaService.ts`, `produtosService.ts`, `receitasService.ts` – Lógica de negócio para cada módulo
  * Contêm validações, transformações e regras entre a UI e a API

---

### 🌐 Roteamento

**`src/routes/`** – Configuração de rotas:

* `index.ts` – Configuração principal do roteador
* `materiaPrima.routes.ts`, `produtos.routes.ts`, `receitas.routes.ts` – Rotas específicas de cada módulo

---

### 📄 Arquivos Especiais

* `src/App.new.tsx` – Nova versão do componente `App` usando React Router
  * Contém os providers de contexto e a estrutura de layout

---

### ✅ Benefícios desta Arquitetura

* **Encapsulamento:** cada módulo contém tudo o que precisa
* **Separação de responsabilidades:** UI, lógica e acesso a dados estão separados
* **Facilidade de localização:** arquivos organizados por funcionalidade
* **Escalabilidade:** adicionar novos módulos segue um padrão claro
* **Reusabilidade:** o código compartilhado está bem isolado
* **Testabilidade:** fronteiras claras facilitam os testes

---

### ➕ Para adicionar um novo módulo (ex: "fornecedores"):

1. Crie uma pasta com a estrutura descrita em `src/modules/fornecedores`
2. Crie os arquivos de API e serviços em `src/api/` e `src/services/`
3. Adicione as rotas em `src/routes/`
4. Inclua o provider do contexto no `App.tsx`

---

Essa estrutura deixa o projeto muito mais fácil de entender, manter e evoluir.
