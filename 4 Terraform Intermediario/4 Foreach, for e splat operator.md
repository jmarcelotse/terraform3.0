# 4 Foreach, for e splat operator

O Terraform oferece várias construções para iterar sobre coleções e manipular dados de maneira eficiente. Entre elas, **for_each**, **for** e o splat operator **(*)**. Vamos explorar cada uma dessas funcionalidades com exemplos.

## for_each

O **for_each** permite criar múltiplas instâncias de um recurso ou módulo com base em uma coleção, como uma lista ou mapa. Ele substitui o uso de **count** para cenários onde a chave ou o valor da coleção precisa ser acessível diretamente.

## Exemplo com Lista

  hcl

  resource "aws_instance" "example" {
    for_each = toset(["instance1", "instance2", "instance3"])

    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"

    tags = {
      Name = each.key
    }
  }

## Exemplo com Mapa

  hcl

  variable "instances" {
    type = map(string)
    default = {
      instance1 = "ami-0c55b159cbfafe1f0"
      instance2 = "ami-0c55b159cbfafe1f0"
    }
  }

  resource "aws_instance" "example" {
    for_each = var.instances

    ami           = each.value
    instance_type = "t2.micro"

    tags = {
      Name = each.key
    }
  }

# for Expression

O **for** expression é usado para transformar uma lista ou mapa em outra lista ou mapa. Ele é útil dentro de definições de variáveis locais (**locals**).
Exemplo com Lista

## Exemplo com Lista

  hcl

  locals {
    instance_names = ["instance1", "instance2", "instance3"]
    instance_tags  = [for name in local.instance_names : "${name}-tag"]
  }

  output "instance_tags" {
    value = local.instance_tags
  }

## Exemplo com Mapa

  hcl

  locals {
    instance_amis = {
      instance1 = "ami-0c55b159cbfafe1f0"
      instance2 = "ami-0c55b159cbfafe1f0"
    }

    instance_tags = { for key, value in local.instance_amis : key => "${key}-tag" }
  }

  output "instance_tags" {
    value = local.instance_tags
  }

# Splat Operator (*)

O splat operator é usado para extrair valores de todos os elementos em uma lista de objetos ou recursos. Ele é útil para simplificar a extração de informações.

## Exemplo Básico

  hcl

  resource "aws_instance" "example" {
    count = 3

    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
  }

  output "instance_ids" {
    value = aws_instance.example[*].id
  }

## Exemplo com for_each

  hcl

  resource "aws_instance" "example" {
    for_each = toset(["instance1", "instance2", "instance3"])

    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
  }

  output "instance_ids" {
    value = [for instance in aws_instance.example : instance.id]
  }

## Exemplo Completo Combinando for_each, for e Splat Operator

hcl

variable "instances" {
  type = map(string)
  default = {
    instance1 = "ami-0c55b159cbfafe1f0"
    instance2 = "ami-0c55b159cbfafe1f0"
    instance3 = "ami-0c55b159cbfafe1f0"
  }
}

resource "aws_instance" "example" {
  for_each = var.instances

  ami           = each.value
  instance_type = "t2.micro"

  tags = {
    Name = each.key
  }
}

output "instance_ids" {
  value = aws_instance.example[*].id
}

locals {
  instance_names = keys(var.instances)
  instance_tags  = [for name in local.instance_names : "${name}-tag"]
}

output "instance_tags" {
  value = local.instance_tags
}

# Explicação do Exemplo Completo

  1. **Variável instances**: Define um mapa de instâncias com suas AMIs.
  2. **Recurso aws_instance com for_each**: Cria uma instância para cada entrada no mapa **instances**, utilizando **each.key** para tags e **each.value** para AMI.
  3. **Output instance_ids**: Usa o splat operator para coletar os IDs das instâncias criadas.
  4. **Variáveis Locais (locals)**: Utiliza a expressão **for** para transformar a lista de nomes de instâncias em uma lista de tags.
  5. **Output instance_tags**: Exibe a lista de tags gerada pela expressão **for**.

# Conclusão

O uso de **for_each**, **for** e o splat operator permite criar configurações Terraform mais dinâmicas e reutilizáveis. Eles são ferramentas poderosas para iterar sobre coleções e manipular dados, tornando suas configurações mais eficientes e flexíveis. Para mais detalhes e exemplos, consulte a documentação oficial do Terraform.