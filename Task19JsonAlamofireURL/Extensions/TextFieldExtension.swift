//
//  TextFieldExtension.swift
//  Task19JsonAlamofireURL
//
//  Created by Ilia Zakharov on 07.07.2022.
//

import Foundation
import UIKit

extension UITextField {
    
    convenience init(placeHolder: String ,keyboardType: UIKeyboardType) {
        self.init()
        self.keyboardType = keyboardType
        self.placeholder = placeHolder
        self.backgroundColor = #colorLiteral(red: 0.849806726, green: 0.849806726, blue: 0.849806726, alpha: 1)
        self.textColor = .black
        self.borderStyle = .roundedRect
        self.returnKeyType = .done
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
