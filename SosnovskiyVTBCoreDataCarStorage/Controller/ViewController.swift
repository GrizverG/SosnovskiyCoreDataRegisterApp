//
//  ViewController.swift
//  SosnovskiyVTBCoreDataCarStorage
//
//  Created by Gregory Pinetree on 14.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    private var credentialManager = CoreDataManager()
    private var profileView = ProfileView()
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.reloadDelegate = self
        profileView.credentialsDelegate = credentialManager
        view.addSubview(profileView)
        profileView.pin(superView: view)
        resetView()
    }
}

// MARK: - Reload view delegate
extension ViewController: ReloadViewDelegate {
    func resetView() {
        if credentialManager.hasProfile() {
            profileView.configure(credentialManager.getPerson())
        } else {
            profileView.configure(nil)
        }
    }
}

