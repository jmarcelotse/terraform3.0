#  Variáveis

Para gerenciar variáveis em Terraform, você pode definir variáveis de diversas maneiras, como em arquivos de definição de variáveis (**variables.tf**), arquivos de valores de variáveis (**terraform.tfvars**), variáveis de ambiente e diretamente na linha de comando. Vamos explorar como utilizar essas variáveis de maneira eficaz.

# Definindo Variáveis

1. **Arquivo variables.tf**

Crie um arquivo **variables.tf** para definir as variáveis usadas no seu script Terraform:

hcl

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name tag for the instance"
  type        = string
  default     = "ExampleInstance"
}

2. **Arquivo terraform.tfvars**

Crie um arquivo **terraform.tfvars** para definir os valores das variáveis. Este arquivo é útil para definir valores padrão que podem ser substituídos:

hcl

instance_ami = "ami-0c55b159cbfafe1f0"

3. **Variáveis de Ambiente**

Você pode definir variáveis de ambiente no seu terminal para substituir ou definir valores das variáveis do Terraform. As variáveis de ambiente devem seguir o formato **TF_VAR_<variable_name>**:

sh

export TF_VAR_aws_region="us-west-2"
export TF_VAR_instance_ami="ami-0c55b159cbfafe1f0"
export TF_VAR_instance_type="t2.micro"
export TF_VAR_instance_name="ExampleInstance"

4. **Linha de Comando**

Você também pode passar valores de variáveis diretamente na linha de comando ao executar **terraform apply** ou **terraform plan**:

sh

terraform apply -var="instance_ami=ami-0c55b159cbfafe1f0" -var="instance_type=t2.micro"

# Usando Variáveis no Arquivo de Configuração

**Arquivo main.tf**

Use as variáveis definidas em seu arquivo **main.tf**:

hcl

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

# Passos para Executar o Script com Variáveis

1. **Inicializar o Diretório de Trabalho**:

sh

terraform init

2. **Criar um Plano de Execução**:

sh

terraform plan

3. **Aplicar as Mudanças**:

sh

terraform apply

4. **Destruir os Recursos**:

sh

terraform destroy

# Arquivos Completos

**variables.tf**

hcl
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name tag for the instance"
  type        = string
  default     = "ExampleInstance"
}

**main.tf**

hcl
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

**terraform.tfvars**

hcl

instance_ami = "ami-0c55b159cbfafe1f0"

# Benefícios do Uso de Variáveis em Terraform

1. **Flexibilidade**: Facilita a personalização e reutilização da configuração para diferentes ambientes e cenários.
2. **Manutenção**: Torna a manutenção mais fácil, pois mudanças nos valores podem ser feitas em um único lugar.
3. **Segurança**: Sensíveis como chaves de acesso podem ser gerenciadas de forma segura através de variáveis de ambiente ou sistemas de gerenciamento de segredos.
4. **Automação**: Melhora a automação e integração com pipelines CI/CD, permitindo a injeção de variáveis em diferentes estágios do pipeline.

Usar variáveis em Terraform permite que você crie configurações modulares e reutilizáveis, facilitando a gestão de diferentes ambientes e parâmetros de infraestrutura.

####

terra plan

para ambiente de ci

TF_VAR_aws_profile=default terraform plan

terraform plan -var="aws_profile=default"

terraform plan -var-file="prod.tfvars"