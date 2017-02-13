//
//  ViewController.swift
//  WebView
//
//  Created by Shuvayan Saha on 27/01/17.
//  Copyright © 2017 MagicMind Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var userWebView: UIWebView!
    @IBOutlet weak var userToolbar: UIToolbar!
    var lastOffsetY :CGFloat = 0
    var HTMLtitle = String()

    var loadUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userWebView.loadRequest(URLRequest(url: URL(string: url_address)!))
        userToolbar.isHidden = true
        
        userWebView.scrollView.delegate = self

    }


    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        // Disable double click on link
        userWebView.stringByEvaluatingJavaScript(from: "document.body.style.webkitTouchCallout='none'; document.body.style.KhtmlUserSelect='none'")
        
        // Get meta data
        let html = userWebView.stringByEvaluatingJavaScript(from: "document.title")

        if let page = html {
            //print("HTML ** \(page)")
            HTMLtitle = page
        }
        
        //
        if let currentURL = userWebView.request?.url?.absoluteString {
            
            //print(currentURL)
            loadUrl = currentURL
            
            if loadUrl == url_address {
                
                userToolbar.isHidden = true
            }

            
        }

    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("URL ** \(loadUrl)")
        
        if loadUrl == url_address {
            
            userToolbar.isHidden = true
            
        } else {
            
            userToolbar.isHidden = false
        }
        
        
        
        if scrollView.contentOffset.y  == lastOffsetY {
            
            userToolbar.isHidden = true

        }





    
    
    
    }
    
    
    
    
    

    // function of Tabbar button
    
    @IBAction func stop(_ sender: UIBarButtonItem) {
        
        let message = HTMLtitle
        // Set the link to share.
        let link = loadUrl
        
            let objectsToShare = [message,link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        
        userWebView.reload()
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
        userWebView.goBack()
    }
    
    @IBAction func go(_ sender: UIBarButtonItem) {
        
        userWebView.goForward()
    }
  
  
    
    



}
