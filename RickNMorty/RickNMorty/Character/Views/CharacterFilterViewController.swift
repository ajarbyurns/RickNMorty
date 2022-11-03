//
//  CharacterFilterViewController.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 01/11/22.
//

import UIKit

protocol CharacterFilterDelegate : AnyObject {
    func applyFilter(_ status : String?, _ species : String?, _ gender : String?)
}

class CharacterFilterViewController: UIViewController {
    
    var viewModel : CharacterFilterViewModel
    weak var delegate : CharacterFilterDelegate?
    
    let headerLabel : UILabel
    let container : UIView
    var collectionView : UICollectionView?
    let applyButton : UIButton
    
    init(_ viewModel : CharacterFilterViewModel){
        self.viewModel = viewModel
        headerLabel = UILabel()
        applyButton = UIButton()
        container = UIView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not in Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        if let collectionView = collectionView {
            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -20).isActive = true
            collectionView.register(FilterButtonCell.self, forCellWithReuseIdentifier: cellId)
            collectionView.register(FilterSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }
    }
        
    override func loadView() {
        super.loadView()
        view.backgroundColor = .clear
        
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        headerLabel.text = "Filter"
        headerLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        headerLabel.textAlignment = .left
        headerLabel.textColor = .black
        container.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        headerLabel.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        applyButton.setTitle("Apply", for: .normal)
        applyButton.backgroundColor = .link
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.cornerRadius = 10
        container.addSubview(applyButton)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        applyButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        applyButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        applyButton.addAction(UIAction(handler: { action in
            self.applyFilter()
        }), for: .touchUpInside)
    }
    
    private func applyFilter(){
        dismiss(animated: true, completion: {
            self.delegate?.applyFilter(self.viewModel.selected[0], self.viewModel.selected[1], self.viewModel.selected[2])
        })
    }

}

extension CharacterFilterViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var inset: CGFloat {
        get { return 5 }
    }
    var cellId : String {
        get { return "FilterButtonCell" }
    }
    var headerId: String {
        get { return "FilterSectionHeader" }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rows[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect())
        label.text = viewModel.rows[indexPath.section][indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 20, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterButtonCell {
            if(cell.state == .normal){
                for i in 0..<collectionView.numberOfItems(inSection: indexPath.section){
                    let iPath = IndexPath(row: i, section: indexPath.section)
                    if let otherCell = collectionView.cellForItem(at: iPath) as? FilterButtonCell {
                        otherCell.state = .normal
                    }
                }
                cell.state = .selected
                viewModel.selectAt(indexPath.section, indexPath.row)
            } else {
                cell.state = .normal
                viewModel.deSelectAt(indexPath.section, indexPath.row)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: 0, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 40)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let name = viewModel.rows[indexPath.section][indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FilterButtonCell ?? FilterButtonCell(frame : CGRect())
        
        cell.setName(name)
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if(kind == UICollectionView.elementKindSectionHeader){
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? FilterSectionHeader ?? FilterSectionHeader(frame: CGRect())
            headerView.header.text = viewModel.sections[indexPath.section]
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
        
}
