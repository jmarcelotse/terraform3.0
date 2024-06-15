#  O arquivo de estado tfstate

O arquivo de estado (**terraform.tfstate**) é um componente crítico no funcionamento do Terraform. Ele mantém o estado atual da infraestrutura gerenciada pelo Terraform, permitindo que o Terraform saiba quais recursos existem, suas configurações e quaisquer metadados associados. Vamos explorar como ele funciona, sua importância, e boas práticas de gerenciamento.

## O que é o Arquivo de Estado (terraform.tfstate)?

O arquivo **terraform.tfstate** é um arquivo JSON que armazena informações sobre os recursos que o Terraform gerencia. Esse arquivo é criado e atualizado automaticamente pelo Terraform durante as operações de **apply**, **plan**, **destroy** e outras.

## Importância do Arquivo de Estado

1. **Rastreamento de Recursos**: Mantém um mapeamento entre a configuração declarativa no código Terraform e os recursos reais provisionados na infraestrutura.
2. **Planejamento Incremental**: Permite que o Terraform saiba o que já foi criado e apenas aplique mudanças incrementais, em vez de recriar toda a infraestrutura.
3. **Gerenciamento de Dependências**: Ajuda o Terraform a entender as dependências entre recursos e garantir a ordem correta de criação, modificação e destruição.
4. **Persistência de Metadados**: Armazena informações adicionais que podem ser necessárias para a gestão contínua dos recursos.

## Estrutura do Arquivo de Estado

Aqui está um exemplo simplificado de um arquivo **terraform.tfstate**:

json
{
  "version": 4,
  "terraform_version": "0.12.29",
  "serial": 8,
  "lineage": "f3a567b0-3a8a-11eb-b378-0242ac130003",
  "outputs": {
    "instance_id": {
      "value": "i-0abcdef1234567890",
      "type": "string"
    },
    "instance_public_ip": {
      "value": "54.123.45.67",
      "type": "string"
    }
  },
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "example",
      "provider": "provider.aws",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "ami": "ami-0c55b159cbfafe1f0",
            "instance_type": "t2.micro",
            "tags": {
              "Name": "ExampleInstance"
            },
            "id": "i-0abcdef1234567890",
            "public_ip": "54.123.45.67"
          }
        }
      ]
    }
  ]
}


# Gerenciamento do Arquivo de Estado

## 1. Armazenamento Remoto

Para equipes colaborativas e ambientes de produção, é recomendável armazenar o arquivo de estado de forma remota. Isso permite acesso compartilhado e previne a corrupção do estado. Terraform suporta vários backends de armazenamento remoto, como:

 - **Amazon S3**
 - **Google Cloud Storage**
 - **Azure Blob Storage**
 - **Terraform Cloud**
 - **Consul**

## Exemplo: Armazenamento Remoto no Amazon S3

Crie um arquivo **backend.tf** para configurar o backend S3:

hcl

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "path/to/my/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}


## 2. Bloqueio de Estado

Para evitar condições de corrida e corrupção de estado, use mecanismos de bloqueio de estado, como DynamoDB com S3, que previnem múltiplas operações simultâneas.

### Exemplo: Configuração do Bloqueio com DynamoDB

Certifique-se de ter uma tabela DynamoDB para bloqueio:

hcl

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

## Boas Práticas

1. **Versionamento**: Versione seu arquivo de estado armazenado remotamente para possibilitar rollback em caso de necessidade.
2. **Segurança**: Mantenha o arquivo de estado seguro, pois ele pode conter informações sensíveis.
3. **Colaboração**: Use armazenamento remoto e bloqueio de estado para colaborar de forma segura e eficiente em equipes.
4. **Backup**: Mantenha backups regulares do estado para recuperar em caso de corrupção ou perda de dados.

## Comandos Úteis Relacionados ao Estado

 - **terraform state list**: Lista todos os recursos gerenciados pelo estado.
 - **terraform state show <resource>**: Exibe detalhes de um recurso específico.
 - **terraform state mv**: Move um recurso no estado.
 - **terraform state rm**: Remove um recurso do estado.
 - **terraform state pull**: Puxa o arquivo de estado remoto para o local.
 - **terraform state push**: Empurra o arquivo de estado local para o remoto.

# Conclusão

O arquivo de estado (**terraform.tfstate**) é essencial para o funcionamento eficaz do Terraform, permitindo gerenciar infraestrutura de forma declarativa e incremental. Entender sua estrutura, importância e boas práticas de gerenciamento é fundamental para qualquer administrador de infraestrutura que utiliza Terraform. Armazenar o estado de forma segura e colaborativa é crucial para evitar problemas e garantir uma operação tranquila.