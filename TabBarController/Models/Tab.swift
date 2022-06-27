//
//  Tab.swift
//  TabBarController
//
//  Created by Hollie Fang on 2022/6/24.
//

import UIKit

struct Tab {
    let item: TabBarItem
    let controller: UIViewController
    
    static func generateTabs() -> [Tab] {        
        
        return [
            Tab(item: TabBarItem(icon: UIImage(systemName: "house"),
                                 selectedIcon: UIImage(systemName: "house.fill"),
                                 title: "Home"),
                controller: HomeController()),
            Tab(item: TabBarItem(icon: UIImage(systemName: "star"),
                                 selectedIcon: UIImage(systemName: "star.fill"),
                                 title: "Favorite"),
                controller: FavoriteController()),
            Tab(item: TabBarItem(icon: UIImage(systemName: "bell"),
                                 selectedIcon: UIImage(systemName: "bell.fill"),
                                 title: "Notification"),
                controller: NotificationController()),
            Tab(item: TabBarItem(icon: UIImage(systemName: "person"),
                                 selectedIcon: UIImage(systemName: "person.fill"),
                                 title: "Me"),
                controller: MeController()),
        ]
    }
}

