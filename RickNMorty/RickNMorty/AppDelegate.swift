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
        
        let characterListViewModel = CharacterListViewModel()
        let character = CharacterListViewController(characterListViewModel)
        character.tabBarItem = UITabBarItem(title: "Character", image: UIImage(named: "CharacterD"), selectedImage: UIImage(named: "CharacterS"))
        
        let location = LocationListViewController()
        location.tabBarItem = UITabBarItem(title: "Location", image: UIImage(named: "LocationD"), selectedImage: UIImage(named: "LocationS"))
        
        let episode = EpisodeListViewController()
        episode.tabBarItem = UITabBarItem(title: "Episode", image: UIImage(named: "EpisodeD"), selectedImage: UIImage(named: "EpisodeS"))
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [character, location, episode]
        
        tabBarController.tabBar.backgroundColor = .lightGray
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
