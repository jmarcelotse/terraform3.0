# O que é Terraform?

O Terraform é uma ferramenta de código aberto desenvolvida pela HashiCorp que permite aos usuários definir e provisionar infraestrutura através de um código declarativo. Com o Terraform, você pode criar, gerenciar e atualizar recursos de computação, rede e armazenamento em nuvens públicas e privadas usando arquivos de configuração legíveis e reutilizáveis.

# Principais Características do Terraform

1. **Código Declarativo**: Permite definir a infraestrutura desejada em arquivos de configuração que descrevem o estado final desejado dos recursos. O Terraform, então, gerencia automaticamente a criação, atualização e exclusão dos recursos para atingir esse estado final.

2. **Independência de Provedor**: Suporta múltiplos provedores de nuvem (como AWS, Azure, Google Cloud) e serviços locais, permitindo a gestão de infraestrutura híbrida e multi-nuvem a partir de uma única ferramenta.

3. **Planos de Execução**: Antes de aplicar qualquer mudança, o Terraform gera um plano de execução que mostra exatamente o que será alterado. Isso permite revisar e aprovar as mudanças antes de executá-las.

4. **Gestão de Estado**: Mantém um arquivo de estado que rastreia os recursos gerenciados pelo Terraform. Esse estado é usado para mapear a configuração definida nos arquivos de configuração para os recursos reais.

5. **Modularidade**: Suporta a criação de módulos reutilizáveis, que permitem encapsular partes da infraestrutura e reutilizá-las em diferentes projetos ou ambientes.

# Fluxo de Trabalho do Terraform

1. **Escrever Configurações**: As configurações são escritas em HCL (HashiCorp Configuration Language) ou JSON. Essas configurações descrevem os recursos e suas dependências.

2. **Inicializar o Diretório de Trabalho**: O comando **terraform init** inicializa o diretório de trabalho contendo os arquivos de configuração do Terraform. Isso prepara o ambiente para o uso do Terraform.

3. **Planejar as Mudanças**: O comando **terraform plan** gera um plano de execução, mostrando as ações que o Terraform executará para alcançar o estado desejado. Esse passo é crucial para revisar e validar as mudanças antes de aplicá-las.

4. **Aplicar as Mudanças**: O comando **terraform apply** aplica as mudanças descritas no plano de execução. O Terraform provisiona ou modifica os recursos para que correspondam ao estado desejado.

5. **Gerenciar e Monitorar**: Após a aplicação, o Terraform pode continuar a gerenciar a infraestrutura. O arquivo de estado é atualizado para refletir o estado atual dos recursos.

6. **Destruir Recursos**: O comando **terraform destroy** é usado para destruir a infraestrutura gerenciada pelo Terraform, removendo todos os recursos definidos nos arquivos de configuração.

# Exemplos de Uso

1. **Provisionamento de Instâncias na Nuvem**: Usar Terraform para criar e configurar instâncias EC2 na AWS, incluindo a configuração de segurança e redes.

2. **Configuração de Rede**: Definir e gerenciar redes virtuais, sub-redes, regras de firewall e outros componentes de rede.

3. **Gerenciamento de Serviços**: Provisionar e configurar serviços como bancos de dados gerenciados, balanceadores de carga, e armazenamento em nuvens públicas.

# Exemplo de Arquivo de Configuração Terraform (HCL)

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

Neste exemplo, o arquivo de configuração define um provedor AWS e uma instância EC2 com um tipo de instância **t2.micro** e uma tag de nome "ExampleInstance".

O Terraform é uma ferramenta poderosa que permite a gestão de infraestrutura de maneira eficiente, escalável e consistente, suportando práticas modernas de DevOps e automação.

# Exemplo 1: Provisionamento de uma Instância EC2 na AWS

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

# Exemplo 2: Criando uma VPC e Subnet na AWS

hcl

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ExampleVPC"
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "ExampleSubnet"
  }
}

# Exemplo 3: Provisionando um Banco de Dados RDS na AWS

hcl

provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "exampledb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql8.0"

  tags = {
    Name = "ExampleDB"
  }
}

# Exemplo 4: Criando um Load Balancer com Instâncias de Backend

hcl

provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "lb_sg" {
  name_prefix = "lb-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LoadBalancerSG"
  }
}

resource "aws_elb" "example" {
  name               = "example-lb"
  availability_zones = ["us-west-2a", "us-west-2b"]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  instances                   = [aws_instance.example.id]
  security_groups             = [aws_security_group.lb_sg.id]

  tags = {
    Name = "ExampleLoadBalancer"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}

# Exemplo 5: Criando um Bucket S3 na AWS

hcl

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-unique-bucket-name"
  acl    = "private"

  tags = {
    Name = "ExampleBucket"
  }
}

# Exemplo 6: Configurando um Azure Virtual Network e Subnet

hcl

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    environment = "staging"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Exemplo de Criação de Roles e Policies no AWS com Terraform

Aqui está um exemplo de como criar uma role e uma policy no AWS usando Terraform. Este exemplo inclui a criação de uma policy que permite acesso de leitura a um bucket S3, a criação de uma role com essa policy anexada e a configuração de uma instância EC2 para usar essa role.

# 1. Definindo o Provider

hcl

provider "aws" {
  region = "us-west-2"
}

# 2. Criando uma Policy

hcl

resource "aws_iam_policy" "s3_read_only_policy" {
  name        = "S3ReadOnlyPolicy"
  description = "A policy to allow read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::my-example-bucket",
          "arn:aws:s3:::my-example-bucket/*"
        ]
      }
    ]
  })
}

# 3. Criando uma Role

hcl

resource "aws_iam_role" "example_role" {
  name = "ExampleRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# 4. Anexando a Policy à Role

hcl

resource "aws_iam_role_policy_attachment" "example_policy_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
}

# 5. Criando uma Instância EC2 que Usa a Role

hcl

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.example_profile.name

  tags = {
    Name = "ExampleInstance"
  }
}

# 6. Criando um Instance Profile para Associar a Role à Instância

hcl

resource "aws_iam_instance_profile" "example_profile" {
  name = "example_profile"
  role = aws_iam_role.example_role.name
}

# Arquivo Completo

Aqui está o arquivo completo combinando todos os recursos acima:

hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_policy" "s3_read_only_policy" {
  name        = "S3ReadOnlyPolicy"
  description = "A policy to allow read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::my-example-bucket",
          "arn:aws:s3:::my-example-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "example_role" {
  name = "ExampleRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example_policy_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
}

resource "aws_iam_instance_profile" "example_profile" {
  name = "example_profile"
  role = aws_iam_role.example_role.name
}

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.example_profile.name

  tags = {
    Name = "ExampleInstance"
  }
}

# Explicação

1. **Provider**: Define a região da AWS onde os recursos serão criados.
2. **Policy**: Cria uma policy IAM que permite acesso de leitura a um bucket S3 específico.
3. **Role**: Cria uma role IAM que pode ser assumida por serviços EC2.
4. **Policy Attachment**: Anexa a policy criada à role.
5. **Instance Profile**: Cria um instance profile que associa a role à instância EC2.
6. **Instance**: Cria uma instância EC2 que usa o instance profile, permitindo que a instância tenha as permissões definidas na policy IAM.

Este exemplo ilustra como gerenciar permissões e roles no AWS utilizando o Terraform de forma clara e modular.

# Outros

# Definindo o Provider

hcl

provider "aws" {
  region = "us-west-2"
}

# Criando uma Policy para Acesso ao PostgreSQL RDS

hcl

resource "aws_iam_policy" "postgres_rds_policy" {
  name        = "PostgresRDSAccessPolicy"
  description = "A policy to allow access to PostgreSQL RDS instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Criando uma Policy para Acesso ao Oracle RDS

hcl

resource "aws_iam_policy" "oracle_rds_policy" {
  name        = "OracleRDSAccessPolicy"
  description = "A policy to allow access to Oracle RDS instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Criando uma Policy para Acesso ao SQS

hcl

resource "aws_iam_policy" "sqs_access_policy" {
  name        = "SQSAccessPolicy"
  description = "A policy to allow access to SQS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sqs:us-west-2:123456789012:MyQueue"
      }
    ]
  })
}

Aqui está um exemplo de criação de roles e policies no AWS com Terraform para conceder acesso ao PostgreSQL, Oracle RDS e SQS:
Definindo o Provider

hcl

provider "aws" {
  region = "us-west-2"
}

Criando uma Policy para Acesso ao PostgreSQL RDS

hcl

resource "aws_iam_policy" "postgres_rds_policy" {
  name        = "PostgresRDSAccessPolicy"
  description = "A policy to allow access to PostgreSQL RDS instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

Criando uma Policy para Acesso ao Oracle RDS

hcl

resource "aws_iam_policy" "oracle_rds_policy" {
  name        = "OracleRDSAccessPolicy"
  description = "A policy to allow access to Oracle RDS instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

Criando uma Policy para Acesso ao SQS

hcl

resource "aws_iam_policy" "sqs_access_policy" {
  name        = "SQSAccessPolicy"
  description = "A policy to allow access to SQS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sqs:us-west-2:123456789012:MyQueue"
      }
    ]
  })
}

# Criando uma Role

hcl

resource "aws_iam_role" "database_access_role" {
  name = "DatabaseAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Anexando as Policies à Role

hcl

resource "aws_iam_role_policy_attachment" "postgres_rds_policy_attachment" {
  role       = aws_iam_role.database_access_role.name
  policy_arn = aws_iam_policy.postgres_rds_policy.arn
}

resource "aws_iam_role_policy_attachment" "oracle_rds_policy_attachment" {
  role       = aws_iam_role.database_access_role.name
  policy_arn = aws_iam_policy.oracle_rds_policy.arn
}

resource "aws_iam_role_policy_attachment" "sqs_policy_attachment" {
  role       = aws_iam_role.database_access_role.name
  policy_arn = aws_iam_policy.sqs_access_policy.arn
}

# Criando uma Instância EC2 que Usa a Role

hcl

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.example_profile.name

  tags = {
    Name = "ExampleInstance"
  }
}

# Criando um Instance Profile para Associar a Role à Instância

hcl

resource "aws_iam_instance_profile" "example_profile" {
  name = "example_profile"
  role = aws_iam_role.database_access_role.name
}

# Arquivo Completo

Aqui está o arquivo completo combinando todos os recursos acima:

hcl

provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_policy" "postgres_rds_policy" {
  name        = "PostgresRDSAccessPolicy"
  description = "A policy to allow access to PostgreSQL RDS instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "oracle_rds_policy" {
  name        = "OracleRDSAccessPolicy"
  description = "A policy to allow access to Oracle RDS instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "sqs_access_policy" {
  name        = "SQSAccessPolicy"
  description = "A policy to allow access to SQS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sqs:us-west-2:123456789012:MyQueue"
      }
    ]
  })
}

resource "aws_iam_role" "database_access_role" {
  name = "DatabaseAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "postgres_rds_policy_attachment" {
  role       = aws_iam_role.database_access_role.name
  policy_arn = aws_iam_policy.postgres_rds_policy.arn
}

resource "aws_iam_role_policy_attachment" "oracle_rds_policy_attachment" {
  role       = aws_iam_role.database_access_role.name
  policy_arn = aws_iam_policy.oracle_rds_policy.arn
}

resource "aws_iam_role_policy_attachment" "sqs_policy_attachment" {
  role       = aws_iam_role.database_access_role.name
  policy_arn = aws_iam_policy.sqs_access_policy.arn
}

resource "aws_iam_instance_profile" "example_profile" {
  name = "example_profile"
  role = aws_iam_role.database_access_role.name
}

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.example_profile.name

  tags = {
    Name = "ExampleInstance"
  }
}

# Explicação

1. **Provider**: Define a região da AWS onde os recursos serão criados.
2. **Policies**: Cria policies IAM separadas para acesso ao PostgreSQL RDS, Oracle RDS e SQS.
3. **Role**: Cria uma role IAM que pode ser assumida por serviços EC2.
4. **Policy Attachments**: Anexa as policies criadas à role.
5. **Instance Profile**: Cria um instance profile que associa a role à instância EC2.
6. **Instance**: Cria uma instância EC2 que usa o instance profile, permitindo que a instância tenha as permissões definidas nas policies IAM.

Este exemplo cobre a criação de roles e policies para diferentes serviços da AWS e mostra como associar essas policies a uma instância EC2.
