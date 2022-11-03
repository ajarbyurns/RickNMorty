//
//  FilterSectionHeader.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 03/11/22.
//

import UIKit

class FilterSectionHeader: UICollectionReusableView {
    
    var header: UILabel
    
    override init(frame: CGRect) {
        header = UILabel()
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not In Storyboard")
    }
    
    private func setupViews(){
        backgroundColor = .white
        
        header.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        header.textColor = .black
        header.textAlignment = .left
        header.numberOfLines = 1
        addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        header.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        header.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
        
}
