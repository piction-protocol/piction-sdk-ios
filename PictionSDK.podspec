Pod::Spec.new do |s|
  s.name         = "PictionSDK"
  s.version      = "0.0.1"
  s.summary      = "PictionSDK for iOS."
  s.homepage     = "https://piction.network"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Junghoon Seo" => "jh.seo@battleent.com" }
  s.platform     = :ios, "8.1"
  s.source       = { :git => 'https://github.com/piction-protocol/picion-sdk-ios.git', :tag => "#{s.version}" }
  s.source_files = "Sources/**/*.swift"
  s.dependency "Moya-ModelMapper", "~> 8.0.0"
  s.dependency "KeychainAccess", "~> 3.1.0"
  s.swift_version = "4.2"
end
