//
//  AppDelegate.swift
//  RickNMorty

import UIKit

let lightBG = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
let darkBG = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)

enum ApiError {
    case URL, Connection, Json
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureNavigation()
    
        return true
    }
    
    private func configureNavigation(){
        
        let characterListRepo = CharacterListRepo()
        let characterListViewModel = CharacterListViewModel(characterListRepo)
        let character = CharacterListViewController(characterListViewModel)
        character.tabBarItem = UITabBarItem(title: "Character", image: UIImage(named: "CharacterD"), selectedImage: UIImage(named: "CharacterS"))
        let charNav = UINavigationController(rootViewController: character)
        charNav.navigationBar.backgroundColor = lightBG
        
        let locationListRepo = LocationListRepo()
        let locationListViewModel = LocationListViewModel(locationListRepo)
        let location = LocationListViewController(locationListViewModel)
        location.tabBarItem = UITabBarItem(title: "Location", image: UIImage(named: "LocationD"), selectedImage: UIImage(named: "LocationS"))
        let locationNav = UINavigationController(rootViewController: location)
        locationNav.navigationBar.backgroundColor = lightBG
        
        let episode = EpisodeListViewController()
        episode.tabBarItem = UITabBarItem(title: "Episode", image: UIImage(named: "EpisodeD"), selectedImage: UIImage(named: "EpisodeS"))
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [charNav, locationNav, episode]
        
        tabBarController.tabBar.backgroundColor = lightBG
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.link], for: .selected)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }

}

extension UITabBarController{
    
    open override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let height = 55.0

        tabBar.frame.size.height = height
        tabBar.frame.origin.y = view.frame.height - view.safeAreaInsets.bottom - height
    }
    
}
