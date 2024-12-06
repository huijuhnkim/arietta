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
            .foregroundColor: UIColor(named: "AriettaButtonColor") ?? .black
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    /// Returns a filled button matching UI design.
    static func getFilledButton(title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AriettaButtonColor")
        button.setAttributedTitle(attributedWhiteBodyText(text: title, fontSize: 18), for: .normal)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 328),
        ])
        
        return button
    }
    
    /// Returns a filled button matching UI design.
    static func getStrokedButton(title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AriettaBackgroundColor")
        button.setAttributedTitle(attributedBlackBodyText(text: title, fontSize: 18), for: .normal)
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named:"AriettaButtonColor")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 328),
        ])
        
        return button
    }
    
    /// Returns a UIButton for level selection. need to add subview and addTarget separately.
    static func getLevelButton(_ level: String) -> UIButton {
        let button = UIButton(type: .custom)
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
    
    /// Returns a filled UIButton for keyboard.
    static func getBlackKeyboardButton(note: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "AriettaButtonColor")
        button.setAttributedTitle(attributedWhiteBodyText(text: note, fontSize: 18), for: .normal)
        button.layer.cornerRadius = 24
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 118),
            button.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        return button
    }
    
    /// Returns a stroked UIButton for keyboard.
    static func getWhiteKeyboardButton(note: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(attributedBlackBodyText(text: note, fontSize: 18), for: .normal)
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named:"AriettaButtonColor")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 118),
            button.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        return button
    }
    
    
    static private func getAttributedPlaceholder(_ placeholder: String) -> NSAttributedString {
        let attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont(name: "Cabin-BoldItalic", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .regular),
            ])

        return attributedPlaceholder
    }
    
    static func getTextField(placeholder: String)-> UITextField {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = getAttributedPlaceholder(placeholder)
        textField.textColor = UIColor(named: "AriettaButtonColor")
        textField.textAlignment = .center
        
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 25
        textField.layer.borderColor = UIColor(named: "AriettaButtonColor")?.cgColor
        
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 328),
            textField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        return textField
    }
}

