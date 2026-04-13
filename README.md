# terragrunt-aws-ec2

Infraestructura AWS EC2 con Terragrunt, preparada para dos entornos: **LocalStack** (desarrollo local) y **AWS Producción**.

## Estructura del proyecto

```
terragrunt-aws-ec2/
├── modules/                          # Módulos Terraform reutilizables
│   ├── network/                      # VPC, Subnet, IGW, Route Table
│   ├── security/                     # Security Group, Key Pair, SSH Key
│   └── linux/                        # EC2 Instance, EIP, AMI data source
├── environments/
│   ├── localstack/                   # Entorno LocalStack
│   │   ├── terragrunt.hcl            # Root config (provider LocalStack + backend)
│   │   ├── env.hcl                   # Variables de entorno (region, app_name, etc.)
│   │   ├── network/terragrunt.hcl
│   │   ├── security/terragrunt.hcl
│   │   └── linux/terragrunt.hcl
│   └── production/                   # Entorno AWS Producción
│       ├── terragrunt.hcl            # Root config (provider AWS + backend)
│       ├── env.hcl
│       ├── network/terragrunt.hcl
│       ├── security/terragrunt.hcl
│       └── linux/terragrunt.hcl
├── *.tf                              # Archivos Terraform originales (referencia)
└── aws-user-data.sh
```

## Dependencias entre módulos

```
network  ──►  security  ──►  linux
   │                           ▲
   └───────────────────────────┘
```

- **network**: VPC + Subnet (sin dependencias)
- **security**: Security Group + Key Pair (depende de `network.vpc_id`)
- **linux**: EC2 + EIP (depende de `network.subnet_id`, `security.security_group_id`, `security.key_name`)

Terragrunt resuelve automáticamente el orden de despliegue.

## Requisitos

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) >= 1.0
- Para LocalStack: [LocalStack](https://docs.localstack.cloud/getting-started/installation/) corriendo en `localhost:4566`
- Para Producción: Credenciales AWS configuradas (`~/.aws/credentials` o variables de entorno)

## Uso

### LocalStack (desarrollo local)

```bash
# 1. Iniciar LocalStack
localstack start -d

# 2. Desplegar toda la infraestructura
cd environments/localstack
terragrunt run --all init
terragrunt run --all apply

# 3. Destruir
terragrunt run --all destroy
```

### AWS Producción

```bash
# 1. Asegurarse de tener credenciales AWS configuradas
export AWS_PROFILE=production

# 2. Desplegar toda la infraestructura
cd environments/production
terragrunt run --all init
terragrunt run --all apply

# 3. Destruir
terragrunt run --all destroy
```

### Desplegar un módulo individual

```bash
cd environments/localstack/network
terragrunt init
terragrunt apply
```

### Ver el plan antes de aplicar

```bash
cd environments/production
terragrunt run --all plan
```

## Personalización

Edita los valores en cada `env.hcl` y en los `inputs` de cada módulo:

| Variable                 | LocalStack                         | Producción         |
| ------------------------ | ---------------------------------- | ------------------ |
| `app_environment`        | `local`                            | `prod`             |
| `linux_instance_type`    | `t2.micro`                         | `t2.small`         |
| `linux_root_volume_size` | 8 GB                               | 20 GB              |
| `linux_data_volume_size` | 8 GB                               | 10 GB              |
| `volume_type`            | `gp2`                              | `gp3`              |
| `ami_owners`             | `["136693071363", "000000000000"]` | `["136693071363"]` |
