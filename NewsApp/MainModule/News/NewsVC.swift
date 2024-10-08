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
    private var isAllNewsLoaded = false
    private var isLoadingNews = false
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
    
    // MARK: Lifecycle
    
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
        collectionViewConfigure()
        
        if model.newsFromLocal.isEmpty {
             updateNews()
         } else {
             self.newsView.newsCollectionView.reloadData()
         }
    }
    
    private func collectionViewConfigure() {
        self.newsView.newsCollectionView.delegate = self
        self.newsView.newsCollectionView.dataSource = self
        self.newsView.newsCollectionView.register(
            NewsCell.self,
            forCellWithReuseIdentifier: NewsCell.reuseID)
    }
    
    private func updateNews(append: Bool = false) {
        isLoading = true
        
        guard !isLoadingNews else { return }
        isLoadingNews = true
        
        Task {
            defer {
                self.isLoading = false
                self.isLoadingNews = false
            }
            
            do {
                let oldCount = model.newsFromLocal.count
                try await model.updateNews(append: append)
                let newCount = model.newsFromLocal.count
                
                if newCount == oldCount {
                    isAllNewsLoaded = true
                }
                
                DispatchQueue.main.async {
                    self.newsView.newsCollectionView.reloadData()
                    print("News count: \(self.model.newsFromLocal.count)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: UICollectionViewDataSource

extension NewsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return model.newsFromLocal.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == newsView.newsCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewsCell.reuseID,
                for: indexPath) as! NewsCell
            
            let news = model.newsFromLocal[indexPath.item]
            cell.fill(news: news)
            Task {
                if let imageUrlString = news.imageUrl,
                   let imageURL = URL(string: imageUrlString) {
                    let image = await NetworkService.shared.getImage(from: imageURL)
                    cell.fillImage(image: image)
                } else {
                    cell.fillImage(image: UIImage(named: "example"))
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension NewsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
           if indexPath.item >= model.newsFromLocal.count - 2,
           !isLoadingNews,
           !isAllNewsLoaded {
            
            updateNews(append: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == newsView.newsCollectionView {
            
            if indexPath.item <= model.newsFromLocal.count {
                
                let news = model.newsFromLocal[indexPath.item]
                
                let detailModel = DetailModel()
                let vc = DetailVC(model: detailModel, news: news)
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
