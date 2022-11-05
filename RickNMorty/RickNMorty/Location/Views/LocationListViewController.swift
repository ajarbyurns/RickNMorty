//
//  LocationListViewController.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 31/10/22.
//

import UIKit

class LocationListViewController: UIViewController {
    
    var viewModel : LocationListViewModel
    
    let searchTextField : UITextField
    let divider : UIView
    var tableView : UITableView
    
    init(_ viewModel: LocationListViewModel){
        self.viewModel = viewModel
        self.divider = UIView()
        searchTextField = UITextField()
        tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not in Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.getLocations()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = lightBG
        
        self.navigationController?.navigationBar.topItem?.title = "Location"
        
        let searchView = UIView()
        searchView.layer.cornerRadius = 10
        searchView.backgroundColor = .lightGray
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
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
        
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationListCell.self, forCellReuseIdentifier: cellId)
    }

}

extension LocationListViewController : LocationListViewModelDelegate {
    
    func locationsSet() {
        tableView.reloadData()
    }
    
    func noMorePages() {
        print("All Pages Loaded")
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
    
}

extension LocationListViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(!textField.hasText){
            viewModel.getLocations()
        } else {
            viewModel.getLocationsByFilter(textField.text)
        }
        tableView.setContentOffset(CGPoint(x:0,y:0), animated: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        return alphabet
    }
}

extension LocationListViewController : UITableViewDelegate, UITableViewDataSource {
    
    var cellId : String {
        get { return "LocationCell" }
    }
    
    var spacing : CGFloat {
        get { return 5 }
    }
    
    var rowHeight : CGFloat {
        get { return 80 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == viewModel.locations.count - 1 ) {
            viewModel.loadMore()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? LocationListCell ?? LocationListCell()
        cell.viewModel = LocationDetailViewModel(viewModel.locations[indexPath.section])
        cell.layoutIfNeeded()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return spacing
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
