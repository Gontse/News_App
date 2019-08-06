//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Gontse Ranoto on 2019/08/05.
//  Copyright © 2019 Gontse Ranoto. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var newsListViewModel = NewsListViewModel()
    let  imageStringUrl = "http://images.supersport.com/"
    override func viewDidLoad() {
        super.viewDidLoad()

        //Start App
        populateNews()
    }
    
    private func  populateNews(){
        
        guard let newsUrl = URL(string: "http://ipadfeed.supersport.com/news?format=json") else{
            fatalError("incorrect URL")
        }
        
        let resource = Resource<[News]>(url: newsUrl)
      
        WebService().load(resource: resource) { [weak self] result in
            switch result {
            case .success(let news):
                 print(news)
                self?.newsListViewModel.newsListviewModel = news.map(NewsViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
             }
           }
        }
        
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
       return self.newsListViewModel.newsListviewModel.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Do the magic
        let viewModel = self.newsListViewModel.newsViewModel(at: indexPath.section)
        
        switch indexPath.section {
        case 0:
             let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeadlineTableViewCell.self), for: indexPath) as! HeadlineTableViewCell
                 cell.headLinesLabel.text = viewModel.Headline
                 cell.backgroundImage.downloaded(from: imageStringUrl+viewModel.LargeImageName)
               return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self), for: indexPath) as! NewsTableViewCell
            
            cell.layer.cornerRadius = 15
            cell.headLinesLabel.text = viewModel.Headline
            cell.blurbLabel.text = viewModel.Blurb
            cell.SiteNameLabel.text = viewModel.SiteName
            cell.smallImageView.downloaded(from: imageStringUrl+viewModel.SmallImageName)
            cell.clipsToBounds = true
            return cell
        }
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           let viewModel = self.newsListViewModel.newsViewModel(at: indexPath.section)
     
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Article_VC") as? ArticleViewController{
            if let navigator = navigationController {
            
                
                viewController.SiteName = viewModel.SiteName
                viewController.UrlFriendlyDate = viewModel.UrlFriendlyDate
                viewController.UrlFriendlyHeadline = viewModel.UrlFriendlyHeadline
                viewController.UrlName = viewModel.UrlName
                viewController.headline = viewModel.Headline
            
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    // Set the spacing between sections
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through
  override  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
