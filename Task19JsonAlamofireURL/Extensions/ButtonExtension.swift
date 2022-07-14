//
//  ButtonExtension.swift
//  Task19JsonAlamofireURL
//
//  Created by Ilia Zakharov on 07.07.2022.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(backgroundColor: UIColor, text: String, textColor: UIColor) {
        self.init()
        self.layer.cornerRadius = 10
        self.backgroundColor = backgroundColor
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
