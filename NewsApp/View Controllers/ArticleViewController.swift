//
//  ArticleViewController.swift
//  NewsApp
//
//  Created by Gontse Ranoto on 2019/08/06.
//  Copyright © 2019 Gontse Ranoto. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    
    @IBOutlet weak var healLinesLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var bodyTextView: UITextView! {
        didSet{
            bodyTextView.allowsEditingTextAttributes = false
            bodyTextView.isEditable = false
        }
    }
    
    
    //Local var
    var SiteName = ""
    var UrlName = ""
    var UrlFriendlyDate = ""
    var UrlFriendlyHeadline = ""
    var headline = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationController?.navigationBar.tintColor = .white
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        healLinesLabel.text = headline
        getArticle()
      
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func getArticle(){
    
        
     let urlString = "http://ipadfeed.supersport.com/\(SiteName)/\(UrlName)/news/\(UrlFriendlyDate)/\(UrlFriendlyHeadline)?format=json"
    let  imageStringUrl = "http://images.supersport.com/"
        guard let articleUrl = URL(string:urlString) else{
            fatalError("incorrect URL")
        }
        
        let resource = Resource<Article>(url: articleUrl)
        WebService().load(resource: resource) { result in
            switch result {
            case .success(let article):
                print(article)
                
                let htmlData = NSString(string: article.Body).data(using: String.Encoding.unicode.rawValue)
                let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                    NSAttributedString.DocumentType.html]
                let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                                      options: options,
                                                                      documentAttributes: nil)
                self.bodyTextView.attributedText = attributedString
        
                self.articleImageView.downloaded(from: imageStringUrl+article.LargeImageName)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
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
