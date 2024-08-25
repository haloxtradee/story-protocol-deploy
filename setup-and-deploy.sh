#!/bin/bash

# Kullanıcıdan PRIVATEKEY'i al
echo "Lütfen STORY_PRIVATEKEY'i girin:"
read -s PRIVATEKEY

# .env dosyasını oluştur veya güncelle
echo "STORY_TESTNET_URL=https://testnet.example.com" > .env
echo "STORY_PRIVATEKEY=$PRIVATEKEY" >> .env

# Projeyi güncelle ve gerekli paketleri yükle
echo "Gerekli paketleri yüklüyoruz..."
yarn install

echo "Foundry paketlerini yüklüyoruz..."
forge install

# Sözleşmeleri derle
echo "Sözleşmeleri derliyoruz..."
forge build

# Deploy scriptini çalıştır
echo "Deploy işlemini başlatıyoruz..."
forge script script/deploy.s.sol:DeployScript --rpc-url $STORY_TESTNET_URL --private-key $STORY_PRIVATEKEY --broadcast

echo "Deploy işlemi tamamlandı. Kontrol edebilirsiniz."
