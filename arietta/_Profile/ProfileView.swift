//
//  ProfileView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 12/8/24.
//

import UIKit

class ProfileView: UIView {
    
    var stackProfilePicture: UIStackView!
    var buttonProfilePicture: UIButton!
    var imageProfilePicture: UIImage!
    var labelEditProfilePicture: UILabel!
    var labelUsername: UILabel!
    var labelEmail: UILabel!
    var buttonSignOut: UIButton!
    var labelProgressReport: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "AriettaBackgroundColor")
        
        setup()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        //MARK: would need to load picture from Firebase, but adding in SF icons for now
        stackProfilePicture = UIStackView()
        stackProfilePicture.axis = .vertical
        stackProfilePicture.alignment = .center
        stackProfilePicture.spacing = 8
        stackProfilePicture.translatesAutoresizingMaskIntoConstraints = false

        buttonProfilePicture = UIButton()
        buttonProfilePicture.translatesAutoresizingMaskIntoConstraints = false
        buttonProfilePicture.setImage(UIImage(systemName: "person.fill"), for: .normal)
        buttonProfilePicture.imageView?.contentMode = .scaleAspectFit
        addSubview(buttonProfilePicture)
        
        labelEditProfilePicture = UILabel()
        labelEditProfilePicture.attributedText = UtilityFunctions.attributedBlackBodyText(text: "Edit", fontSize: 12)
    
        stackProfilePicture.addArrangedSubview(buttonProfilePicture)
        stackProfilePicture.addArrangedSubview(labelEditProfilePicture)
        addSubview(stackProfilePicture)
        
        labelUsername = UILabel()
        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        labelUsername.attributedText = UtilityFunctions.attributedNavigationTitle(text: "John")
        addSubview(labelUsername)
        
        labelEmail = UILabel()
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.attributedText = UtilityFunctions.attributedBlackBodyText(text: "johndoe@gmail.com", fontSize: 18)
        addSubview(labelEmail)
        
        buttonSignOut = UIButton(type: .system)
        buttonSignOut.translatesAutoresizingMaskIntoConstraints = false
        buttonSignOut.tintColor = .blue
        buttonSignOut.setTitle("sign out", for: .normal)
        addSubview(buttonSignOut)
        
        labelProgressReport = UILabel()
        labelProgressReport.translatesAutoresizingMaskIntoConstraints = false
        labelProgressReport.attributedText = UtilityFunctions.attributedNavigationTitle(text: "Progress Report")
        addSubview(labelProgressReport)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            stackProfilePicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 151),
            stackProfilePicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43),
            stackProfilePicture.widthAnchor.constraint(equalToConstant: 72),
            stackProfilePicture.heightAnchor.constraint(equalToConstant: 72),
            
            labelUsername.topAnchor.constraint(equalTo: self.topAnchor, constant: 140),
            labelUsername.leadingAnchor.constraint(equalTo: stackProfilePicture.trailingAnchor, constant: 39),
            
            labelEmail.topAnchor.constraint(equalTo: labelUsername.bottomAnchor, constant: 6),
            labelEmail.leadingAnchor.constraint(equalTo: labelUsername.leadingAnchor),
            
            buttonSignOut.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 6),
            buttonSignOut.leadingAnchor.constraint(equalTo: labelUsername.leadingAnchor),
            
            labelProgressReport.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelProgressReport.topAnchor.constraint(equalTo: stackProfilePicture.bottomAnchor, constant: 105)
        ])
    }
    
}
