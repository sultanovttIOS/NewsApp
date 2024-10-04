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
    private let news: NewsEntity
    
    // MARK: Lifecycle
    
    init(news: NewsEntity) {
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
        
        detailView.fill(news: news)
        
        Task {
            if let imageUrlString = news.imageUrl,
               let imageURL = URL(string: imageUrlString) {
                let image = await NetworkService.shared.getImage(from: imageURL)
                detailView.fillImage(image: image)
            } else {
                detailView.fillImage(image: UIImage(named: ""))
            }
        }
        
        detailView.linkButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.onTap()
        }, for: .touchUpInside)
    }
    
    private func onTap() {
        guard let urlString = news.link,
              let url = URL(string: urlString) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
