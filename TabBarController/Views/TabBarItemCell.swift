//
//  TabBarItemCell.swift
//  TabBarController
//
//  Created by Hollie Fang on 2022/6/26.
//

import UIKit

class TabBarItemCell: UICollectionViewCell {
    
    static let reuseIdentitfier = "TabBarItemCell"
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private var item: TabBarItem?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .lightGray
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12).isActive = true
    }
    
    func setTabBarItem(_ item: TabBarItem, selected: Bool = false) {
        iconImageView.image = selected ? item.selectedIcon : item.icon
        titleLabel.text = item.title
        self.item = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
