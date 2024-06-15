terraform plan -out="tfpan.out"

# Alterando Recursos com Terraform

Para alterar recursos gerenciados pelo Terraform, você precisa modificar os arquivos de configuração e aplicar as mudanças. Aqui está como fazer isso:

# 1. Modificando o Arquivo de Configuração

Suponha que você queira mudar o tipo de instância EC2 de **t2.micro** para **t2.small**. Edite o arquivo **main.tf** ou **terraform.tfvars** para refletir essa mudança.

**Atualizando main.tf diretamente**:

hcl

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = "t2.small"  # Alterando de t2.micro para t2.small

  tags = {
    Name = var.instance_name
  }
}

**Ou atualizando terraform.tfvars:**

hcl

instance_type = "t2.small"  # Alterando de t2.micro para t2.small

# 2. Criar um Plano de Execução

No terminal, crie um plano de execução para verificar as mudanças:

sh

terraform plan

Este comando mostrará quais mudanças serão feitas para atualizar a infraestrutura para o novo estado.

Alterando Recursos com Terraform

Para alterar recursos gerenciados pelo Terraform, você precisa modificar os arquivos de configuração e aplicar as mudanças. Aqui está como fazer isso:
1. Modificando o Arquivo de Configuração

Suponha que você queira mudar o tipo de instância EC2 de t2.micro para t2.small. Edite o arquivo main.tf ou terraform.tfvars para refletir essa mudança.
Atualizando main.tf diretamente:

hcl

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = "t2.small"  # Alterando de t2.micro para t2.small

  tags = {
    Name = var.instance_name
  }
}

Ou atualizando terraform.tfvars:

hcl

instance_type = "t2.small"  # Alterando de t2.micro para t2.small

2. Criar um Plano de Execução

No terminal, crie um plano de execução para verificar as mudanças:

sh

terraform plan

Este comando mostrará quais mudanças serão feitas para atualizar a infraestrutura para o novo estado.

# 3. Aplicar as Mudanças

Depois de revisar o plano de execução, aplique as mudanças:

sh

terraform apply


Digite **yes** para confirmar e aplicar as mudanças.

# Destruindo Recursos com Terraform

Se você quiser destruir todos os recursos gerenciados pelo Terraform, você pode usar o comando **terraform destroy**.

# 1. Destruindo Recursos

No terminal, execute o comando:

sh

terraform destroy

O Terraform solicitará uma confirmação para destruir os recursos. Digite **yes** e pressione Enter.

# 2. Revisando o Plano de Destruição

Assim como o **terraform plan**, o **terraform destroy** primeiro cria um plano de destruição, mostrando todos os recursos que serão removidos. Esta é uma boa oportunidade para revisar e garantir que você realmente deseja destruir todos os recursos listados.

# Exemplo Completo

**Arquivo variables.tf**

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

**Arquivo main.tf**

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

**Arquivo terraform.tfvars**

hcl

instance_ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.small"  # Atualizando de t2.micro para t2.small

# Passos para Executar

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


# Benefícios do Uso do Terraform

 - **Consistência**: Terraform garante que os recursos sejam configurados de forma consistente.
 - **Automação**: Permite a automação da criação e gestão da infraestrutura.
 - **Versionamento**: As configurações podem ser versionadas e rastreadas.
 - **Portabilidade**: Suporta múltiplos provedores de infraestrutura.

Usar Terraform para gerenciar sua infraestrutura permite que você automatize, versione e mantenha consistência em seus recursos de maneira eficiente. Alterar e destruir recursos é simples e segue um fluxo claro de modificação, revisão e aplicação das mudanças.