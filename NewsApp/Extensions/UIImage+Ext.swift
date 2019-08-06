//
//  UIImage+Ext.swift
//  NewsApp
//
//  Created by Gontse Ranoto on 2019/08/06.
//  Copyright © 2019 Gontse Ranoto. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
