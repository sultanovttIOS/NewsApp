//
//  FavotitesVC.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import UIKit

final class FavoritesVC: UIViewController {
    
    // MARK: Properties
    
    private lazy var favoritesView = FavotitesView()
    private let model: FavoritesModelProtocol
    
    // MARK: Lifecycle
    
    init(model: FavoritesModelProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites"
        
        collectionConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.fetchFavorites()
        self.favoritesView.favorCollectionView.reloadData()
    }
    
    private func collectionConfigure() {
        favoritesView.favorCollectionView.dataSource = self
        favoritesView.favorCollectionView.delegate = self
        favoritesView.favorCollectionView.register(
            NewsCell.self,
            forCellWithReuseIdentifier: NewsCell.reuseID)
    }
}

// MARK: UICollectionViewDataSource

extension FavoritesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return model.favoritesNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == favoritesView.favorCollectionView {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewsCell.reuseID,
                for: indexPath) as! NewsCell
            
            let news = model.favoritesNews[indexPath.item]
            cell.fillFav(news: news)
            Task {
                if let imageUrlString = news.imageUrl,
                   let imageURL = URL(string: imageUrlString) {
                    let image = await NetworkService.shared.getImage(from: imageURL)
                    cell.fillImage(image: image)
                } else {
                    cell.fillImage(image: UIImage(named: ""))
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension FavoritesVC: UICollectionViewDelegateFlowLayout {
    
}
