//
//  CharacterDetailViewController.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 01/11/22.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var viewModel : CharacterDetailViewModel
    var imageView : UIImageView
    
    init(_ viewModel: CharacterDetailViewModel){
        self.viewModel = viewModel
        imageView = UIImageView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not in Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        if let data = viewModel.characterImgData {
            imageView.image = UIImage(data: data)
        } else {
            viewModel.loadImage()
        }
         
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = lightBG
        
        self.navigationController?.navigationBar.topItem?.title = viewModel.character.name
        
        let container = UIView()
        container.backgroundColor = .white
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        
    }

}

extension CharacterDetailViewController : CharacterDetailDelegate {
    
    func imageLoaded(_ imageData: Data) {
        imageView.image = UIImage(data: imageData)
    }
    
    func foundError(_ error: ApiError) {
        switch error {
        case .URL:
            print("URL Error")
        case .Connection:
            print("Connection Error")
        case .Json:
            print("JSON Error")
        }
    }
    
}
