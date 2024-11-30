//
//  HomeView.swift
//  arietta
//
//  Created by Hui Juhn Kim on 11/30/24.
//

import UIKit

class HomeView: UIView {
    
    var labelQuote: UILabel!
    var buttonSightReading: UIButton!
    var buttonEarTraining: UIButton!
    var buttonProgressReport: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "AriettaBackgroundColor")
        
        setup()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        labelQuote = UILabel()
        labelQuote.text = "Random quotes from musicians"
        labelQuote.textAlignment = .center
        labelQuote.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelQuote)
        
        buttonSightReading = UIButton()
        buttonSightReading.setTitle("Sight Reading", for: .normal)
        buttonSightReading.backgroundColor = UIColor(named: "AriettaButtonColor")
        buttonSightReading.setTitleColor(UIColor(named:"AriettaBackgroundColor"), for: .normal)
        buttonSightReading.layer.cornerRadius = 24
        buttonSightReading.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSightReading)
        
        buttonEarTraining = UIButton()
        buttonEarTraining.setTitle("Ear Training", for: .normal)
        buttonEarTraining.backgroundColor = UIColor(named: "AriettaButtonColor")
        buttonEarTraining.setTitleColor(UIColor(named:"AriettaBackgroundColor"), for: .normal)
        buttonEarTraining.layer.cornerRadius = 24
        buttonEarTraining.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEarTraining)
        
        buttonProgressReport = UIButton()
        buttonProgressReport.setTitle("Progress Report", for: .normal)
        buttonProgressReport.backgroundColor = UIColor(named: "AriettaButtonColor")
        buttonProgressReport.setTitleColor(UIColor(named:"AriettaBackgroundColor"), for: .normal)
        buttonProgressReport.layer.cornerRadius = 24
        buttonProgressReport.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonProgressReport)
    }
    
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelQuote.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelQuote.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            
            buttonProgressReport.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonProgressReport.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            buttonProgressReport.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            buttonProgressReport.heightAnchor.constraint(equalToConstant: 50),
            buttonProgressReport.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -26),
            
            buttonEarTraining.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonEarTraining.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            buttonEarTraining.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            buttonEarTraining.heightAnchor.constraint(equalToConstant: 50),
            buttonEarTraining.bottomAnchor.constraint(equalTo: buttonProgressReport.topAnchor, constant: -24),
            
            buttonSightReading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSightReading.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            buttonSightReading.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            buttonSightReading.heightAnchor.constraint(equalToConstant: 50),
            buttonSightReading.bottomAnchor.constraint(equalTo: buttonEarTraining.topAnchor, constant: -24),
        ])
    }
}
