# Provision and Configure Linux machine
The infrastructure to be used for this exercise will be a virtual machine on AWS i.e EC2 of which will be provisioned using Terraform and Configured with Ansible.

## Infrastructure file structure
```
.
├── configure_infrastructure
│   ├── ansible.cfg
│   ├── appsilon-playbook.yaml
│   └── nice-script.sh
├── README.md
└── setup_infrastructure
    ├── backend-config
    │   ├── .terraform.lock.hcl
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── providers.tf
    └── remote-node
        ├── backend.hcl
        ├── main.tf
        ├── modules
        │   ├── subnet
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   └── variables.tf
        │   └── webserver
        │       ├── main.tf
        │       ├── outputs.tf
        │       └── variables.tf
        ├── providers.tf
        ├── terraform.tfvars
        └── variables.tf
```

## Prerequisites
- Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Install [Terraform](https://developer.hashicorp.com/terraform/downloads?ajs_aid=8edebcc0-620e-4d81-9f0e-029fa8433d7b&product_intent=terraform)
- Install [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Install [boto3](https://pypi.org/project/boto3/)
- Install [botocore](https://pypi.org/project/botocore/)

At time of this writing, the following versions were used:
- Ansible v2.10.8
- Terraform v1.4.4
- aws-cli v2.7.34
- boto3 v1.26.142
- botocore v1.29.142

The `configuration_management` directory contains all provisioning and configuration codes in the `setup_infrastructure` and `configure_infrastructure` directories respectively.

## Infrastructure as code (IaC) - Terraform
Root directory: `setup_infrastructure`

### Setup remote backend: 
The remote backend is used to store the state of terraformm infrastructure on a cloud provider. To setup the remote backend;
- Navigate to the `backend-config` directory
```
cd backend-config
```
- Download required terraform modules: `terraform init`
- Check for desired deployment: `terraform plan`
- Deploy remote backend resources: `terraform apply`
    - Confirm application with `yes`
- After successful deployment, return to the `setup_infrastructure` directory.

### Setup remote node
Details of Linux machine to be provisioned:
- Owner: `Canonical`
- Distribution: `Ubuntu 20.04`
- AMI: `ami-0261755bbcb8c4a84`
- Region: `us-east-1`
- Default interpreter: python3

The remote instance IaC is found in the `remote-node` directory. The codes are used to provision a simple EC2 server with
- SSH inbound limited to a certain IP range (more like a jumphost within a network)
- key-pair imported from the public key within the control node.

To provision the remote-node;
- Navigate to `remote-node/`
```
cd remote-node
```

- Initialize the source code with with backend config
```
terraform init -backend-config=backend.hcl
```

- Create a `terraform.tfvars` file at the root module and populate its contents with the description from `variables.tf`


- Confirm configuration setup
```
terraform plan
```

To accommodate the customized Ansible playbook in the provisioning workflow of Terraform, `null_resources` was introduced. Hence, with the Configuration-as-Code scripted, run
```
terraform apply --auto-approve
```

## Configuration as code - Ansible
Root directory: `configure_infrastructure`
The workflow for the playbook involves using the public ip of the newly provisioned remote node as its inventiory for configuration. That is Ansible:
- Wait for SSH connection to open for public ip of remote mode
- Connect to the remote node newly created remote node ip, and,
- Configure using the tasks specification of the `appsilon-playbook.yaml`.