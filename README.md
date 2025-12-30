# Terraform/OpenTofu

Provides configuration for homelab infrastructure as code.

## Requirements

- OpenTofu
- A 1Password account
- 1Password CLI
- Running Proxmox VE instance

## Running

`op run --env-file=".env" -- sh plan.sh`

If this results in generated resources and you want to plan again, make sure to delete the `generated-resources.tf` file created by the plan script.

If everything looks good, wait a few seconds to let the TOTP in 1Password refresh, and run:
`op run --env-file=".env" -- sh apply.sh`

## Troubleshooting

### Error: AuthTicket must include a valid username

```
Planning failed. OpenTofu encountered an error while generating this plan.

╷
│ Error: Unable to create Proxmox VE API client
│
│   with provider["registry.opentofu.org/bpg/proxmox"],
│   on main.tf line 12, in provider "proxmox":
│   12: provider "proxmox" {
│
│ failed to create API client: AuthTicket must include a valid username
```

> ### Solution
>
> Wait a minute and run it again, the TOTP code hasn't regenerated, so you're getting an auth error that results in no returned username from the original auth call.

## NB

Right now we can't use GitLab CI/CD as a backend for terraform, because GitLab has its own wrapper around OpenTofu that runs init/plan. The Proxmox Provider for OpenTofu requires a separate script to do Auth Ticket authentication, and we need Auth Ticket authentication to do actions as `root` (including managing ACME plugins and the OpenTofu user itself), so until we can run `plan.sh` and `apply.sh` with a `.env` file that can access 1Password TOTP, we're stuck with storing the backend locally only.
