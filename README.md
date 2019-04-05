# SDK CinetPay pour iOS

## Installation

L'installation se fait via CocoaPods. Ajoutez cette ligne dans le fichier `Podfile` de votre projet:

```ruby
pod 'SDKCinetPay', :git => 'https://github.com/cinetpay/cinetpay-ios-sdk.git', :tag => '1.0.11'
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
        
controller.amount = "100"
controller.apiKey = "VOTRE_CLE_API"
controller.siteId = 709652
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

## Définition des méthodes du protocole `CinetPayDelegate` à implémenter

Grâce à ces méthodes, vous pouvez définir les actions à effectuer à la suite de différents événements: l'échec d'un paiement, la réussite d'un paiement, etc.

```swift
func onPaymentCompleted(payment_info: String)
```

Cette méthode s'exécute lorsque le paiement est terminé. Elle prend en paramètre une chaîne de caractères au format JSON qui contient toutes les informations concernant le paiement effectué.

La structure de la chaîne se présente ainsi:

```json
{
	"cpm_site_id": "",
	"signature": "", 
	"cpm_amount": "", 
	"cpm_trans_date": "", 
	"cpm_trans_id": "", 
	"cpm_custom": "", 
	"cpm_currency": "", 
	"cpm_payid": "", 
	"cpm_payment_date": "", 
	"cpm_payment_time": "", 
	"cpm_error_message": "", 
	"payment_method": "", 
	"cpm_phone_prefixe": "", 
	"cel_phone_num": "", 
	"cpm_ipn_ack": "", 
	"created_at": "", 
	"updated_at": "", 
	"cpm_result": "", 
	"cpm_trans_status": "", 
	"cpm_designation": "", 
	"buyer_name": ""
}
```

Pour plus d'informations sur la signification de chaque paramètre, consultez le document [Réussir l'intégration CinetPay](https://cinetpay.com/downloads/Reussir_l_integration_CinetPay_v1.6.0.pdf).

```swift
func onError(code: Int, message: String)
```

S'exécute lorsqu'une erreur survient. Elle prend en paramètres le code et le message de l’erreur.

```swift
func terminatePending(api_key: String, site_id: Int, trans_id: String)
```

S'exécute lorsque l'utilisateur appuie sur le bouton `Annuler` après avoir initié un paiement sans valider (la validation dont on parle ici est le fait de saisir son code secret sur ton téléphone lors de la dernière étape du paiement, dans le cas de MTN et Moov). Le bouton `Annuler` s'affiche lorsque l'utilisateur clique sur `Fermer` dans la fenêtre de paiement CinetPay. La méthode prend en paramètres: `api_key` (votre clé API), `site_id` (votre site ID), `trans_id` (l'ID de transaction que vous avez généré pour le paiement en question). Ces paramètres vous sont transmis pour vous permettre de vérifier le statut final du paiement car l'utilisateur peut confirmer le paiement après avoir quitté la fenêtre de paiement de CinetPay. Pour vérifier le statut final du paiement, vous devez envoyer par POST les paramètres suivants: `apikey`, `cpm_site_id` et `cpm_trans_id` à cette URL: `https://api.cinetpay.com/v1/?method=checkPayStatus`. Pour plus d'informations sur les éléments retournés, consultez le document [Réussir l'intégration CinetPay](https://cinetpay.com/downloads/Reussir_l_integration_CinetPay_v1.6.0.pdf).

```swift
func terminateSuccess(payment_info: String)
```

S'exécute lorsque l'utilisateur appuie sur le bouton `Terminer`. Le bouton `Terminer` s'affiche lorsque l'utilisateur clique sur `Fermer` dans la fenêtre de paiement CinetPay après avoir effectué son paiement. La méthode prend en paramètre une chaîne de caractères au format JSON qui contient toutes les informations concernant le paiement effectué, la même que celle dans `onPaymentCompleted`.

```swift
func terminateFailed(api_key: String, site_id: Int, trans_id: String)
```

S'exécute lorsque l'utilisateur appuie sur le bouton `Terminer` après une erreur survenue. Le bouton `Terminer` s'affiche lorsque l'utilisateur clique sur `Fermer` dans la fenêtre de paiement CinetPay. La méthode prend en paramètres: `api_key` (votre clé API), `site_id` (votre site ID), `trans_id` (l'ID de transaction que vous avez généré pour le paiement en question). Ces paramètres vous sont transmis pour vous permettre de vérifier le statut final du paiement. Pour vérifier le statut final du paiement, vous devez envoyer par POST les paramètres suivants: `apikey`, `cpm_site_id` et `cpm_trans_id` à cette URL: `https://api.cinetpay.com/v1/?method=checkPayStatus`. Pour plus d'informations sur les éléments retournés, consultez le document [Réussir l'intégration CinetPay](https://cinetpay.com/downloads/Reussir_l_integration_CinetPay_v1.6.0.pdf).

```swift
func checkPayment(api_key: String, site_id: Int, trans_id: String)
```

S'exécute lorsque l'utilisateur clique sur le bouton `Vérifier le paiement`. Le bouton `Vérifier le paiement` s'affiche (si vous avez mis le paramètre `should_check_payment` à `true` à l'instanciation de votre classe qui hérite de `CinetPayWebAppInterface`) lorsque l'utilisateur clique sur `Fermer` dans la fenêtre de paiement CinetPay après avoir initié un paiement sans valider (la validation dont on parle ici est le fait de saisir son code secret sur ton téléphone lors de la dernière étape du paiement, dans le cas de MTN et Moov). La méthode prend en paramètres: `api_key` (votre clé API), `site_id` (votre site ID), `trans_id` (l'ID de transaction que vous avez généré pour le paiement en question). Pour vérifier le statut final du paiement, vous devez envoyer par POST les paramètres suivants: `apikey`, `cpm_site_id` et `cpm_trans_id` à cette URL: `https://api.cinetpay.com/v1/?method=checkPayStatus`. Pour plus d'informations sur les éléments retournés, consultez le document [Réussir l'intégration CinetPay](https://cinetpay.com/downloads/Reussir_l_integration_CinetPay_v1.6.0.pdf).