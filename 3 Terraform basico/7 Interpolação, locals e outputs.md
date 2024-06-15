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