//
//  FilterButtonCell.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 03/11/22.
//

import UIKit

class FilterButtonCell: UICollectionViewCell {
    
    var nameLabel : UILabel
    
    enum State{
        case selected, normal
    }
    var state : State = .normal{
        didSet{
            switch state {
            case .selected:
                nameLabel.textColor = .link
                layer.borderColor = UIColor.link.cgColor
            case .normal:
                nameLabel.textColor = .darkGray
                layer.borderColor = UIColor.darkGray.cgColor
            }
        }
    }
    
    override init(frame : CGRect){
        self.nameLabel = UILabel()
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .darkGray
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
     
    required init?(coder: NSCoder) {
        fatalError("Not In Storyboard")
    }
    
    func setName(_ name : String){
        nameLabel.text = name
    }
}
