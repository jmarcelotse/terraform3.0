# Terraform import

O comando **terraform import** é usado para trazer recursos existentes na sua infraestrutura para o controle do Terraform. Isso é útil quando você deseja começar a gerenciar recursos que foram criados manualmente ou por outras ferramentas com Terraform, sem recriá-los ou alterá-los.

# Como Usar o terraform import

A seguir, apresento um guia passo a passo sobre como usar o **terraform import**.

## Passo 1: Definir o Recurso no Código Terraform

Antes de importar um recurso, você precisa definir o recurso no seu código Terraform. Isso é necessário para que o Terraform saiba o tipo de recurso e sua configuração básica. Vamos supor que você queira importar uma instância EC2 existente.

Crie um arquivo **main.tf** com a definição básica do recurso:

    hcl

    provider "aws" {
    region = "us-west-2"
    }

    resource "aws_instance" "example" {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    }

## Passo 2: Identificar o ID do Recurso

Para importar um recurso, você precisa do ID do recurso. No caso de uma instância EC2, o ID pode ser algo como **i-0abcdef1234567890**.

## Passo 3: Executar o Comando terraform import

Use o comando **terraform import** para importar o recurso. A sintaxe geral é:

    sh

    terraform import [options] ADDRESS ID

Para importar a instância EC2, execute:

    sh

    terraform import aws_instance.example i-0abcdef1234567890

# Exemplo Completo

**Arquivo main.tf**

    hcl

    provider "aws" {
        region = "us-west-2"
    }

    resource "aws_instance" "example" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
    }

***Comando de Importação***

    sh

    terraform import aws_instance.example i-0abcdef1234567890

## Verificação do Import

Depois de importar o recurso, é uma boa prática verificar se o Terraform reconheceu corretamente o estado do recurso importado.

## Passo 4: Executar terraform plan

Execute o comando **terraform plan** para verificar se o estado atual da infraestrutura corresponde ao que está definido no código Terraform:

    sh

    terraform plan

Se o Terraform não apresentar nenhuma mudança necessária, significa que o recurso foi importado corretamente.

# Considerações Adicionais

 - **Estado do Recurso**: Quando um recurso é importado, o Terraform atualiza o arquivo de estado (**terraform.tfstate**) para incluir o recurso importado.
 - **Configuração Completa**: Após a importação, você deve complementar o recurso importado no código Terraform com todas as suas configurações, para que o estado desejado esteja completamente definido. Isso é crucial para que futuras execuções de **terraform apply** não façam alterações indesejadas.
- **Outros Recursos**: O **terraform import** pode ser usado para importar muitos tipos diferentes de recursos, como instâncias de banco de dados, buckets S3, grupos de segurança, etc. A sintaxe geral permanece a mesma, mas o tipo de recurso e o ID variam.

# Exemplo de Importação de Outro Tipo de Recurso

## Importando um Bucket S3

1. **Definir o recurso no código Terraform**:

hcl

    resource "aws_s3_bucket" "example" {
        bucket = "my-existing-bucket"
    }

2. **Executar o comando terraform import**:

sh

    terraform import aws_s3_bucket.example my-existing-bucket

# Boas Práticas para o terraform import

1. **Backup do Estado**: Antes de realizar a importação, faça um backup do arquivo de estado atual (**terraform.tfstate**).
2. **Verificação Pós-Importação**: Sempre verifique o estado com **terraform plan** após a importação para garantir que o Terraform reconheceu corretamente o recurso.
3. **Documentação**: Documente o processo de importação e quaisquer ajustes feitos no código Terraform após a importação.

O **terraform import** é uma ferramenta poderosa que permite a migração suave de recursos existentes para o controle do Terraform, facilitando a gestão e a automação da infraestrutura.