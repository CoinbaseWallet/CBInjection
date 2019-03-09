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

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.0'
  s.source_files = 'CBInjection/**/*.swift'
end
