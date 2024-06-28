# Primeiro script

Para criar o seu primeiro script com Terraform, vamos passar por um exemplo simples de provisionamento de uma instância EC2 na AWS. Aqui está um passo a passo:

# Passo 1: Configurar o Provider

Primeiro, você precisa configurar o provider da AWS. O provider é a forma como o Terraform se comunica com o serviço que você está gerenciando. Neste caso, será a AWS.

Crie um arquivo chamado **main.tf** e adicione o seguinte código:

  hcl
  
  provider "aws" {
    region = "us-west-2"
  }

# Passo 2: Criar um Resource

Agora, vamos definir um recurso que queremos provisionar. Neste exemplo, vamos criar uma instância EC2.

Adicione o seguinte código ao arquivo **main.tf**:

  hcl
  
  resource "aws_instance" "example" {
    ami           = "ami-0c55b159cbfafe1f0" # Este é um ID de AMI público. Você pode usar um ID diferente conforme necessário.
    instance_type = "t2.micro"
  
    tags = {
      Name = "ExampleInstance"
    }
  }

# Passo 3: Inicializar o Diretório de Trabalho

Antes de aplicar a configuração, você precisa inicializar o diretório de trabalho do Terraform. Isso baixará os plugins necessários para interagir com a AWS.

No terminal, navegue até o diretório onde o arquivo **main.tf** está localizado e execute:

sh
terraform init

# Passo 4: Criar um Plano de Execução

Crie um plano de execução para verificar quais ações o Terraform tomará para alcançar o estado descrito na configuração.

Execute o seguinte comando no terminal:

sh
terraform plan

# Passo 5: Aplicar a Configuração

Depois de revisar o plano de execução e confirmar que as ações são o que você espera, você pode aplicar a configuração para provisionar os recursos.

Execute o seguinte comando no terminal:

sh

terraform apply

O Terraform solicitará uma confirmação para aplicar as mudanças. Digite **yes** e pressione Enter.

# Passo 6: Limpar os Recursos

Se você quiser destruir a infraestrutura provisionada pelo Terraform, você pode usar o comando destroy.

Execute o seguinte comando no terminal:

sh
terraform destroy

O Terraform solicitará uma confirmação para destruir os recursos. Digite **yes** e pressione Enter.

# Arquivo Completo: main.tf

Aqui está o arquivo completo **main.tf** com os passos mencionados:

hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}

Este é um exemplo básico que pode ser expandido para incluir outros recursos e configurações conforme necessário. Para ambientes mais complexos, você pode dividir suas configurações em vários arquivos e usar módulos do Terraform para organizar sua infraestrutura.

# Explicação Detalhada
# 1. Provider

hcl
provider "aws" {
  region = "us-west-2"
}

- **provider**: Esta linha define o provider que o Terraform usará. Providers são responsáveis por gerenciar os recursos da infraestrutura específica. Neste caso, estamos usando o provider **aws**.
- **region**: Esta configuração especifica a região da AWS onde os recursos serão provisionados. Aqui, a região é definida como **us-west-2**, que corresponde à região Oeste dos EUA (Oregon).

# 2. Resource

hcl

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}

 - **resource**: Esta linha define um recurso que o Terraform gerenciará. O primeiro argumento (**aws_instance**) é o tipo de recurso, e o segundo argumento (**example**) é o nome lógico que você dá ao recurso dentro da configuração do Terraform. Este nome é usado para referenciar este recurso em outras partes da configuração.
 - **ami**: Especifica a Amazon Machine Image (**AMI**) que será usada para criar a instância. O valor **ami-0c55b159cbfafe1f0** é o ID de uma AMI pública. AMIs são imagens de sistemas operacionais que você pode usar para inicializar instâncias.
 - **instance_type**: Especifica o tipo da instância EC2. **t2.micro** é um tipo de instância de baixo custo adequado para cargas de trabalho pequenas e testes.
 - **tags**: Define tags que serão aplicadas ao recurso. Tags são pares chave-valor usados para categorizar e organizar recursos na AWS. Neste exemplo, estamos adicionando uma tag com a chave **Name** e o valor **ExampleInstance**.

# Passos para Executar o Script

1. **Inicializar o Diretório de Trabalho**

    sh

    terraform init

Este comando inicializa o diretório de trabalho, baixando os plugins necessários para o provider AWS.

2. **Criar um Plano de Execução**

    sh

    terraform plan

Este comando gera um plano de execução, mostrando quais ações o Terraform realizará para alcançar o estado desejado.

3. **Aplicar a Configuração**

    sh

    terraform apply

Este comando aplica a configuração, provisionando os recursos conforme definido no arquivo **main.tf**.

4. **Destruir os Recursos**

    sh

    terraform destroy

Este comando destrói todos os recursos gerenciados pelo Terraform, removendo a infraestrutura criada.

# Benefícios do Uso do Terraform

1. **Consistência e Repetibilidade**: Como a infraestrutura é definida como código, você pode garantir que a mesma configuração seja aplicada de forma consistente em diferentes ambientes.
2. **Versionamento**: Usando sistemas de controle de versão como Git, você pode versionar suas configurações de infraestrutura, facilitando o rastreamento de mudanças e a colaboração.
3. **Automação**: A configuração da infraestrutura pode ser automatizada, reduzindo o esforço manual e minimizando erros.
4. **Portabilidade**: O Terraform suporta múltiplos providers, permitindo gerenciar a infraestrutura em diferentes plataformas de nuvem e ambientes on-premises com a mesma ferramenta.

Este exemplo básico pode ser expandido para incluir outros recursos e configurações, como redes, segurança, armazenamento e muito mais, à medida que suas necessidades de infraestrutura crescem.
