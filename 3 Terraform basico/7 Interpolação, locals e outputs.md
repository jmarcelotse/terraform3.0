# Interpolação, locals e outputs

Vamos explorar como usar interpolação, variáveis locais (**locals**) e saídas (**outputs**) no Terraform.

# Interpolação

Interpolação em Terraform permite que você utilize valores de variáveis, recursos ou outros elementos diretamente dentro das strings. A sintaxe para interpolação é **${}**.

**Exemplo de Interpolação**

hcl

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.instance_name}-instance"
  }
}

Aqui, estamos usando interpolação para criar um valor dinâmico para a tag **Name**, que concatena o valor de **var.instance_name** com a string **-instance**.

# Variáveis Locais (locals)

Locals permitem definir expressões locais dentro de um módulo. Eles são úteis para calcular valores que serão usados em múltiplos lugares dentro do módulo.

**Exemplo de Locals**

hcl

locals {
  instance_base_name = var.instance_name
  instance_full_name = "${local.instance_base_name}-instance"
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = local.instance_full_name
  }
}

Aqui, **locals** define duas variáveis locais: **instance_base_name** e **instance_full_name**. Essas variáveis locais são então usadas para definir a tag **Name**.

**Saídas (outputs)**

Outputs são usados para exportar valores de sua configuração do Terraform. Isso pode ser útil para depuração, ou para expor informações para outros módulos ou usuários.

# Exemplo de Outputs

hcl

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}

Neste exemplo, estamos definindo dois outputs: **instance_id** e **instance_public_ip**. Eles exportam o ID e o endereço IP público da instância EC2 criada.

# Arquivo Completo com Interpolação, Locals e Outputs

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

locals {
  instance_base_name = var.instance_name
  instance_full_name = "${local.instance_base_name}-instance"
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = local.instance_full_name
  }
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}

**terraform.tfvars**

hcl

instance_ami = "ami-0c55b159cbfafe1f0"

## Passos para Executar

1. **Inicializar o Diretório de Trabalho**:

  sh

  terraform init

2. **Criar um Plano de Execução**:

  sh

  terraform plan

3. **Aplicar as Mudanças**:

  sh

  terraform apply

4. **Visualizar Outputs**:

Após aplicar as mudanças, você pode ver os outputs executando:

  sh

  terraform output

5. **Destruir os Recursos**:

  sh

  terraform destroy

# Explicação

 - **Interpolação**: Utiliza **${}** para inserir valores de variáveis ou outras expressões dentro de strings.
 - **Locals**: Define expressões locais dentro de um módulo, permitindo cálculos e reutilização de valores.
 - **Outputs**: Exporta valores de sua configuração do Terraform, útil para depuração ou compartilhamento de informações.

Usar interpolação, locals e outputs no Terraform permite criar configurações mais dinâmicas, reutilizáveis e fáceis de depurar, facilitando a gestão e a comunicação de informações importantes sobre sua infraestrutura.