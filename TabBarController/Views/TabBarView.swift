//
//  TabBarView.swift
//  TabBarController
//
//  Created by Hollie Fang on 2022/6/24.
//

import UIKit

protocol TabBarViewDelegate: AnyObject {
    func tabBarViewDidSelect(_ tabBarView: TabBarView, index: Int)
}

class TabBarView: UIView {
    
    var barItems: [TabBarItem] = []
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    weak var delegate: TabBarViewDelegate?
    
    var selectedItem: Int? {
        didSet {
            selectedItemDidUpdate(oldValue)
        }
    }
    
    init(barItems: [TabBarItem]) {
        self.barItems = barItems
        super.init(frame: .zero)
        configureViews()
    }
    
    private func configureViews() {
        translatesAutoresizingMaskIntoConstraints = false

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 4
            flowLayout.scrollDirection = .horizontal
        }

        collectionView.register(TabBarItemCell.self, forCellWithReuseIdentifier: TabBarItemCell.reuseIdentitfier)
    
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.layoutIfNeeded()
        if selectedItem == nil {
            selectedItem = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func selectedItemDidUpdate(_ oldValue: Int?) {
        guard let selectedItem = selectedItem,
              selectedItem != oldValue else {
            return
        }
        
        let selectedIndexPath = IndexPath(row: selectedItem, section: 0)
        
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView(collectionView, didSelectItemAt: selectedIndexPath)
        
        if let oldValue = oldValue {
            let deselectedIndexPath = IndexPath(row: oldValue, section: 0)
            collectionView(collectionView, didDeselectItemAt: deselectedIndexPath)
        }
    }
}

extension TabBarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        barItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarItemCell.reuseIdentitfier, for: indexPath) as! TabBarItemCell
        cell.setTabBarItem(barItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width / 3) - 2,
                      height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? TabBarItemCell
        delegate?.tabBarViewDidSelect(self, index: indexPath.item)
        cell?.setTabBarItem(barItems[indexPath.item], selected: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TabBarItemCell
        cell?.setTabBarItem(barItems[indexPath.item], selected: false)
    }
}
