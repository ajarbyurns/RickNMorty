//
//  AppDelegate.swift
//  RickNMorty

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureNavigation()
    
        return true
    }
    
    private func configureNavigation(){
        
        let character = CharacterListViewController()
        character.tabBarItem = UITabBarItem(title: "Character", image: .actions, selectedImage: .actions)
        
        let location = LocationListViewController()
        location.tabBarItem = UITabBarItem(title: "Location", image: .checkmark, selectedImage: .checkmark)
        
        let episode = EpisodeListViewController()
        episode.tabBarItem = UITabBarItem(title: "Episode", image: .add, selectedImage: .add)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [character, location, episode]
        
        tabBarController.tabBar.backgroundColor = .lightGray
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.link], for: .selected)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }

}
