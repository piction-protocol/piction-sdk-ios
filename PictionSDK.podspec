Pod::Spec.new do |s|
  s.name         = "PictionSDK"
  s.version      = "1.0.0"
  s.summary      = "PictionSDK for iOS."
  s.homepage     = "https://piction.network"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Piction Network" => "jh.seo@battleent.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/piction-protocol/piction-sdk-ios.git', :tag => "#{s.version}" }
  s.swift_version = "5.0"

  s.subspec "Core" do |ss|
    ss.source_files = "Sources/PictionSDK/**/*.swift"
    ss.dependency "Moya-ModelMapper", "~> 9.0.0"
    ss.dependency "KeychainAccess", "~> 3.2.0"
    ss.framework = "Foundation"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Sources/RxPictionSDK/**/*.swift"
    ss.dependency "Moya-ModelMapper/RxSwift", "~> 9.0.0"
    ss.dependency "PictionSDK/Core"
    ss.dependency "RxSwift"
  end

end
