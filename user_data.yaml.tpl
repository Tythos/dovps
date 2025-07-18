#cloud-config
package_update: true
package_upgrade: true

packages:
  - screen
  - docker.io
  - curl
  - wget
  - gnupg
  - lsb-release

write_files:
  - path: /root/mount_persistent_volume.sh
    permissions: '0755'
    content: |
      #!/bin/bash
      mkdir -p /mnt/${PERSISTENT_VOLUME_NAME}
      mount /dev/disk/by-id/scsi-0DO_Volume_${PERSISTENT_VOLUME_NAME} /mnt/${PERSISTENT_VOLUME_NAME}
      echo "/dev/disk/by-id/scsi-0DO_Volume_${PERSISTENT_VOLUME_NAME} /mnt/${PERSISTENT_VOLUME_NAME} ext4 defaults,nofail 0 2" >> /etc/fstab

runcmd:
  # Install Terraform
  - wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
  - echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
  - apt-get update
  - apt-get install -y terraform
  # Enable and start Docker
  - systemctl enable docker
  - systemctl start docker
  # Mount PV
  - ls -ahl /root
  - /root/mount_persistent_volume.sh

final_message: "Server setup complete!"
