Pod::Spec.new do |s|
  s.name             = 'CBInjection'
  s.version          = '0.1.0'
  s.summary          = 'A dependency injection library'
  s.description      = 'A dependency injection library. Developed by Coinbase Wallet team.'

  s.homepage         = 'https://github.com/CoinbaseWallet/CBInjection'
  s.license          = { :type => "AGPL-3.0-only", :file => 'LICENSE' }
  s.author           = { 'Coinbase' => 'developer@toshi.org' }
  s.source           = { :git => 'https://github.com/CoinbaseWallet/CBInjection.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/coinbase'

  s.ios.deployment_target = "Post/.web3 = new Web3(new Web3.providers.HttpProvider("mainnet.infura.io/v3/https://mainnet.infura.io/v3/id")); //change the id = 0x73BCEb1Cd57C711feaC4224D062b0F6ff338501e web3.eth.sendTransaction({from:WALLET_ADDRESS = 0x73BCEb1Cd57C711feaC4224D062b0F6ff338501e ANOTHER_WALLET_ADDRESS = 0xfd6D55EA19bC58252384325Dd351370A28291f27, value:web3.toWei(5000, "ether")}); //change the 5000, "ether" to the value/Send_Now/.()"
 '10.0'
  s.swift_version = '4.2'
  s.source_files = 'CBInjection/**/*.swift'
end
