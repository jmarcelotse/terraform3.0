# Built-in functions

O Terraform oferece uma variedade de funções built-in que podem ser usadas para manipular dados, executar cálculos e gerenciar strings, listas, mapas, etc. Essas funções ajudam a tornar as configurações do Terraform mais flexíveis e poderosas. A seguir, vou listar algumas das categorias de funções mais comuns e fornecer exemplos de como usá-las.

# Categorias de Funções Built-in

### 1. Funções de String
### 2. Funções de Número
### 3. Funções de Data e Hora
### 4. Funções de Coleção
### 5. Funções de Decisão
### 6. Funções de Leitura de Arquivos
### 7. Funções de Hash e Criptografia

# 1. Funções de String

- **join(separator, list)**: Junta os elementos de uma lista em uma string, usando um separador.

  hcl

  join(", ", ["a", "b", "c"])  # "a, b, c"

- **split(separator, string)**: Divide uma string em uma lista com base em um separador.

  hcl

  split(", ", "a, b, c")  # ["a", "b", "c"]

- **trimspace(string)**: Remove espaços em branco do início e do fim de uma string.

  hcl

  trimspace("  hello  ")  # "hello"

# 2. Funções de Número

  - **max(num1, num2, ...)**: Retorna o maior número da lista fornecida.

  hcl

  max(1, 2, 3)  # 3

  - **min(num1, num2, ...)**: Retorna o menor número da lista fornecida.

  hcl

  min(1, 2, 3)  # 1

# 3. Funções de Data e Hora

  - **timestamp()**: Retorna a data e hora atuais no formato UTC.
  hcl

  timestamp()  # "2023-03-29T10:00:00Z"

  - **formatdate(format, timestamp)**: Formata um timestamp usando um formato específico.

  hcl

  formatdate("YYYY-MM-DD", "2023-03-29T10:00:00Z")  # "2023-03-29"

# 4. Funções de Coleção

  - **length(list)**: Retorna o número de elementos em uma lista.

  hcl

  length(["a", "b", "c"])  # 3

  - **element(list, index)**: Retorna o elemento em um índice específico de uma lista.

  hcl

  element(["a", "b", "c"], 1)  # "b"

  - **merge(map1, map2, ...)**: Mescla múltiplos mapas em um único mapa

  hcl

  merge({a = 1}, {b = 2})  # {a = 1, b = 2}

# 5. Funções de Decisão

  - **coalesce(val1, val2, ...)**: Retorna o primeiro valor não nulo na lista fornecida.

  hcl

  coalesce(null, null, "default")  # "default"

  - **lookup(map, key, default)**: Procura uma chave em um mapa e retorna seu valor ou um valor padrão se a chave não for encontrada.

  hcl

  lookup({a = 1, b = 2}, "b", 0)  # 2

# 6. Funções de Leitura de Arquivos

  - **file(path)**: Lê o conteúdo de um arquivo e o retorna como uma string.

  hcl

  file("example.txt")  # "conteúdo do arquivo"

  - **filebase64(path)**: Lê o conteúdo de um arquivo e o retorna como uma string codificada em Base64.

  hcl

  filebase64("example.txt")  # "Y29udGV1ZG8gZG8gYXJxdWl2bw=="

# 7. Funções de Hash e Criptografia

  - **base64encode(string)**: Codifica uma string em Base64.

  hcl

  base64encode("hello")  # "aGVsbG8="

  - **base64decode(base64)**: Decodifica uma string Base64.

  hcl

  base64decode("aGVsbG8=")  # "hello"

# Exemplos Práticos

### Exemplo 1: Concatenando Strings e Usando Variáveis Locais

  hcl

  locals {
    environment = "dev"
    region      = "us-west-2"
    name        = "app-server"
    full_name   = "${local.name}-${local.environment}-${local.region}"
  }

  output "server_name" {
    value = local.full_name
  }

  ### Exemplo 2: Manipulação de Listas e Mapas

  hcl

  locals {
    instance_types = ["t2.micro", "t2.small", "t2.medium"]
    instance_type  = element(local.instance_types, 1)
    tags = merge(
      { Name = "example" },
      { Environment = "dev" }
    )
  }

  output "selected_instance_type" {
    value = local.instance_type
  }

  output "tags" {
    value = local.tags
  }

# Documentação Oficial

Para uma lista completa e detalhada de todas as funções built-in do Terraform, consulte a documentação oficial.

Estas funções built-in tornam o Terraform uma ferramenta extremamente flexível e poderosa para definir, provisionar e gerenciar infraestrutura como código. Usando essas funções, você pode manipular dados de maneira eficiente e criar configurações mais dinâmicas e reutilizáveis.
