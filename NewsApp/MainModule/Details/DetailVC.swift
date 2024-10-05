//
//  DetailVC.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import UIKit

final class DetailVC: UIViewController {
    
    // MARK: Properties
    
    private lazy var detailView = DetailView()
    private let news: News
    private let model: DetailModelProtocol
    
    // MARK: Lifecycle
    
    init(model: DetailModelProtocol, news: News) {
        self.model = model
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Details"
        fill()
        addAction()
        updateFavoriteButton()
    }
    
    private func addAction() {
        detailView.linkButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.openSourceLink()
        }, for: .touchUpInside)
    }
    
    // MARK: Fill Detail
    
    private func fill() {
        Task {
            if let imageUrlString = news.imageUrl,
               let imageURL = URL(string: imageUrlString) {
                let image = await NetworkService.shared.getImage(from: imageURL)
                detailView.fillImage(image: image)
            } else {
                detailView.fillImage(image: UIImage(named: "example"))
            }
        }
        
        detailView.fill(news: news)
    }
    
    // MARK: Like button state
    
    private func updateFavoriteButton() {
        let isFavorite = model.isFavorite(news: news)
        let buttonState = isFavorite ? "heart.fill" : "heart"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: buttonState),
            style: .plain,
            target: self,
            action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    // MARK: Link open
    
    private func openSourceLink() {
        guard let urlString = news.link,
              let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: delete or add to Favorites
    
    @objc
    private func likeButtonTapped() {
        if model.isFavorite(news: news) {
            model.removeFromFavorites(news: news)
        } else {
            model.addToFavorites(news: news)
        }
        
        updateFavoriteButton()
    }
}

