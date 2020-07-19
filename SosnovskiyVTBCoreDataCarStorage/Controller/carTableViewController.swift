//
//  carTableViewController.swift
//  SosnovskiyVTBCoreDataCarStorage
//
//  Created by Gregory Pinetree on 19.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Car delegate
@objc protocol CarDelegate: CredentialControlDelegate {
    func getCars() -> [Car]?
    func removeCar(car: Car)
}

// MARK: - Car table view controller
final class carTableViewController: UITableViewController {
    
    //
    // MARK: - Properties
    private var carArray: [Car] = []
    
    // MARK: - Delegate
    var carDelegate: CarDelegate?
    
    //
    // MARK: - CartableViewController init
    init() {
        super.init(style: .plain)
        tableView.separatorColor = .orange
        tableView.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure() {
        if let delegate = carDelegate {
            carArray = delegate.getCars()!
        }
    }
    
    // MARK: - Cell amount
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carArray.count
    }
    
    // MARK: - Cell creation
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = carArray[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return cell
    }
    
    // MARK: - Can edit row at
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - Delete cell (Killer feature!!)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            carDelegate?.removeCar(car: carArray[indexPath.row])
            carArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
