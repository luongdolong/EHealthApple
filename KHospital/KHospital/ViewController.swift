//
//  ViewController.swift
//  KHospital
//
//  Created by Luvina on 10/19/17.
//  Copyright © 2017 E-health. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    let mainURL = "http://dkonline.ehealth.gov.vn/mobile/"

    @IBOutlet weak var btnReload: UIButton?
    @IBOutlet weak var btnBack: UIBarButtonItem?
    @IBOutlet weak var btnRefresh: UIBarButtonItem?
    @IBOutlet weak var btnNext: UIBarButtonItem?
    @IBOutlet weak var viewBg: UIView?


    var webView : WKWebView!

    override func loadView() {
        super.loadView()
        //let webConfiguration = WKWebViewConfiguration()
        //webView = WKWebView(frame: .zero, configuration: webConfiguration)
        //webView.navigationDelegate = self
        //self.viewBg = webView
        //self.viewBg?.addSubview(webView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnReload?.isHidden = true
        viewBg?.isHidden = false
    
        // Create WKWebView in code, because IB cannot add a WKWebView directly
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        viewBg?.addSubview(webView)
        viewBg?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-[webView]-|",
                                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                                           metrics: nil,
                                                                           views: ["webView": webView]))
        viewBg?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[webView]-|",
                                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                                           metrics: nil,
                                                                           views: ["webView": webView]))
        
        
        let myURL = URL(string: mainURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reload(sender: UIButton) {
        btnReload?.isHidden = true
        viewBg?.isHidden = false
        webView.reload()
    }

    @IBAction func prev(sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @IBAction func refresh(sender: UIBarButtonItem) {
        btnReload?.isHidden = true
        viewBg?.isHidden = false
        webView.reload()
    }

    @IBAction func next(sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //showLoadingIndicator(false)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //showLoadingIndicator(true)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //showLoadingIndicator(false)
        btnReload?.isHidden = false
        viewBg?.isHidden = true
    }
}

