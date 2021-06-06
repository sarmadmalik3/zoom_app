//
//  Extension.swift
//  ZoomApp
//
//  Created by Sarmad Ishfaq on 06/06/2021.
//

import Foundation
import UIKit


enum fontName : String {
   case Poppins_Light = "Poppins-Light"
   case Poppins_Medium = "Poppins-Medium"
   case Poppins_Regular = "Poppins-Regular"
   case Poppins_Bold = "Poppins-Bold"
   case Poppins_SemiBold = "Poppins-SemiBold"
}

extension UIFont {

   static func setFont(fontName: fontName , fontSize: CGFloat) -> UIFont {
        
        let font = UIFont(name: fontName.rawValue, size: fontSize)!
        return font
    }
}

extension Int{
    var autoSized : CGFloat{
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let diagonalSize = sqrt((screenWidth * screenWidth) + (screenHeight * screenHeight))
        let percentage = CGFloat(self)/895*100 //987 is the diagonal size of iphone xs max
        return diagonalSize * percentage / 100
    }
    
    var widthRatio: CGFloat {
        let width = UIScreen.main.bounds.width/375.0 //iphone 11 pro
        return CGFloat(self)*width
    }
    var heightRatio: CGFloat {
        let width = UIScreen.main.bounds.height/812.0 //iphone 11pro
        return CGFloat(self)*width
    }
}
