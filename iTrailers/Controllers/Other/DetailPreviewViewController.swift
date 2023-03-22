//
//  DetailPreviewViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-22.
//

import UIKit
import WebKit

class DetailPreviewViewController: UIViewController {
    
    // MARK: - UI Elements
    // returns web content
    private let trailerView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(trailerView)
        addConstraints()
    }
    
    // MARK: - Private Methods
    private func addConstraints() {
        NSLayoutConstraint.activate([
            trailerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            trailerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            trailerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            trailerView.heightAnchor.constraint(equalToConstant: view.frame.size.height/2)
        ])
    }
    
    public func configure(with model: PreviewViewModel) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        trailerView.load(URLRequest(url: url))
    }
    
}
