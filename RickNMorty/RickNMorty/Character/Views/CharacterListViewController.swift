//
//  CharacterListViewController.swift
//  RickNMorty

import UIKit

class CharacterListViewController: UIViewController {
    
    var viewModel : CharacterListViewModel
    
    init(_ viewModel: CharacterListViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not in Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.getCharacters()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

}

extension CharacterListViewController : CharacterListViewModelDelegate {
    
    func setCharacters(_ characters: [Character]) {
        print(characters.count)
        print(characters[0].image)
    }
    
    func error(_ error: ApiError) {
        switch error {
        case .ConnectionError:
            print("Connection Error")
        case .JSONError:
            print("JSON Error")
        }
    }
    
    
}
