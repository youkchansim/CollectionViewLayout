//
//  ViewController.swift
//  CollectionViewLayoutExample
//
//  Created by Naver on 2018. 8. 31..
//  Copyright © 2018년 CollectionViewLayout. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let types: [CollectionViewLayoutType] = [
        .centerZoom,
        .stairs,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let type = types[indexPath.row]
        cell?.textLabel?.text = type.rawValue
        return cell ?? UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = types[indexPath.row]
        let viewController = CollectionViewController.create()
        viewController.layoutType = type
        navigationController?.pushViewController(viewController, animated: true)
    }
}
