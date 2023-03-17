//
//  DownloadViewController.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-07.
//

import UIKit

class DownloadViewController: UIViewController {
    
    let downloadTabelView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.cellIdentifier)
        tableView.separatorColor = UIColor.clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(downloadTabelView)
        tabelViewSetup()
        title = "Download"
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTabelView.frame = view.bounds
    }
    
    private func tabelViewSetup() {
        downloadTabelView.delegate = self
        downloadTabelView.dataSource = self
    }
    
    
}


// MARK: - Table view extension
extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.cellIdentifier, for: indexPath)
//        cell.backgroundColor = .systemCyan
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
