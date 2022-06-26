//
//  FavoriteController.swift
//  TabBarController
//
//  Created by Hollie Fang on 2022/6/26.
//

import UIKit

class FavoriteController: UIViewController {
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.sync {
                let controller = UIAlertController(
                    title: "Test", message: "Tab OK to close",
                    preferredStyle: .alert
                )
                controller.addAction(
                    UIAlertAction(title: "OK", style: .default)
                )
                UIApplication.shared
                    .keyWindow?.rootViewController?
                    .present(controller, animated: true)
            }
        }
    }
}
