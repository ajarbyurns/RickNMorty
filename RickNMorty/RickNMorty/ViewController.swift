//
//  ViewController.swift
//  RickNMorty

import UIKit

class ViewController: UIViewController {
    
    enum Page {
        case Character, Location, Episode
    }
    private var currentPage : Page = .Character
    
    let container : UIView
    
    init(){
        container = UIView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Called During Init")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .lightGray
        
        setupContainer()
        //setupBottomNavigation()
    }
    
    func setupContainer(){
        container.backgroundColor = .white
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupToolBar(){
        
    }

    /*func setupBottomNavigation(){
        
        let bottom = UIView()
        bottom.backgroundColor = .lightGray
        
        self.view.addSubview(bottom)
        bottom.translatesAutoresizingMaskIntoConstraints = false
        bottom.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        bottom.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottom.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let character = createButton("Character", .add, #selector(goToCharacter(_:)))
        let location = createButton("Location", .checkmark, #selector(goToLocation(_:)))
        let episode = createButton("Episode", .actions, #selector(goToEpisode(_:)))
        
        bottom.addSubview(character)
        bottom.addSubview(location)
        bottom.addSubview(episode)
        character.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        episode.translatesAutoresizingMaskIntoConstraints = false
        
        character.leadingAnchor.constraint(equalTo: bottom.leadingAnchor, constant: 20).isActive = true
        character.topAnchor.constraint(equalTo: bottom.topAnchor, constant: 10).isActive = true
        character.bottomAnchor.constraint(equalTo: bottom.bottomAnchor, constant: -10).isActive = true
        character.trailingAnchor.constraint(equalTo: location.leadingAnchor, constant: -20).isActive = true
        
        location.topAnchor.constraint(equalTo: bottom.topAnchor, constant: 10).isActive = true
        location.bottomAnchor.constraint(equalTo: bottom.bottomAnchor, constant: -10).isActive = true
        location.trailingAnchor.constraint(equalTo: episode.leadingAnchor, constant: -20).isActive = true
        
        episode.topAnchor.constraint(equalTo: bottom.topAnchor, constant: 10).isActive = true
        episode.bottomAnchor.constraint(equalTo: bottom.bottomAnchor, constant: -10).isActive = true
        episode.trailingAnchor.constraint(equalTo: bottom.trailingAnchor, constant: -20).isActive = true
        
        character.widthAnchor.constraint(equalTo: location.widthAnchor, multiplier: 1).isActive = true
        location.widthAnchor.constraint(equalTo: episode.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func createButton(_ title: String, _ image: UIImage, _ action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.link, for: .selected)
        button.addTarget(self, action: action, for: .touchDown)
        return button
    }*/
    
    /*private func createBarButtonItem(_ title: String, _ image: UIImage, _ action: Selector) -> UIBarButtonItem {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.link, for: .selected)
        button.addTarget(self, action: action, for: .touchDown)
        return button
    }*/
    
    @objc func goToCharacter(_ sender: Any?){
        
    }

    @objc func goToLocation(_ sender: Any?){
        
    }

    @objc func goToEpisode(_ sender: Any?){
        
    }
}

