#!/bin/bash

# 1. Repo'yu Klonla
echo "Repo'yu klonluyoruz..."
git clone https://github.com/haloxtradee/story-protocol-deploy.git
cd story-protocol-deploy

# 2. Foundry ve Hardhat Kurulumu
echo "Foundry'yi yüklüyoruz..."
curl -L https://foundry.paradigm.xyz | bash
foundryup

echo "Hardhat'i yükliyoruz..."
npm install --save-dev hardhat

# 3. Bağımlılıkları Yükle
echo "Gerekli bağımlılıkları yüklüyoruz..."
yarn install

echo "Foundry paketlerini yüklüyoruz..."
forge install

# 4. Çevresel Değişkenleri Ayarla
echo "Lütfen STORY_TESTNET_URL'i girin:"
read -r TESTNET_URL

echo "Lütfen STORY_PRIVATEKEY'i girin:"
read -s PRIVATEKEY

# .env dosyasını oluştur veya güncelle
echo "STORY_TESTNET_URL=$TESTNET_URL" > .env
echo "STORY_PRIVATEKEY=$PRIVATEKEY" >> .env

# 5. Sözleşmeleri Derle
echo "Sözleşmeleri derliyoruz..."
forge build

# 6. Deploy Scriptini Çalıştır
echo "Deploy işlemini başlatıyoruz..."
forge script script/deploy.s.sol:DeployScript --rpc-url $TESTNET_URL --private-key $PRIVATEKEY --broadcast

echo "Deploy işlemi tamamlandı. Kontrol edebilirsiniz."

# 7. Ekstra Bilgi
echo "Deployment sonucu kontrol edin ve sözleşme adresini blockchain explorer üzerinden doğrulayın."
