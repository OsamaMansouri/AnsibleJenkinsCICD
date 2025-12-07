# 🔧 Ansible Guide

Guide to using Ansible in this project.

## Overview

Ansible is used for:

- **Configuration Management** - Setting up servers
- **Deployment** - Deploying applications
- **Orchestration** - Coordinating multi-server tasks

## Directory Structure

```
ansible/
├── ansible.cfg          # Ansible configuration
├── inventory/           # Server inventories
│   └── hosts.ini       # Current inventory
├── playbooks/          # Deployment playbooks
│   ├── deploy.yml      # Main deployment
│   ├── ping.yml        # Test connectivity
│   └── test-connection.yml
├── group_vars/         # Variables per group
│   ├── all.yml         # Global variables
│   ├── dev.yml         # Dev environment
│   ├── staging.yml     # Staging environment
│   └── prod.yml        # Production environment
├── templates/          # Jinja2 templates
│   ├── python-app.service.j2
│   ├── java-app.service.j2
│   └── nginx-proxy.conf.j2
└── roles/              # Reusable roles
    ├── common/         # Common tasks
    ├── python-app/     # Python deployment
    └── java-app/       # Java deployment
```

## Common Commands

### Test Connection

```bash
ansible -i inventory/hosts.ini all -m ping
```

### Run Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml
```

### Dry Run (Check Mode)

```bash
ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml --check
```

### Verbose Output

```bash
ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml -vvv
```

### Target Specific Group

```bash
# Only dev servers
ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml --limit dev

# Only production
ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml --limit prod
```

## Running with Docker

Since Ansible runs in Docker, use this pattern:

```bash
docker run --rm \
  --network test-server_ansible-network \
  -v ${PWD}/ansible:/ansible \
  -w /ansible \
  willhallonline/ansible:latest \
  ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml
```

## Inventory Files

### Current Inventory (hosts.ini)

```ini
[dev]
dev-server ansible_host=ansible-dev-server ansible_port=22

[staging]
staging-server ansible_host=ansible-staging-server ansible_port=22

[prod]
prod-server ansible_host=ansible-prod-server ansible_port=22
```

### Adding Real Servers

```ini
[prod]
prod-server ansible_host=54.123.45.67 ansible_port=22
```

## Variables

Variables are loaded in this order (later overrides earlier):

1. `group_vars/all.yml` - All hosts
2. `group_vars/{group}.yml` - Specific group
3. Playbook vars
4. Command line `--extra-vars`

## Roles

Roles are reusable components. To use them in a playbook:

```yaml
- hosts: all
  roles:
    - common
    - python-app
    - java-app
```

## Best Practices

1. **Use variables** - Don't hardcode values
2. **Use roles** - For reusable tasks
3. **Use tags** - To run specific tasks
4. **Test first** - Use `--check` mode
5. **Keep secrets safe** - Use Ansible Vault for passwords
