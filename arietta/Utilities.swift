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
    
    /// Returns a white attributed body text.
    static func attributedWhiteBodyText(text: String, fontSize: CGFloat) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Cabin-BoldItalic", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular),
            .foregroundColor: UIColor(named: "AriettaBackgroundColor") ?? .white
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    /// Returns a black attributed body text.
    static func attributedBlackBodyText(text: String, fontSize: CGFloat) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Cabin-BoldItalic", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular),
            .foregroundColor: UIColor(named: "AriettaButtonColor") ?? .white
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    /// Returns a filled button matching UI design. Need to set height to 50 in UIView.
    static func getButton(title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AriettaButtonColor")
        button.setAttributedTitle(attributedWhiteBodyText(text: title, fontSize: 18), for: .normal)
        button.setTitleColor(UIColor(named:"AriettaBackgroundColor"), for: .normal)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    /// Returns a UIButton for level selection. need to add subview and addTarget separately.
    static func getLevelButton(_ level: String) -> UIButton {
        var button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25 // Make it circular
        
        // Set initial colors
        button.backgroundColor = UIColor(named: "AriettaButtonColor")
        button.setTitleColor(UIColor(named: "AriettaBackgroundColor"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.clear.cgColor // No initial stroke color
        
        button.setAttributedTitle(UtilityFunctions.attributedWhiteBodyText(text: level, fontSize: 18), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return button
    }
}

