Pod::Spec.new do |spec|

  spec.name         = "SDKCinetPay"
  spec.version      = "1.0.8"
  spec.summary      = "SDK iOS pour CinetPay."
  spec.description  = "Le SDK CinetPay pour iOS vous permet d'intégrer les moyens de paiement offerts par CinetPay dans votre application iOS."
  spec.homepage     = "https://github.com/cinetpay/cinetpay-ios-sdk"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Ismael Toé" => "ismael.toe@cinetpay.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/cinetpay/cinetpay-ios-sdk.git", :tag => "#{spec.version}" }
  spec.source_files  = "SDKCinetPay/**/*"
  spec.swift_version = "5.0"
  spec.resource_bundles = { "SDKCinetPay" => ["SDKCinetPay/cancel.svg", "SDKCinetPay/cinetpay.html", "SDKCinetPay/cinetpay.png", "SDKCinetPay/success.svg"] }
  spec.resources = "SDKCinetPay/**/*.{html,svg}"

end
