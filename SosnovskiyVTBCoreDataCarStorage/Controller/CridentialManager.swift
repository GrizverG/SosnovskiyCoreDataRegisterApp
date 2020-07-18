//
//  CridentialManager.swift
//  SosnovskiyVTBCoreDataCarStorage
//
//  Created by Gregory Pinetree on 14.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import Foundation

final class CredentialManager {
    
    private var _hasProfile = false
    private enum Keys {
        static let userKey = "currentAppUser"
    }
    
    func getCredentials() -> [String] {
        return ["1", "2", "3", "4"]
    }
    
    func hasProfile() -> Bool {
        return true//_hasProfile
    }
    
    private func AddCar() {
        
    }
    
    private func createUser(_ credentials: [String]) {
        
    }
}

// MARK: - Credential saving delegate
extension CredentialManager: CredentialControlDelegate {
    func passCar(_ name: String) {
        AddCar()
    }
    
    func passCredentials(_ credentials: [String]) {
        createUser(credentials)
        _hasProfile = !_hasProfile
    }
    
    func removeCredentials() {
        _hasProfile = !_hasProfile
    }
}

