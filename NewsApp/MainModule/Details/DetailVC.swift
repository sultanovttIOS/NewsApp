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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func fill() {
        
    }
}
