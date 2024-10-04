//
//  ViewController.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import UIKit

final class NewsVC: UIViewController {

    private lazy var newsView = NewsView()
    private let model: NewsModelProtocol
    private var isLoading = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.newsView.activityIndicator.startAnimating()
                } else {
                    self.newsView.activityIndicator.stopAnimating()
                }
            }
        }
    }

    init(model: NewsModelProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = newsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        collectionViewConfigure()
        updateNews()
    }
    
    private func collectionViewConfigure() {
        self.newsView.newsCollectionView.delegate = self
        self.newsView.newsCollectionView.dataSource = self
        self.newsView.newsCollectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)
    }
    
    private func updateNews(append: Bool = false) {
        isLoading = true

        Task {
            defer {
                isLoading = false
            }
            do {
                try await model.updateNews(append: append)
                DispatchQueue.main.async {
                    self.newsView.newsCollectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension NewsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == newsView.newsCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewsCell.reuseID,
                for: indexPath) as! NewsCell
            let news = model.news[indexPath.item]
            cell.fill(news: news)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension NewsVC: UICollectionViewDelegateFlowLayout {
    
}
