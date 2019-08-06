//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Gontse Ranoto on 2019/08/05.
//  Copyright © 2019 Gontse Ranoto. All rights reserved.
//

import Foundation

class NewsListViewModel {
    
    var newsListviewModel: [NewsViewModel]
    
    init() {
        self.newsListviewModel = [NewsViewModel]()
    }
}

extension NewsListViewModel {
    func newsViewModel(at index: Int) -> NewsViewModel {
        return self.newsListviewModel[index]
    }
}



struct NewsViewModel {
    let news: News
}

extension NewsViewModel {
    
    var Headline: String {
        return news.Headline
    }
    var Blurb: String {
        return news.Blurb
    }
    var SiteName: String {
        return news.SiteName
    }
    var UrlName: String {
        return news.UrlName
    }
    var UrlFriendlyDate: String {
        return news.UrlFriendlyDate
    }
    var SmallImageName: String {
        return news.SmallImageName
    }    
    var DateCreated: String {
        return news.DateCreated
    }
   var UrlFriendlyHeadline: String {
     return news.UrlFriendlyHeadline
    }    
    var LargeImageName: String {
        return news.LargeImageName
    }
}
