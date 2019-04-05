//
//  CinetPayViewController.swift
//  SDKCinetPay
//
//  Created by Ismael Toé on 03/04/2019.
//  Copyright © 2019 CinetPay. All rights reserved.
//

import UIKit
import WebKit

public protocol CinetPayDelegate {
    func onError(code: Int, message: String)
    func onPaymentCompleted(payment_info: String)
    func terminatePending(api_key: String, site_id: Int, trans_id: String)
    func terminateSuccess(payment_info: String)
    func terminateFailed(api_key: String, site_id: Int, trans_id: String)
    func checkPayment(api_key: String, site_id: Int, trans_id: String)
}

public class CinetPayViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    public var amount: String?
    public var apiKey: String?
    public var siteId: Int?
    public var notifyURL: String?
    public var shouldCheckPayment: Bool?
    public var transId: String?
    public var currency: String?
    public var designation: String?
    public var custom: String?
    
    public var cinetPayDelegate: CinetPayDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        config.userContentController = userContentController
        
        userContentController.add(self, name: "onError")
        userContentController.add(self, name: "onPaymentCompleted")
        userContentController.add(self, name: "terminatePending")
        userContentController.add(self, name: "terminateSuccess")
        userContentController.add(self, name: "terminateFailed")
        userContentController.add(self, name: "checkPayment")
        userContentController.add(self, name: "dismiss")
        
        webView = WKWebView(frame: view.bounds, configuration: config)
        
        view.addSubview(webView)
        
        webView.navigationDelegate = self
        
        let url = Bundle(for: type(of: self)).url(forResource: "cinetpay", withExtension: "html", subdirectory: nil)!
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "onError" {
            if let messageBody = message.body as? [String: Any], let code = messageBody["code"] as? Int, let message = messageBody["message"] as? String {
                if cinetPayDelegate != nil {
                    cinetPayDelegate?.onError(code: code, message: message)
                }
            }
        } else if message.name == "onPaymentCompleted" {
            if let messageBody = message.body as? String {
                if cinetPayDelegate != nil {
                    cinetPayDelegate?.onPaymentCompleted(payment_info: messageBody)
                }
            }
        } else if message.name == "terminatePending" {
            if let messageBody = message.body as? [String: Any], let api_key = messageBody["api_key"] as? String, let site_id = messageBody["site_id"] as? Int, let trans_id = messageBody["trans_id"] as? String
            {
                if cinetPayDelegate != nil {
                    cinetPayDelegate?.terminatePending(api_key: api_key, site_id: site_id, trans_id: trans_id)
                    dismiss(animated: true, completion: nil)
                }
            }
        } else if message.name == "terminateSuccess" {
            if let messageBody = message.body as? String {
                if cinetPayDelegate != nil {
                    cinetPayDelegate?.terminateSuccess(payment_info: messageBody)
                    dismiss(animated: true, completion: nil)
                }
            }
        } else if message.name == "terminateFailed" {
            if let messageBody = message.body as? [String: Any], let api_key = messageBody["api_key"] as? String, let site_id = messageBody["site_id"] as? Int, let trans_id = messageBody["trans_id"] as? String
            {
                if cinetPayDelegate != nil {
                    cinetPayDelegate?.terminateFailed(api_key: api_key, site_id: site_id, trans_id: trans_id)
                    dismiss(animated: true, completion: nil)
                }
            }
        } else if message.name == "checkPayment" {
            if let messageBody = message.body as? [String: Any], let api_key = messageBody["api_key"] as? String, let site_id = messageBody["site_id"] as? Int, let trans_id = messageBody["trans_id"] as? String
            {
                if cinetPayDelegate != nil {
                    cinetPayDelegate?.checkPayment(api_key: api_key, site_id: site_id, trans_id: trans_id)
                    dismiss(animated: true, completion: nil)
                }
            }
        } else if message.name == "dismiss" {
            dismiss(animated: true, completion: nil)
        }
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        var amt = "100"
        var api_key = ""
        var site_id = 0
        var notify_url = ""
        var should_check_payment = false
        var trans_id = ""
        var cur = "CFA"
        var des = ""
        var cus = ""
        
        if let amount = self.amount {
            amt = amount
        }
        
        if let apiKey = self.apiKey {
            api_key = apiKey
        }
        
        if let siteId = self.siteId {
            site_id = siteId
        }
        
        if let notifyURL = self.notifyURL {
            notify_url = notifyURL
        }
        
        if let shouldChekPayment = self.shouldCheckPayment {
            should_check_payment = shouldChekPayment
        }
        
        if let transId = self.transId {
            trans_id = transId
        }
        
        if let currency = self.currency {
            cur = currency
        }
        
        if let designation = self.designation {
            des = designation
        }
        
        if let custom = self.custom {
            cus = custom
        }
        
        webView.evaluateJavaScript("init('\(amt)', '\(api_key)', \(site_id), '\(notify_url)', \(should_check_payment), '\(trans_id)', '\(cur)', '\(des)', '\(cus)')", completionHandler: nil)
    }
    
}
