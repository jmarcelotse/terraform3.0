# Remote state no S3

Para armazenar o estado do Terraform remotamente em um bucket S3 na AWS, você deve configurar um backend remoto no Terraform. Usar o S3 como backend para armazenar o estado permite colaboração segura, controle de versões e evita conflitos de estado quando múltiplas pessoas trabalham no mesmo projeto.

# Passos para Configurar o Remote State no S3

## Passo 1: Criar um Bucket S3

Primeiro, crie um bucket S3 na AWS. Você pode fazer isso através do console da AWS, da CLI da AWS ou usando Terraform.

***Exemplo de criação de bucket usando Terraform:***

    hcl

    provider "aws" {
        region = "us-west-2"
    }

    resource "aws_s3_bucket" "terraform_state" {
        bucket = "my-terraform-state-bucket"
        acl    = "private"
    }

    resource "aws_s3_bucket_versioning" "terraform_state" {
        bucket = aws_s3_bucket.terraform_state.bucket

        versioning_configuration {
            status = "Enabled"
        }
    }

## Passo 2: Configurar o Backend no Terraform

Configure o backend no seu arquivo **main.tf** ou crie um arquivo separado, como **backend.tf**.

Exemplo de configuração do backend no **main.tf**:

    hcl

    terraform {
        backend "s3" {
            bucket         = "my-terraform-state-bucket"
            key            = "path/to/my/terraform.tfstate"
            region         = "us-west-2"
            encrypt        = true
            dynamodb_table = "terraform-lock-table"
        }
    }

**Explicação dos Parâmetros**:

 - **bucket**: O nome do bucket S3 onde o estado será armazenado.
 - **key**: O caminho no bucket onde o arquivo de estado será armazenado.
 - **region**: A região da AWS onde o bucket S3 está localizado.
 - **encrypt**: Se definido como true, o estado será criptografado no S3.
 - **dynamodb_table**: Nome de uma tabela DynamoDB usada para controle de bloqueio para evitar condições de corrida.

## Passo 3: Configurar a Tabela DynamoDB para Bloqueio de Estado

Crie uma tabela DynamoDB para usar o bloqueio de estado, garantindo que apenas uma operação possa modificar o estado de cada vez.

Exemplo de criação de tabela DynamoDB usando Terraform:

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

## Passo 4: Inicializar o Backend

Após configurar o backend, inicialize o diretório de trabalho do Terraform para aplicar as configurações do backend.

No terminal, execute:

    sh

    terraform init

Este comando inicializa a configuração do backend, migra o estado local para o backend remoto (S3) e baixa os plugins necessários.

# Exemplo Completo

Aqui está um exemplo completo de configuração:

main.tf

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

	resource "aws_s3_bucket" "terraform_state" {
		bucket = "my-terraform-state-bucket"
		acl    = "private"
	}

	resource "aws_s3_bucket_versioning" "terraform_state" {
		bucket = aws_s3_bucket.terraform_state.bucket

		versioning_configuration {
			status = "Enabled"
		}
	}

	resource "aws_dynamodb_table" "terraform_locks" {
		name         = "terraform-lock-table"
		billing_mode = "PAY_PER_REQUEST"
		hash_key     = "LockID"

		attribute {
			name = "LockID"
			type = "S"
		}
	}

	terraform {
		backend "s3" {
			bucket         = "my-terraform-state-bucket"
			key            = "path/to/my/terraform.tfstate"
			region         = "us-west-2"
			encrypt        = true
			dynamodb_table = "terraform-lock-table"
		}
	}

# Executando o Script

1. **Inicializar o Diretório de Trabalho**:

	sh

	terraform init

Isso configurará o backend remoto e migrará o estado local para o bucket S3.

2. **Criar um Plano de Execução**:

	sh

	terraform plan

3. **Aplicar as Mudanças**:

	sh

	terraform apply

4. **Destruir os Recursos**:

	sh

	terraform destroy

# Boas Práticas

 - **Segurança**: Mantenha o bucket S3 privado e configure políticas de acesso apropriadas.
 - **Versionamento**: Habilite o versionamento do bucket S3 para rastrear mudanças no estado ao longo do tempo.
 - **Bloqueio de Estado**: Use a tabela DynamoDB para bloquear o estado e evitar condições de corrida.
 - **Backups**: Considere criar backups regulares do estado para recuperação em caso de corrupção ou perda de dados.

Usar o backend remoto no S3 permite uma gestão eficiente e colaborativa do estado do Terraform, melhorando a segurança e a integridade dos dados de estado.


terraform init -backend=true -backend-config=backend.hcl