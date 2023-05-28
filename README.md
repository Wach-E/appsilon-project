
# Infrastructure challenge - Part 1
These exercises will allow us to assess your skills in working with developers (helping them with CI and Docker) as well as with operational tasks such as Linux administration and configuration management.

## Description of workdone (DoD)
This repository contains the codes to the solution of the [containers](https://github.com/Wach-E/appsilon-project/tree/main/containers) and [configuration_management](https://github.com/Wach-E/appsilon-project/tree/main/configuration_management) tasks. The detailed principle of operation of each task are contained in their respective README.md file(s).

### Project File Structure
```
.
├── configuration_management
│   ├── configure_infrastructure
│   │   ├── ansible.cfg
│   │   ├── appsilon-playbook.yaml
│   │   └── nice-script.sh
│   ├── README.md
│   └── setup_infrastructure
│       ├── backend-config
│       │   ├── .terraform.lock.hcl
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── providers.tf
│       └── remote-node
│           ├── backend.hcl
│           ├── main.tf
│           ├── modules
│           │   ├── subnet
│           │   │   ├── main.tf
│           │   │   ├── outputs.tf
│           │   │   └── variables.tf
│           │   └── webserver
│           │       ├── main.tf
│           │       ├── outputs.tf
│           │       └── variables.tf
│           ├── providers.tf
│           ├── terraform.tfvars
│           └── variables.tf
├── containers
│   ├── app
│   │   ├── app.py
│   │   ├── Dockerfile
│   │   ├── init_db.py
│   │   ├── __init__.py
│   │   ├── requirements.txt
│   │   ├── schema.sql
│   │   ├── static
│   │   │   └── css
│   │   │       └── main.css
│   │   └── templates
│   │       ├── 404.html
│   │       ├── about.html
│   │       ├── base.html
│   │       ├── create.html
│   │       ├── index.html
│   │       └── post.html
│   ├── images
│   │   ├── actions_workflow.png
│   │   ├── container_running_locally.png
│   │   └── dockerhub_secrets.png
│   └── README.md
├── .gitignore
└── README.md
```

### Containers
Application (Language/Framework): **TechTrend (Python/Flask)**
Container Technology: **Docker**
CI/CD: **GitHub Actions**
Highlevel takeaways:
- Crossplatform image build with buildx
- Docker image tag follows semantic versioning [SemVer Runner](https://github.com/marketplace/actions/git-semantic-version)
- Build trigger on push (to main) and schedule (Saturday, 7pm UTC)

### Configuration Management
Infrastructure-as-Code: **Terraform**
Configuration Management: **Ansible**
Cloud: **AWS**
Control Node: **Ubuntu 22.04**
Highlevel takeaways:
- Remote Backend Config
- Remote node created with local keypair using terraform
- Remote node SSH inbound restricted to network of control node only.


