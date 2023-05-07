dev:
    git pull
    rm -rf .terraform
    terraform init
    terraform plan
    terraform apply

prod:

      git pull
      rm -rf .terraform
      terraform init
      terraform plan
      terraform apply

dev-destroy

      git pull
      rm -rf .terraform
      terraform init
      terraform plan
      terraform apply

prod-destroy

      git pull
      rm -rf .terraform
      terraform init
      terraform plan
      terraform apply
