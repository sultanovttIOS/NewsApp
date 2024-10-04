//
//  NewsCell.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 3/10/24.
//

import UIKit

final class NewsCell: UICollectionViewCell {
    
    //MARK: Properties
    
    static let reuseID = String(describing: NewsCell.self)
    var onTap: (() -> Void)?
    private var newsID: String?

    //MARK: UI components
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let authorLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 19, weight: .bold)
        view.textColor = .black
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .black
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .gray
        view.textAlignment = .left
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let moreLabel: UILabel = {
        let view = UILabel()
        view.text = String(localized: "Подробнее")
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textColor = .black
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = nil
        dateLabel.text = nil
        imageView.image = nil
        newsID = nil
    }
    
    private func setUpUI() {
        addSubviews()
        setUpConstraints()
        layer.cornerRadius = 8
        layer.shadowOpacity = 0
        backgroundColor = .systemGray6
    }
    
    func fill(news: News) {
        newsID = news.articleId
        authorLabel.text = news.sourceName
        dateLabel.text = news.pubDate
        descLabel.text = news.description
        imageView.image = UIImage(named: news.imageUrl)
    }
    
    func fillImage(image: UIImage?) {
        
    }
    
    //MARK: addSubviews
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(moreLabel)
    }
    
    //MARK: Set Up Constraints
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            authorLabel.heightAnchor.constraint(equalToConstant: 27),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
                        
            descLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            descLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            
            moreLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 16),
            moreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -16),
            moreLabel.widthAnchor.constraint(equalToConstant: 94),
            moreLabel.heightAnchor.constraint(equalToConstant: 38),
        ])
    }
}

