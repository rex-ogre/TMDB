//
//  Extension+UIImageView.swift
//  Moive_test
//
//  Created by 陳冠雄 on 2021/5/5.
//

import Foundation
import UIKit
// 幫Imageview 增加功能
extension UIImageView {
    
    
    
    
    func loadImage(url: URL) {
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
