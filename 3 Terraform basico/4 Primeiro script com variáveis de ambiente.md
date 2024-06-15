# Primeiro script com variáveis de ambiente

Para criar um script Terraform que utiliza variáveis de ambiente, vamos definir variáveis no arquivo de configuração e depois utilizar essas variáveis em nosso código. Isso permite maior flexibilidade e reutilização do código. A seguir, veremos como definir e usar variáveis de ambiente no Terraform.

# Passo 1: Definir Variáveis no Arquivo de Configuração

Crie um arquivo chamado **variables.tf** e defina as variáveis que você deseja usar:

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

# Passo 2: Usar Variáveis no Arquivo de Configuração Principal

Crie um arquivo chamado **main.tf** e use as variáveis definidas no **variables.tf**:

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

# Passo 3: Definir Variáveis em um Arquivo de Variáveis

Crie um arquivo chamado **terraform.tfvars** para definir os valores das variáveis. Este arquivo é opcional, mas pode ser útil para definir valores de variáveis em um único lugar:

hcl

instance_ami = "ami-0c55b159cbfafe1f0"

# Passo 4: Exportar Variáveis de Ambiente

Você pode definir variáveis de ambiente no seu terminal para substituir ou definir valores das variáveis do Terraform:

sh

export TF_VAR_aws_region="us-west-2"
export TF_VAR_instance_ami="ami-0c55b159cbfafe1f0"
export TF_VAR_instance_type="t2.micro"
export TF_VAR_instance_name="ExampleInstance"

# Passo 5: Inicializar o Diretório de Trabalho
No terminal, navegue até o diretório onde os arquivos **main.tf**, **variables.tf** e **terraform.tfvars** estão localizados e execute:

sh

terraform init

# Passo 6: Criar um Plano de Execução

Crie um plano de execução para verificar quais ações o Terraform tomará para alcançar o estado descrito na configuração:

sh

terraform plan

# Passo 7: Aplicar a Configuração

Depois de revisar o plano de execução e confirmar que as ações são o que você espera, você pode aplicar a configuração para provisionar os recursos:

sh

terraform apply

O Terraform solicitará uma confirmação para aplicar as mudanças. Digite **yes** e pressione Enter.

# Passo 8: Limpar os Recursos

Se você quiser destruir a infraestrutura provisionada pelo Terraform, você pode usar o comando **destroy**:

sh

terraform destroy

O Terraform solicitará uma confirmação para destruir os recursos. Digite **yes** e pressione Enter.

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

# Explicação

1. **variables.tf**: Define variáveis que podem ser configuradas para personalizar a infraestrutura.
2. **main.tf**: Usa as variáveis definidas para configurar o provider AWS e criar uma instância EC2.
3. **terraform.tfvars**: Opcionalmente, define valores para as variáveis, que podem ser sobrescritos por variáveis de ambiente.
4. **Variáveis de Ambiente**: **export TF_VAR_<variable_name>** é usado para definir valores das variáveis diretamente no ambiente do terminal.

Usar variáveis em Terraform permite criar configurações flexíveis e reutilizáveis, facilitando a gestão de diferentes ambientes e parâmetros de infraestrutura.