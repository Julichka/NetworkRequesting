//
//  ViewController.swift
//  NetworkRequesting
//
//  Created by Yuliia Khrupina on 5/28/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
        
    let childView = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        getPosts()
    }
    
    func stopIndicator() {
        self.childView.willMove(toParent: nil)
        self.childView.view.removeFromSuperview()
        self.childView.removeFromParent()
    }
    
    func showIndicator() {
        addChild(childView)
        childView.view.frame = view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
      }
    
    func getPosts() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=1")
        
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data,
                      let dataString = String(data: data, encoding: .utf8),
                (response as? HTTPURLResponse)?.statusCode == 200,
                error == nil else { return }
     
            self.textView.text = dataString
            self.stopIndicator()
        }
        task.resume()
    }
}
