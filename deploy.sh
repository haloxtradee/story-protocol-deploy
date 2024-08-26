#!/bin/bash

# 1. Repoyu Klonla
echo "Story Protocol deploy repoyu klonluyoruz..."
git clone https://github.com/haloxtradee/story-protocol-deploy.git
cd story-protocol-deploy

# 2. Foundry ve Hardhat Kurulumu
echo "Foundry'yi yüklüyoruz..."
curl -L https://foundry.paradigm.xyz | bash

# PATH ayarlarını güncelle
echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc

# .bashrc dosyasını yeniden yükle
source ~/.bashrc

# Foundry'yi güncelle
foundryup

# Foundry'nin kurulduğunu kontrol et
if ! command -v forge &> /dev/null
then
    echo "forge komutu bulunamadı. Lütfen Foundry'nin yüklenip yüklenmediğini kontrol edin."
    exit 1
fi

echo "Foundry güncellendi ve PATH'e eklendi."

echo "Hardhat'i yükliyoruz..."
npm install --save-dev hardhat

# 3. Gerekli Paketleri Yükle
echo "Gerekli bağımlılıkları yüklüyoruz..."
yarn install

echo "Foundry paketlerini yüklüyoruz..."
forge install

# jq'nin kurulu olup olmadığını kontrol et ve yükle
if ! command -v jq &> /dev/null
then
    echo "jq paketi yüklü değil. Yükleniyor..."
    sudo apt-get update && sudo apt-get install -y jq
else
    echo "jq zaten yüklü."
fi

# 4. Çevresel Değişkenleri Ayarla
echo "STORY_TESTNET_URL=https://rpc.partner.testnet.storyprotocol.net/" > .env

echo "Lütfen STORY_PRIVATEKEY'i girin:"
read -s PRIVATEKEY
echo "STORY_PRIVATEKEY=$PRIVATEKEY" >> .env

# .env dosyasını kaynak olarak dahil et
source .env

# 5. Sözleşmeleri Derle
echo "Sözleşmeleri derliyoruz..."
forge build

# 6. Deploy Scriptini Çalıştır
echo "Deploy işlemini başlatıyoruz..."
OUTPUT=$(forge script script/deploy.s.sol:DeployScript --rpc-url $STORY_TESTNET_URL --private-key $STORY_PRIVATEKEY --broadcast --json)

# Contract adresini al ve ekrana yazdır
CONTRACT_ADDRESS=$(echo $OUTPUT | jq -r '.transactions[0].contractAddress')

echo "Deploy işlemi tamamlandı. Sözleşme adresi: $CONTRACT_ADDRESS"
echo "Deployment sonucu kontrol edin ve sözleşme adresini blockchain explorer üzerinden doğrulayın."
