
# Micro SaaS de Ficha Técnica com Receitas Compostas

## Etapas dos comandos enviados para o lovable

* Enviar o MD da ficha-tecnica e da estrutura de pastas
* Ajuste de layout:
  * O aplicativo não está responsivo para uso mobile, ajuste isso
  * O menu lateral não está aparecendo o escrito quando uso o mobile, ajuste uma configuração de cores padrões para light e dark mode de todos os elementos
* Conexão com o supabase e criação do backend:
  * Crie agora a parte de backend com o cadastro de materia prima, produtos e receitas, usando os dados das tabelas que eu passei e conecte tudo com o supabase. deixe o app funcional
* Proximos passos:
  * Validar se todos os componentes estão com todos os campos
    * Materia prima:
      * o formulario de materia prima falta os campos quantidade onde será inserida na tabela custo_materia_prima e descrição
      * Campo tipo deve conter um botão no formulario onde abre um formulario com uma lista onde eu possa cadastrar excluir e editar o tipo de materia prima
      * Campo medida deve conter as medidas cadastradas na tabela medidas_materia_prima
    * Receita:
      * o formulario de receita deve ser um mestre detalhes onde eu adiciona os itens de matéria prima na minha receita e é calculado o custo com base nas materas primas inclusas e o peso bruto sendo a soma do peso convertido de todas as materias primas, o peso liquido é dada pelo usuario, caso não seja informado será usado o peso bruto também no peso liquido e o fator de correção é o calculo (CF = peso bruto / peso liquido)
      * Campo tipo deve conter um botão no formulario onde abre um formulario com uma lista onde eu possa cadastrar excluir e editar o tipo de receita
    * produto:
      * O formulario de produto deve ser um mestre detalhes onde podem ser adicionadas receitas e materias primas com suas quantidades para compor o produto, o produto pode conter varios tamanhos especificados pelo usuario e cada tamenho tem um custo proprio, quantidade de materias proprias e um valor de venta informado pelo usuario. com isso as tabelas devem ser alteradas para atender a este processo onde cada produto pode possuir varios tamanhos onde pode possuir varios itens.
      * Campo categoria deve conter um botão no formulario onde abre um formulario com uma lista onde eu possa cadastrar excluir e editar a categoria do produto
  * Ajustar tipos (cadastros no banco e não no código
  * Ajustar produtos
  * Testar CRUD no supabase
  * Validar se serve para todos os tipos de empreendedores e não somente para comida.
  * Validar se os nomes dos modulos fazem sentido
  * Teste e ajuste de layout
  * link com github
