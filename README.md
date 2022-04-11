# Public Cloud with Terraform

This repository is only here for terraform training to play with public cloud resources and does not represent a robust resource as it is used for lab purposes.

## Available stacks

- [Basic 2-tiers](palo-alto-demo-stack/) security stack to access to web resource.

## Stacks structure

Most of the stacks are based on the following structure:

Stack name --> Region --> Project

- Under stack name:
  - Generic logic under `main.tf`
  - Networking stack under `network.tf`
  - Network Interface under `net_interfaces.tf`
  - List of resources under `resources.tf`

- Under project:
  - Symllink to all tf files configured in stack
  - TF variables file.

```bash
palo-alto-demo-stack
├── main.tf
├── net_interfaces.tf
├── network.tf
├── output.tf
├── resources.tf
├── us-east-1
│   └── stack-01
│       ├── main.tf -> ../../main.tf
│       ├── net_interfaces.tf -> ../../net_interfaces.tf
│       ├── network.tf -> ../../network.tf
│       ├── output.tf -> ../../output.tf
│       ├── resources.tf -> ../../resources.tf
│       ├── vars.init.tf -> ../../vars.init.tf
│       └── vars.stack.tfvars
```

## Licence

This repository is based on Apache2 licence

