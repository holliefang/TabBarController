//
//  ViewController.swift
//  TabBarController
//
//  Created by Hollie Fang on 2022/6/23.
//

import UIKit

class TabBarController: UIViewController {
    
    private let tabBar: TabBarView
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
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
        
        view.addSubview(tabBar)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        tabBar.delegate = self
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self

        tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tabBar.heightAnchor.constraint(equalToConstant: 40).isActive = true

        scrollView.topAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
                
        for _ in 0..<tabs.count {
            let placeholderView = UIView()
            placeholderView.backgroundColor = .clear
            placeholderView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(placeholderView)
            placeholderView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            placeholderView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
        self.selectedTabIndex = 0
    }
    
    private func selectedTabIndexDidChange(_ oldValue: Int?) {
        guard let selectedTabIndex = selectedTabIndex,
              selectedTabIndex != oldValue else {
            return
        }
        title = tabs[selectedTabIndex].item.title
        tabBar.selectedItem = selectedTabIndex
        addTabToChildIfNeeded(at: selectedTabIndex)
        scrollSelectedTabToVisisble(at: selectedTabIndex)
    }
    
    private func addTabToChildIfNeeded(at index: Int) {
        let isChildAdded = tabs[index].controller.view.isDescendant(of: view)
        if !isChildAdded {
            addChild(tabs[index].controller)
            stackView.subviews[index].addSubview(tabs[index].controller.view)
            tabs[index].controller.didMove(toParent: self)
        }
    }
    
    private func scrollSelectedTabToVisisble(at index: Int) {
        let point = CGPoint(x: scrollView.bounds.width * CGFloat(index), y: 0)
        let rect = CGRect(origin: point,
                          size: scrollView.bounds.size)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
}

extension TabBarController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / scrollView.bounds.width)
        selectedTabIndex = index
    }
}

extension TabBarController: TabBarViewDelegate {
    func tabBarView(_ tabBarView: TabBarView, didSelectItem item: Int) {
        selectedTabIndex = item
    }
}
