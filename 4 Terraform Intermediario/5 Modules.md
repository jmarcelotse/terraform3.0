# Modules

Os módulos no Terraform são conjuntos de recursos que são agrupados e reutilizados em diferentes partes da infraestrutura. Eles ajudam a organizar e reutilizar código, facilitando a manutenção e a escalabilidade das configurações.

# Estrutura de um Módulo

Um módulo no Terraform é basicamente um diretório que contém os seguintes arquivos:

- **main.tf**: Define os recursos do módulo.
- **variables.tf**: Define as variáveis de entrada do módulo.
- **outputs.tf**: Define as saídas do módulo.

# Exemplo de Criação e Uso de um Módulo

Vamos criar um exemplo de módulo que provisiona uma instância EC2 na AWS.

## 1. Criação do Módulo

Crie um diretório para o módulo, por exemplo, **modules/ec2_instance**.

Dentro deste diretório, crie os seguintes arquivos:

**main.tf**

    hcl

    provider "aws" {
    region = var.region
    }

    resource "aws_instance" "example" {
    ami           = var.ami
    instance_type = var.instance_type

    tags = {
        Name = var.instance_name
    }
    }

**variables.tf**

    hcl

    variable "region" {
    description = "The AWS region to deploy resources"
    type        = string
    }

    variable "ami" {
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
    }

## outputs.tf

    hcl

    output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.example.id
    }

    output "instance_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.example.public_ip
    }

## 2. Uso do Módulo

Agora, vamos usar esse módulo em uma configuração principal. Crie um diretório separado para a configuração principal, por exemplo, **main**.

Dentro deste diretório, crie os seguintes arquivos:

**main.tf**

    hcl

    provider "aws" {
    region = "us-west-2"
    }

    module "ec2_instance" {
    source        = "../modules/ec2_instance"
    region        = "us-west-2"
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    instance_name = "ExampleInstance"
    }

    output "instance_id" {
    value = module.ec2_instance.instance_id
    }

    output "instance_public_ip" {
    value = module.ec2_instance.instance_public_ip
    }

## Estrutura Completa dos Diretórios e Arquivos

    css

    main/
        main.tf
        outputs.tf

    modules/
        ec2_instance/
            main.tf
            variables.tf
            outputs.tf

## Executando a Configuração

1. **Inicialize o Diretório de Trabalho**:

Navegue até o diretório main e inicialize o Terraform.

    sh

    terraform init

2. **Crie um Plano de Execução**:

Crie um plano para visualizar as mudanças que serão feitas.

    sh

    terraform plan

3. **Aplique as Mudanças**:

Aplique as mudanças para provisionar os recursos.

    sh

    terraform apply

4. **Destruir os Recursos**:

Para destruir os recursos criados, use o comando:

    sh

    terraform destroy

# Benefícios dos Módulos

1. **Reutilização**: Módulos permitem reutilizar código em diferentes partes do projeto ou em diferentes projetos.
2. **Organização**: Facilita a organização do código, mantendo configurações específicas separadas.
3. **Manutenção**: Torna a manutenção mais fácil, pois as mudanças podem ser feitas em um módulo centralizado e aplicadas em todos os lugares onde o módulo é usado.
4. **Escalabilidade**: Ajuda a escalar a infraestrutura de forma mais eficiente, reutilizando componentes configuráveis.

# Variáveis e Saídas no Módulo

 - **Variáveis**: Usadas para passar valores de entrada para o módulo.
 - **Saídas**: Usadas para exportar valores de um módulo, que podem ser usados em outras partes da configuração.

# Exemplo de Módulo com Variáveis e Saídas

**variables.tf no Módulo**

    hcl
    variable "region" {
    description = "The AWS region to deploy resources"
    type        = string
    }

    variable "ami" {
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
    }

**outputs.tf no Módulo**

    hcl

    output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.example.id
    }

    output "instance_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.example.public_ip
    }

# Exemplo de Uso do Módulo

**main.tf na Configuração Principal**

    hcl

    provider "aws" {
    region = "us-west-2"
    }

    module "ec2_instance" {
    source        = "../modules/ec2_instance"
    region        = "us-west-2"
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    instance_name = "ExampleInstance"
    }

    output "instance_id" {
    value = module.ec2_instance.instance_id
    }

    output "instance_public_ip" {
    value = module.ec2_instance.instance_public_ip
    }

# Conclusão

Os módulos no Terraform são uma maneira poderosa de organizar, reutilizar e manter suas configurações de infraestrutura como código. Eles permitem a criação de componentes reutilizáveis e configuráveis, facilitando a gestão e a escalabilidade da infraestrutura. Para mais informações sobre módulos, consulte a documentação oficial do Terraform.