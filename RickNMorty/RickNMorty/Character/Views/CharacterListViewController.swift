//
//  CharacterListViewController.swift
//  RickNMorty

import UIKit

class CharacterListViewController: UIViewController {
    
    var viewModel : CharacterListViewModel
    
    let searchTextField : UITextField
    let divider : UIView
    var collectionView : UICollectionView?
    
    init(_ viewModel: CharacterListViewModel){
        self.viewModel = viewModel
        self.divider = UIView()
        searchTextField = UITextField()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not in Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.itemSize = CGSize(width: view.frame.width/CGFloat(cellsPerRow) - (2 * inset), height: view.frame.height/4)
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        if let collectionView = self.collectionView {
            collectionView.backgroundColor = .white
            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(CharacterListCell.self, forCellWithReuseIdentifier: cellId)
        }

        viewModel.delegate = self
        viewModel.getCharacters()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = lightBG
        
        let filter = UIImageView(image: UIImage(named: "Filter"))
        view.addSubview(filter)
        filter.translatesAutoresizingMaskIntoConstraints = false
        filter.widthAnchor.constraint(equalToConstant: 30).isActive = true
        filter.heightAnchor.constraint(equalToConstant: 30).isActive = true
        filter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        filter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        let filterTap = UITapGestureRecognizer(target: self, action: #selector(showFilters))
        filter.addGestureRecognizer(filterTap)
        filter.isUserInteractionEnabled = true
        
        let headerLabel = UILabel()
        headerLabel.text = "Character"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        headerLabel.textAlignment = .left
        headerLabel.textColor = .black
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        headerLabel.topAnchor.constraint(equalTo: filter.bottomAnchor, constant: 20).isActive = true
        
        let searchView = UIView()
        searchView.layer.cornerRadius = 10
        searchView.backgroundColor = .lightGray
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        let searchImage = UIImageView(image: UIImage(named: "Search"))
        searchView.addSubview(searchImage)
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        searchImage.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10).isActive = true
        searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 10).isActive = true
        searchImage.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -10).isActive = true
        searchImage.widthAnchor.constraint(equalTo: searchImage.heightAnchor, multiplier: 1).isActive = true

        searchView.addSubview(searchTextField)
        searchTextField.keyboardType = .webSearch
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 10).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10).isActive = true
        searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -10).isActive = true
        searchTextField.delegate = self
        
        divider.backgroundColor = .lightGray
        view.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        divider.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc private func showFilters(){
        
    }

}

extension CharacterListViewController : CharacterListViewModelDelegate {
    
    func charactersSet() {
        collectionView?.reloadData()
    }
    
    func foundError(_ error: ApiError) {
        switch error {
        case .Connection:
            print("Connection Error")
        case .URL:
            print("URL Error")
        case .Json:
            print("JSON Error")
        }
    }
    
    func noMorePages() {
        print("All Pages Loaded")
    }
    
}

extension CharacterListViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(!textField.hasText){
            viewModel.getCharacters()
        } else {
            viewModel.getCharactersByFilter(textField.text)
        }
        collectionView?.setContentOffset(CGPoint(x:0,y:0), animated: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        return alphabet
    }
}

extension CharacterListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    var inset: CGFloat {
        get { return 10 }
    }
    var minimumInteritemSpacing: CGFloat {
        get { return 20 }
    }
    var cellsPerRow : Int {
        get { return 2 }
    }
    var cellId : String {
        get { return "ImageCell" }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingFor section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == viewModel.characters.count - 1 ) {
            viewModel.loadMoreCharacters()
        }
        
        let chara = viewModel.characters[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CharacterListCell{
            cell.setCharacter(chara: chara)
            return cell
        } else {
            let cell = CharacterListCell(frame : CGRect())
            cell.setCharacter(chara: chara)
            return cell
        }
    }
    
}
