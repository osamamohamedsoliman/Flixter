//
//  TrailerViewController.swift
//  flixster
//
//  Created by Osama Soliman on 2/12/19.
//  Copyright © 2019 Osama Soliman. All rights reserved.
//

import UIKit
import WebKit
class TrailerViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var TrailerWebView: WKWebView!
    var movie : [String:Any]!

    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        TrailerWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        TrailerWebView.uiDelegate = self
        view = TrailerWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("hello")
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(String(describing: movie["id"]))/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let key = dataDictionary["key"] as! String
                let viewURL = URL(string:"https://www.youtube.com/watch?v=\(key)")
                let myRequest = URLRequest(url: viewURL!)
                self.TrailerWebView.load(myRequest)
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
