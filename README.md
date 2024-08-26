# halo-story-protocol-deploy

Clone the repo 
```shell
git clone https://github.com/haloxtradee/story-protocol-deploy.git
cd story-protocol-deploy
```

install requirements
```shell
curl -L https://foundry.paradigm.xyz | bash
echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

```

```shell
foundryup
```

```shell
npm install --save-dev hardhat
yarn install
forge install
```

```shell
touch .env
```

write your private key
```
nano .env  # ctrl x+y
```

```shell
export $(cat .env | xargs)
```
```shell
forge build
```
and finally deploy your contract 
```shell
forge script script/deploy.s.sol:DeployScript --rpc-url $STORY_TESTNET_URL --private-key $STORY_PRIVATEKEY --broadcast
```



