//
//  FavotitesVC.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import UIKit

final class FavoritesVC: UIViewController {

    private lazy var favoritesView = FavotitesView()
    private let model: FavoritesModelProtocol
    
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
    
    private func collectionConfigure() {
//        favoritesView.favorCollectionView.dataSource = self
//        favoritesView.favorCollectionView.delegate = self
//        favoritesView.favorCollectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)

    }

}

//extension FavoritesVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
//
//extension FavoritesVC: UICollectionViewDelegateFlowLayout {
//    
//}
