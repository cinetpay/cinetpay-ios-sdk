Pod::Spec.new do |spec|

  spec.name         = "SDKCinetPay"
  spec.version      = "1.0.0"
  spec.summary      = "SDK iOS pour CinetPay."
  spec.description  = "Le SDK CinetPay pour iOS vous permet d'intégrer les moyens de paiement offerts par CinetPay dans votre application iOS."
  spec.homepage     = "https://github.com/cinetpay/cinetpay-ios-sdk"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Ismael Toé" => "ismael.toe@cinetpay.com" }
  spec.platform     = :ios
  spec.source       = { :git => "https://github.com/cinetpay/cinetpay-ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files  = "SDKCinetPay"

end
