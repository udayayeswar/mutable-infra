dev:
		git pull
		rm -rf .terraform
		terraform init -backend-config=env-dev/backend.tfvars
		terraform apply -auto-approve -var-file=env-dev/main.tfvars

prod:

		  git pull
		  rm -rf .terraform
		  terraform init -backend-config=env-dev/backend.tfvars
		  terraform apply -auto-approve -var-file=env-dev/main.tfvars

dev-destroy:

		  git pull
		  rm -rf .terraform
		  terraform init -backend-config=env-dev/backend.tfvars
		  terraform apply -auto-approve -var-file=env-dev/main.tfvars

prod-destroy:

		  git pull
		  rm -rf .terraform
		  terraform init -backend-config=env-dev/backend.tfvars
		  terraform apply -auto-approve -var-file=env-dev/main.tfvars
