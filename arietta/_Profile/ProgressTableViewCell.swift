//
//  ChatsTableViewCell.swift
//  homework8
//
//  Created by Charles Yang on 11/13/24.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelDate: UILabel!
    var labelDifficulty: UILabel!
    var labelScore: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelDate()
        setupLabelDifficulty()
        setupLabelScore()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = UIFont.boldSystemFont(ofSize: 14)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDate)
    }
    
    func setupLabelDifficulty(){
        labelDifficulty = UILabel()
        labelDifficulty.font = UIFont.boldSystemFont(ofSize: 14)
        labelDifficulty.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDifficulty)
    }
    
    func setupLabelScore(){
        labelScore = UILabel()
        labelScore.font = UIFont.boldSystemFont(ofSize: 14)
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelScore)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelDate.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelDate.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelDate.heightAnchor.constraint(equalToConstant: 20),
            labelDate.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -50),
            
            labelDifficulty.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 2),
            labelDifficulty.leadingAnchor.constraint(equalTo: labelDate.leadingAnchor),
            labelDifficulty.heightAnchor.constraint(equalToConstant: 32),
            labelDifficulty.widthAnchor.constraint(lessThanOrEqualTo: labelDate.widthAnchor),
            
            labelScore.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelScore.leadingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -42),
            labelScore.heightAnchor.constraint(equalToConstant: 20),
            labelScore.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
