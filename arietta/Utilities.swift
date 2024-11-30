//
//  Utilities.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/30/24.
//

import Foundation
import UIKit

struct UtilityFunctions {
    static func attributedNavigationTitle(text: String) -> NSAttributedString {
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont(name: "Besley", size: 24)!
//            ]
        
        return NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont(name: "Besley-ExtraBoldItalic", size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold),
            ]
        )
    }
    
    /// Returns an attributed string for the custom button.
    static func customAttributedTitle(text: String, fontSize: CGFloat) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Cabin-BoldItalic", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular),
            .foregroundColor: UIColor(named: "AriettaBackgroundColor") ?? .white
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    /// Returns a filled button matching UI design. Need to set height to 50 in UIView.
    static func getButton(title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AriettaButtonColor")
        button.setAttributedTitle(customAttributedTitle(text: title, fontSize: 18), for: .normal)
        button.setTitleColor(UIColor(named:"AriettaBackgroundColor"), for: .normal)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}

