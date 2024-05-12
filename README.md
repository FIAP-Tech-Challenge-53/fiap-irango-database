# Fiap iRango Database
![terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![aws](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![rds](https://img.shields.io/badge/Amazon_RDS-2d71b8?style=for-the-badge&logo=amazonrds&logoColor=white)
![mysql](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=FFF&style=flat-square)
![redis](https://img.shields.io/badge/Redis-DC382D?logo=Redis&logoColor=FFF&style=flat-square)

## Dependencies
- [Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)
- Make
  - [Windows](https://gnuwin32.sourceforge.net/packages/make.htm)
  - Linux:
  ```bash
  sudo apt update
  sudo apt install make
  ```

## Instructions to run
Before all, you need set AWS credentials and Database ENVs using:
```bash
export AWS_ACCESS_KEY_ID=xxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxx
export TF_VAR_DB_USERNAME=root
export TF_VAR_DB_PASSWORD=password
```
Or configure it in windows environments.

### Using make
```bash
# To init terraform
make init

# To run terraform plan
make plan

# To apply changes
make up
```

To destroy resources:
```bash
make down
```


### Without make
```bash
# To init terraform
terraform -chdir=terraform init

# To run terraform plan
terraform -chdir=terraform plan

# To apply changes
terraform -chdir=terraform apply -auto-approve
```

To destroy resources:
```bash
terraform -chdir=terraform destroy -auto-approve
```
