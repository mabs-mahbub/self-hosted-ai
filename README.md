# Self-Hosted AI Platform

This repository provides a self-hosted AI stack powered by Docker Compose, plus optional Terraform to provision an Azure VM to run it. The stack is designed to get you a local LLM chat UI with vector search, a reverse proxy, and optional monitoring.

## What's Included

- **Ollama** for local model serving.
- **Open WebUI** for chat and RAG workflows.
- **Qdrant** as the vector database.
- **Nginx Proxy Manager** for easy reverse-proxy configuration.
- **Grafana + Prometheus (optional)** for monitoring.

## Prerequisites

- Docker with the Compose plugin.
- (Optional) Terraform `>= 1.6.0` if you want to provision an Azure VM.

## Quick Start (Local)

1. Clone the repo.
2. Set a Grafana admin password (Compose reads environment variables from your shell or a local `.env` file):

   ```bash
   export GRAFANA_ADMIN_PASSWORD="change-me"
   ```

3. Start the core stack:

   ```bash
   cd compose
   docker compose up -d
   ```

4. Open WebUI is available at http://localhost:3000.

### Optional: Monitoring Stack

The monitoring stack runs Grafana and Prometheus.

```bash
cd compose/monitoring
export GRAFANA_ADMIN_PASSWORD="change-me"
docker compose up -d
```

Grafana is available at http://localhost:3001.

## Configuration Notes

- **Open WebUI** is configured to use Ollama and Qdrant out of the box. See `compose/docker-compose.yaml` for the full list of environment variables.
- **Grafana credentials**: user is `admin` and the password is set by `GRAFANA_ADMIN_PASSWORD`.
- **Ports**
  - Open WebUI: `3000`
  - Ollama: `11434`
  - Qdrant: `6333`
  - Nginx Proxy Manager: `80`, `81`, `443`
  - Grafana: `3001`

## Deployment Scripts (Optional)

The `scripts/` directory contains helper scripts intended for server deployments.

- `scripts/deploy.sh` clones the repo on a server and starts the Compose stack under `/opt/ai-platform`.

Update the placeholder GitHub repo URL inside the script before using it.

## Terraform (Azure VM)

The `terraform/` directory provisions an Azure VM and boots the stack via cloud-init.

1. Ensure you are authenticated to Azure.
2. Create a Terraform variables file (example):

   ```hcl
   rg_name           = "ai-platform"
   admin_ip_cidr     = "YOUR_IP/32"
   ssh_public_key_path = "~/.ssh/id_rsa.pub"
   repo_url          = "https://github.com/your-org/self-hosted-ai.git"
   ```

3. Apply the configuration:

   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

## Updating

Pull new images and restart the stack:

```bash
cd compose
docker compose pull
docker compose up -d
```

## Troubleshooting

- Check container logs: `docker compose logs -f <service>`
- Ensure your machine has sufficient RAM/CPU for the models you plan to run in Ollama.
