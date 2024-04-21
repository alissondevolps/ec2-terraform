## Criando EC2 com toda sua estrura VPC e deployando app

## Descrição
Nesse projeto existem arquivos da liguagem do terraform HCL (HashiCorp Configuration Language), que fará a criação de toda infraestrura para cria uma EC2 desde da VPC, Subnets, Internet gateways, Route tables, Security Group, Role IAM etc..

Após a criação de toda a infraestrutura, a EC2 já estára com o nginx e vários pacotes instalados.

Na raiz do projeto a pasta "app" será deployada na EC2.

## Linguagem, framework e/ou tecnologias usadas
- Cloud Provider AWS
- Git
- Terraform
- HTML
- CSS
- AWS/CLI
- Shell Script
- IDE VSCODE

## Como instalar e usar o projeto (instruções)

- Importante: Caso deseje executar todo esse projeto em sua máquina local sem alterar nada ao fazer o clone, será preciso criar um Backut S3 private manual na AWS com o nome "s3-terraform-xyz" para versionar o arquivo terraform.tfstate. Mas caso deseje manter o arquivo terraform.tfstate local é só comentar o bloco Backend localizado no arquivo providers.tf. Ok! belezinha? :;

- Vamos lá!!!

- 1º - Antes de tudo na AWS você precisa ter as credenciais de algum usuário e as devidas roles para que ele consiga criar serviços na AWS.

- 2º - Independente do SO que esteja usando terá que ter na máquina local o AWSCLI instalado.
Ao ter instalado é seguir esse passos digitando no seu prompt:

aws confirure
aws_access_key_id = seu_key_id
aws_secret_access_key = sua_secret_key
region = us-east-1 ou qualquer outra que deseje

3º - Na sua máquina também será necessário ter o Terraform instalado.

4º - Recomendo usar IDE para melhor visualização da identação dos códigos e ajsutes.

5º - Ufa! Pronto, após fazer o clone na sua máquina e deseje criar toda a infraestrutura usada no projeto é só fazer os seguinte comandos.

terraform init
terraform plan 
terraform apply --auto-approve

Tem alguns links nesse meu outro repositório https://github.com/alissondevolps/Comando-Terraform que dar algumas explicações e direciona para a documentação do terraform caso desejem visualizar.

6ª - Ao finalizar a criação da infra anote a saida do outputs do terminal.
- exemplo da saida:
Outputs:

id_da_instancia_ec2 = "i-0a0ddc085b5256418"
public_ip_address = "3.80.251.35"

7º - Após toda a infra criada é necessário apontar outro git remote para que quando for fazer um push seja feito o deploy em sua instancia EC2. Lembrando que deve ter todas as variáveis secretas usadas no pipeline configurada em seu repositório no Github ok? 

AWS_ACCESS_KEY_ID = seu_key_id
AWS_SECRET_ACCESS_KEY = sua_secret_key
INSTANCE_REGION_PROD = sua região na aws
INSTANCE_ID_PROD = id_da_instancia_ec2

8º - Para acessar a aplicação após o deploy finalizar é só acessar http://public_ip_address/app

OBSERVAÇÃO IMPORTANTE: Para destruir toda a infraestrutura criada é só dar o comando abaixo:
terraform destroy


## Fontes usadas

- Documentação da Amazon AWS
https://docs.aws.amazon.com/pt_br/

- Documentação Terraform
https://registry.terraform.io/providers/hashicorp/aws/latest/docs

- Codigo do app adiquirido em plaforma de sites free
https://www.free-css.com/free-css-templates/page296/spering



>  This is a challenge by [Coodesh](https://coodesh.com/)



