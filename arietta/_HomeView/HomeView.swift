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
        
        buttonSightReading = UtilityFunctions.getFilledButton(title: "Sight Reading")
        self.addSubview(buttonSightReading)
        
        buttonEarTraining = UtilityFunctions.getFilledButton(title: "Ear Training")
        self.addSubview(buttonEarTraining)
        
        buttonProgressReport = UtilityFunctions.getFilledButton(title: "Progress Report")
        self.addSubview(buttonProgressReport)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelQuote.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelQuote.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            
            buttonProgressReport.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonProgressReport.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -26),
            
            buttonEarTraining.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonEarTraining.bottomAnchor.constraint(equalTo: buttonProgressReport.topAnchor, constant: -24),
            
            buttonSightReading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSightReading.bottomAnchor.constraint(equalTo: buttonEarTraining.topAnchor, constant: -24),
        ])
    }
}
