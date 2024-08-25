# 2. Foundry ve Hardhat Kurulumu
echo "Foundry'yi yüklüyoruz..."
curl -L https://foundry.paradigm.xyz | bash

# PATH ayarlarını güncelle
source ~/.bashrc

echo "Foundry güncellendi ve PATH'e eklendi."

echo "Hardhat'i yükliyoruz..."
npm install --save-dev hardhat

# 3. Bağımlılıkları Yükle
echo "Gerekli bağımlılıkları yüklüyoruz..."
yarn install

echo "Foundry paketlerini yüklüyoruz..."
forge install

# 4. Çevresel Değişkenleri Ayarla
# STORY_TESTNET_URL'i otomatik olarak ayarla
echo "STORY_TESTNET_URL=https://rpc.partner.testnet.storyprotocol.net/" > .env

echo "Lütfen STORY_PRIVATEKEY'i girin:"
read -s PRIVATEKEY

# .env dosyasını oluştur veya güncelle
echo "STORY_PRIVATEKEY=$PRIVATEKEY" >> .env

# 5. Sözleşmeleri Derle
echo "Sözleşmeleri derliyoruz..."
if command -v forge &> /dev/null
then
    forge build
else
    echo "forge komutu bulunamadı. Foundry kurulumu veya PATH ayarlarını kontrol edin."
    exit 1
fi

# 6. Deploy Scriptini Çalıştır
echo "Deploy işlemini başlatıyoruz..."
if command -v forge &> /dev/null
then
    forge script script/deploy.s.sol:DeployScript --rpc-url $STORY_TESTNET_URL --private-key $PRIVATEKEY --broadcast
else
    echo "forge komutu bulunamadı. Foundry kurulumu veya PATH ayarlarını kontrol edin."
    exit 1
fi

echo "Deploy işlemi tamamlandı. Kontrol edebilirsiniz."

# 7. Ekstra Bilgi
echo "Deployment sonucu kontrol edin ve sözleşme adresini blockchain explorer üzerinden doğrulayın."
