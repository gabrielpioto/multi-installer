sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo \
  "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ \
  stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

curl -fsSLo vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'

sudo apt install -y --no-install-recommends \
  brave-browser \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin \
  git \
  ./vscode.deb

rm vscode.deb
