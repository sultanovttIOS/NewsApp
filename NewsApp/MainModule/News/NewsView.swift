//
//  NewsView.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import UIKit

final class NewsView: UIView {
    
    // MARK: UI components
    
    lazy var newsCollectionView: UICollectionView = {
        let layout = createLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .none
        view.layer.shadowOpacity = 0
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Lifecycle
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set up UI
    
    private func setUpUI() {
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        addSubview(newsCollectionView)
        addSubview(activityIndicator)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            newsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.heightAnchor.constraint(equalToConstant: 20),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {(
            sectionIndex,
            layoutEnvironment) -> NSCollectionLayoutSection? in
                        
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(
                layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(369))
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item])
            
            let section = NSCollectionLayoutSection(
                group: group)
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 20,
                leading: 20,
                bottom: 40,
                trailing: 20)
            return section
            
        }
    }
}
