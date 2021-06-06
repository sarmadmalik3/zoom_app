//
//  CustomLabel.swift
//  ZoomApp
//
//  Created by Sarmad Ishfaq on 06/06/2021.
//

import Foundation
import UIKit


class CustomLabel: UILabel {

    init(text: String, textColor: UIColor , font: UIFont , alingment: NSTextAlignment) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.textAlignment = alingment
        self.numberOfLines = 0
        self.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).heightRatio))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
