//
//  DetailView.swift
//  NewsApp
//
//  Created by Alisher Sultanov on 4/10/24.
//

import UIKit

final class DetailView: UIView {

    // MARK: UI Components
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
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
        addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(imageView)
        scrollContentView.addSubview(authorLabel)
        scrollContentView.addSubview(titleLabel)
        scrollContentView.addSubview(descLabel)
        scrollContentView.addSubview(linkButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 40),

            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContentView.heightAnchor.constraint(equalToConstant: 1000),
            
            imageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
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
