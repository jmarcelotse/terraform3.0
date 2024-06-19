# Data sources

Os data sources (fontes de dados) no Terraform permitem que você busque informações de recursos externos ou existentes para usar em sua configuração. Eles são úteis para obter dados de recursos que você não está gerenciando diretamente com o Terraform, mas que ainda precisa referenciar em sua infraestrutura.

# Como Funcionam os Data Sources

Os data sources permitem que você consulte dados de um provedor e use essas informações em seus recursos do Terraform. Aqui estão alguns exemplos de como usar data sources no Terraform:

## Exemplos de Data Sources

## 1. AWS - Obter Informações de uma AMI

Você pode usar um data source para obter a ID de uma Amazon Machine Image (AMI) específica baseada em filtros.

	hcl

	provider "aws" {
		region = "us-west-2"
	}

	data "aws_ami" "latest_amazon_linux" {
		most_recent = true

		filter {
			name   = "name"
			values = ["amzn2-ami-hvm-*-x86_64-gp2"]
		}

		filter {
			name   = "virtualization-type"
			values = ["hvm"]
		}

		owners = ["amazon"]
	}

	resource "aws_instance" "example" {
		ami           = data.aws_ami.latest_amazon_linux.id
		instance_type = "t2.micro"
	}

## 2. AWS - Obter Informações de um VPC

Você pode usar um data source para obter informações de uma VPC existente.

	hcl

	provider "aws" {
		region = "us-west-2"
	}

	data "aws_vpc" "default" {
		default = true
	}

	resource "aws_subnet" "example" {
		vpc_id     = data.aws_vpc.default.id
		cidr_block = "10.0.1.0/24"
		availability_zone = "us-west-2a"
	}

## 3. Consul - Obter Dados de uma Chave

Você pode usar um data source para obter dados de uma chave do Consul.

	hcl

	provider "consul" {
		address = "127.0.0.1:8500"
	}

	data "consul_key_prefix" "example" {
		prefix = "myapp/config/"
	}

	resource "local_file" "config" {
		content  = data.consul_key_prefix.example["myapp/config/database_url"].value
		filename = "/tmp/database_url.txt"
	}


## 4. Terraform - Obter Informações do Estado Remoto

Você pode usar um data source para obter informações do estado remoto de outro projeto Terraform.

	hcl

	data "terraform_remote_state" "network" {
		backend = "s3"

		config = {
			bucket = "my-terraform-state-bucket"
			key    = "network/terraform.tfstate"
			region = "us-west-2"
		}
	}

	resource "aws_instance" "example" {
		ami           = "ami-0c55b159cbfafe1f0"
		instance_type = "t2.micro"
		subnet_id     = data.terraform_remote_state.network.outputs.subnet_id
	}

## 5. Google Cloud - Obter Informações de uma Instância de Compute Engine

Você pode usar um data source para obter informações de uma instância de Compute Engine existente no Google Cloud.

	hcl

	provider "google" {
		project = "my-gcp-project"
		region  = "us-west1"
	}

	data "google_compute_instance" "example" {
		name = "existing-instance"
		zone = "us-west1-a"
	}

	resource "google_compute_disk" "example" {
		name  = "new-disk"
		size  = 50
		type  = "pd-standard"
		zone  = "us-west1-a"
		image = data.google_compute_instance.example.image
	}

# Benefícios dos Data Sources

1. **Reutilização de Recursos**: Permite usar recursos existentes sem precisar recriá-los, facilitando a integração com infraestruturas legadas.
2. **Consistência**: Garante que você esteja usando a mesma informação ou configuração que já existe em sua infraestrutura.
3. **Flexibilidade**: Permite buscar dados dinâmicos e utilizá-los em sua configuração do Terraform.
4. **Integração com Outros Sistemas**: Facilita a integração com outros sistemas e serviços, como Consul, AWS, GCP, etc.

# Exemplo Completo Usando Data Sources

Aqui está um exemplo completo combinando vários data sources em uma configuração Terraform:


	hcl

	provider "aws" {
		region = "us-west-2"
	}

	data "aws_vpc" "default" {
		default = true
	}

	data "aws_subnet_ids" "default" {
		vpc_id = data.aws_vpc.default.id
	}

	data "aws_ami" "latest_amazon_linux" {
		most_recent = true

		filter {
			name   = "name"
			values = ["amzn2-ami-hvm-*-x86_64-gp2"]
		}

		filter {
			name   = "virtualization-type"
			values = ["hvm"]
		}

		owners = ["amazon"]
	}

	resource "aws_instance" "example" {
		ami           = data.aws_ami.latest_amazon_linux.id
		instance_type = "t2.micro"
		subnet_id     = data.aws_subnet_ids.default.ids[0]

		tags = {
			Name = "ExampleInstance"
		}
	}


# Documentação Oficial

Para mais informações sobre os data sources disponíveis e sua sintaxe, consulte a documentação oficial do Terraform.

Os data sources são uma ferramenta poderosa no Terraform que permitem a integração e reutilização de recursos existentes em sua infraestrutura, tornando suas configurações mais eficientes e flexíveis.