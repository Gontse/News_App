//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Gontse Ranoto on 2019/08/06.
//  Copyright © 2019 Gontse Ranoto. All rights reserved.
//

import Foundation


//let Body: String
//let Headline: String
//let SmallImageName: String

struct ArticleViewModel {
    let article : Article
}


extension ArticleViewModel {
    
    var Headline: String {
        return article.Headline
    }
    
    var Body: String {
        return article.Body
    }
    
    var LargeImageName: String {
        return article.LargeImageName
    }
}
