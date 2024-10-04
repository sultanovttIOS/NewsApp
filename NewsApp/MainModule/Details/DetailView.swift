//
//  DetailView.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import UIKit

final class DetailView: UIView {
    
    // MARK: Properties
    
    var onTap: (() -> Void)?
    
    // MARK: UI Components
        
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.textColor = .black
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let authorLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textColor = .darkGray
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let linkButton: UIButton = {
        let view = UIButton()
        view.titleLabel?.textAlignment = .left
        view.titleLabel?.lineBreakMode = .byWordWrapping
        view.titleLabel?.numberOfLines = 0
        view.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        view.setTitleColor(.link, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    // MARK: Lifecycle
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(authorLabel)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(linkButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            
            linkButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20),
            linkButton.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            linkButton.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
        ])
    }
    
    func fill(news: NewsEntity) {
        authorLabel.text = news.sourceName
        titleLabel.text = news.title
        descLabel.text = news.desc
        linkButton.setTitle(news.link, for: .normal)
    }
    
    func fillImage(image: UIImage?) {
        imageView.image = image
    }
}
