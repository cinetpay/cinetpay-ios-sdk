# SDK CinetPay pour iOS

## Installation

L'installation se fait via CocoaPods. Ajoutez cette ligne dans le fichier `Podfile` de votre projet:

```ruby
pod 'SDKCinetPay', :git => 'https://github.com/cinetpay/cinetpay-ios-sdk.git', :tag => '1.0.9'
```

## Utilisation

Ajoutez cette ligne dans la classe qui doit afficher la page de paiement CinetPay:

```swift
import SDKCinetPay
```

Ensuite, votre classe doit implémenter le protocole `CinetPayDelegate`:

```swift
class ViewController: UIViewController, CinetPayDelegate
```

Pour afficher la page de paiement CinetPay, vous devez appeler `CinetPayViewController` en envoyant des paramètres qui contiennent les informations du paiement à effectuer. Un exemple ci-dessous.

```ruby
let controller = CinetPayViewController()
        
controller.amount = amountView.text
controller.apiKey = "39955468c7a8c0cef1.68322505"
controller.siteId = 709651
controller.notifyURL = ""
controller.shouldCheckPayment = false
let uuid = UUID().uuidString
controller.transId = uuid
controller.currency = "CFA"
controller.designation = "Test de paiement"
controller.custom = ""

controller.cinetPayDelegate = self

present(controller, animated: true, completion: nil)
```