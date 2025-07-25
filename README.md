# DOVPS

Contains the means to spin up a VM appropriately configured to host the top-level service orchestration. This is done by a combination of DigitalOcean provider/API resources.

## Resources

The full list of required resources includes the following:

### Cloudflare

- [x] Domain records (A)

### DigitalOcean

- [x] VM ("Droplet")

- [x] A "Mount" (mapping volume to VM)

- [x] Project

- [x] SSH Key

- [x] Volume

### Other Files

* `tlskey.tf` uses a built-in Terraform resource to derive the SSH key for the VM

* `user_data.yml.tpl` defines the configuration applied to the VM upon instantiation via cloud-init

* `variables.tf` documents all relevant parameters; these can be passed via `terraform.tfvars` file contents (git-ignored) or via environmental variable by way of the `TF_VAR_` prefix.

## Deploying

We assume a domain has been registered with Cloudflare (API token and relevant Zone ID are required).

If all inputs have been defined, a simple two-step will instantiate the resources:

```sh
terraform init
terraform apply
```

After successful instantiation, you can write out the private key (git-ignored) and remote into the VM:

```sh
terraform output -raw PRIVATE_KEY > id_rsa
export DROPLET_IP=$(terraform output DROPLET_IP)
ssh -i id_rsa root@$DROPLET_IP
```

## Verifying

Cloud init can take a while to apply the appropriate configuration. Just because Terraform reports the VM has successfully spun up does *NOT* mean cloud-init has finished instantiating.

Earlier versions of the cloud-init configuration includes a basic NGINX-based webpage. This approach could be easily verified to be running by visiting the address of the VM in your browser.

We've since migrated to slightly more sophisticated multi-service/hosting orchestration that is instead driven by Traefik managing a variety of Docker containers. So, the cloud-init configuration focuses on installation of these tools instead, as well as mounting of the persistent volume. This can take a while so it's worth monitoring the cloud-init logs once you can connect to the VM:

```sh
tail -f /var/log/cloud-init-output.log
```
