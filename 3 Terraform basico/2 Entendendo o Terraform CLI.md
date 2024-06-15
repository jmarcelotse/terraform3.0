# terraform -h

O comando **terraform -h** é usado para exibir a ajuda do Terraform. Ele fornece informações sobre os comandos disponíveis no Terraform e uma breve descrição de cada um. É útil para obter uma visão geral das capacidades do Terraform e para lembrar a sintaxe e as opções dos comandos específicos. Aqui está uma explicação detalhada do que o comando **terraform -h** oferece:

# Visão Geral do Comando terraform -h

Quando você executa **terraform -h** no terminal, você verá algo semelhante a isso:

plaintext
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by less common or more advanced commands.
If you're just getting started with Terraform, stick with the common commands. For the other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a new or existing Terraform configuration
    output             Read an output from a state file
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    state              Advanced state management
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Check whether the configuration is valid
    version            Prints the Terraform version
    workspace          Workspace management

All other commands:
    0.11upgrade        Rewrites pre-0.12 module source code for v0.12
    debug              Debug mode
    force-unlock       Manually unlock the state for the defined configuration
    push               Upload this Terraform module to Terraform Enterprise to run
    test               Experimental support for testing Terraform configurations

Global options (use these before the subcommand, if any):
    -chdir=DIR    Switch to a different working directory before executing the given subcommand.
    -help         Show this help output, or the help for a specified subcommand.
    -lock=false   Don't hold a state lock during the operation. Overrides the default behavior of holding a lock.
    -lock-timeout=DURATION   Override the time Terraform will wait to acquire a state lock. Default is 0s.
    -no-color     If specified, output won't contain any color.
    -version      An alias for the "version" subcommand.

O comando terraform -h é usado para exibir a ajuda do Terraform. Ele fornece informações sobre os comandos disponíveis no Terraform e uma breve descrição de cada um. É útil para obter uma visão geral das capacidades do Terraform e para lembrar a sintaxe e as opções dos comandos específicos. Aqui está uma explicação detalhada do que o comando terraform -h oferece:
Visão Geral do Comando terraform -h

Quando você executa terraform -h no terminal, você verá algo semelhante a isso:

plaintext

Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by less common or more advanced commands.
If you're just getting started with Terraform, stick with the common commands. For the other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a new or existing Terraform configuration
    output             Read an output from a state file
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    state              Advanced state management
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Check whether the configuration is valid
    version            Prints the Terraform version
    workspace          Workspace management

All other commands:
    0.11upgrade        Rewrites pre-0.12 module source code for v0.12
    debug              Debug mode
    force-unlock       Manually unlock the state for the defined configuration
    push               Upload this Terraform module to Terraform Enterprise to run
    test               Experimental support for testing Terraform configurations

Global options (use these before the subcommand, if any):
    -chdir=DIR    Switch to a different working directory before executing the given subcommand.
    -help         Show this help output, or the help for a specified subcommand.
    -lock=false   Don't hold a state lock during the operation. Overrides the default behavior of holding a lock.
    -lock-timeout=DURATION   Override the time Terraform will wait to acquire a state lock. Default is 0s.
    -no-color     If specified, output won't contain any color.
    -version      An alias for the "version" subcommand.

# Explicação dos Comandos Comuns

1. **apply**: Constrói ou altera a infraestrutura conforme definido nos arquivos de configuração.

    sh

    terraform apply

2. **console**: Abre um console interativo para testar expressões do Terraform.

    sh

    terraform console

3. **destroy**: Destrói a infraestrutura gerenciada pelo Terraform.

    sh

    terraform destroy

4. **fmt**: Reformata os arquivos de configuração para o formato canônico.

    sh

    terraform fmt

5. **get**: Baixa e instala módulos para a configuração.

    sh

    terraform get

6. **graph**: Cria um gráfico visual dos recursos do Terraform.

    sh

    terraform graph

7. **import**: Importa a infraestrutura existente para o Terraform.

    sh

    terraform import

8. **init**: Inicializa uma nova configuração do Terraform ou uma existente.

    sh

    terraform init

9. **output**: Lê uma saída de um arquivo de estado.

    sh

    terraform output

10. **plan**: Gera e mostra um plano de execução.

    sh

    terraform plan

11. **providers**: Imprime uma árvore dos provedores usados na configuração.

    sh

    terraform providers

12. **refresh**: Atualiza o arquivo de estado local contra os recursos reais.

    sh

    terraform refresh

13. **show**: Inspeciona o estado do Terraform ou o plano.

    sh

    terraform show

14. **state**: Gerenciamento avançado de estado.

    sh

    terraform state

15. **taint**: Marca manualmente um recurso para recriação.

    sh

    terraform taint

16. **untaint**: Desmarca manualmente um recurso como contaminado.

    sh

    terraform untaint

17. **validate**: Verifica se a configuração é válida.

    sh

    terraform validate

18. **version**: Imprime a versão do Terraform.

    sh

    terraform version

19. **workspace**: Gerenciamento de workspaces.

    sh

    terraform workspace

# Explicação das Opções Globais

1. **-chdir=DIR**: Muda para um diretório diferente antes de executar o subcomando dado.
2. **-help**: Mostra esta saída de ajuda ou a ajuda para um subcomando especificado.
3. **-lock=false**: Não segura um bloqueio de estado durante a operação. Sobrescreve o comportamento padrão de segurar um bloqueio.
4. **-lock-timeout=DURATION**: Sobrescreve o tempo que o Terraform esperará para adquirir um bloqueio de estado. O padrão é 0s.
5. **-no-color**: Se especificado, a saída não conterá nenhuma cor.
6. **-version**: Um alias para o subcomando "version".

Usar **terraform -h** é uma ótima maneira de se familiarizar rapidamente com os comandos e opções disponíveis no Terraform, especialmente quando você está começando ou precisa de um lembrete rápido.