//
//  LabelExtension.swift
//  Task19JsonAlamofireURL
//
//  Created by Ilia Zakharov on 07.07.2022.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init(text: String = "") {
        self.init()
        self.adjustsFontSizeToFitWidth = true
        self.text = text
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints =  false
    }
}
