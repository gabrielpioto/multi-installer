# AUTOMOUNT EXTERNAL HDD
! grep -q /media /etc/fstab && \
  echo "PARTUUID=$(\
    sudo blkid | grep /dev/sda1 | sed -r 's/.*PARTUUID="(.*)"/\1/'\
  ) /media/HD-E1 ext4 defaults,auto,users,rw,nofail 0 0" | sudo tee -a /etc/fstab

# INSTALL DOCKER
# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt upgrade
sudo apt install -y --no-install-recommends docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

curl 'https://raw.githubusercontent.com/gabrielpioto/multi-installer/main/rpi/docker-compose.yml' | docker compose -f - up -d