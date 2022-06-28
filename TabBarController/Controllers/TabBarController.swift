//
//  ViewController.swift
//  TabBarController
//
//  Created by Hollie Fang on 2022/6/23.
//

import UIKit

class TabBarController: UIViewController {
    
    private let tabBar: TabBarView
    private let containerView = UIView()
    private let tabs: [Tab]
    var selectedTabIndex: Int? {
        didSet {
            selectedTabIndexDidChange(oldValue)
        }
    }
    
    init(tabs: [Tab] = Tab.generateTabs()) {
        self.tabs = tabs
        self.tabBar = TabBarView(barItems: tabs.map { $0.item })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews(tabs)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .link
    }
    
    private func configureViews(_ tabs: [Tab]) {
        view.backgroundColor = .white
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.delegate = self
        
        view.addSubview(tabBar)
        view.addSubview(containerView)
        
        tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tabBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.topAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        self.selectedTabIndex = 0
    }
    
    private func selectedTabIndexDidChange(_ oldValue: Int?) {
        guard let selectedTabIndex = selectedTabIndex,
              selectedTabIndex != oldValue else {
            return
        }
        title = tabs[selectedTabIndex].item.title
        tabBar.selectedIndex = selectedTabIndex
        updateChild(tabs[selectedTabIndex].controller)
    }
    
    private func updateChild(_ controller: UIViewController) {
        children.forEach {
            $0.willMove(toParent: nil)
            $0.removeFromParent()
            $0.view.removeFromSuperview()
            $0.didMove(toParent: nil)
        }
        
        addChild(controller)
        containerView.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}

extension TabBarController: TabBarViewDelegate {
    func tabBarView(_ tabBarView: TabBarView, didSelectItemAt index: Int) {
        selectedTabIndex = index
    }
}
