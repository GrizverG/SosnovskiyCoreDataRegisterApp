//
//  CarFactoryView.swift
//  SosnovskiyVTBCoreDataCarStorage
//
//  Created by Gregory Pinetree on 14.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit

// MARK: - Car creating delegate
protocol CarCreatingDelegate: CredentialControlDelegate {
    func passCar(carName: String)
}
// MARK: - Car factory view
final class CarFactoryView: UIView {
    
    //
    // MARK: - Properties
    private weak var carNameLabel: UILabel!
    private weak var carNameTextField: UITextField!
    private weak var hideButton: UIButton!
    private weak var addCarButton: UIButton!
    private weak var bodyView: UIView!
    private weak var closeButton: UIView!
    
    // MARK: - Delegate
    weak var carDelegate: CarCreatingDelegate?
    
    //
    // MARK: - carFactoryInit
    init() {
        super.init(frame: .zero)
        setupHideButton()
        setupBodyView()
        setupCarNameLabel()
        setupCarNameTextField()
        setupCloseButton()
        setupAddCarButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("help")
    }
    
    // MARK: - Setup hide button
    private func setupHideButton() {
        let hideButton = UIButton()
        
        addSubview(hideButton)
        hideButton.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.addTarget(self, action: #selector(hideViewAction), for: .touchUpInside)
        
        hideButton.pin(superView: self)
        self.hideButton = hideButton
    }
    
    // MARK: - Setup body view
    private func setupBodyView() {
        let bodyView = UIView()
        
        addSubview(bodyView)
        bodyView.backgroundColor = .gray
        bodyView.clipsToBounds = true
        bodyView.layer.cornerRadius = 20
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bodyView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bodyView.addToLeft(anchor: self.leadingAnchor, multiplier: 30)
        self.bodyView = bodyView
    }
    
    // MARK: - Setup car name label
    private func setupCarNameLabel() {
        let carNameLabel = UILabel()
        
        self.bodyView.addSubview(carNameLabel)
        carNameLabel.text = "Enter car name:"
        carNameLabel.translatesAutoresizingMaskIntoConstraints = false
        carNameLabel.textColor = .white
        carNameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        carNameLabel.xAnchor(anchor: self.bodyView.centerXAnchor, multiplier: -15)
        carNameLabel.addToLeft(anchor: self.bodyView.leadingAnchor, multiplier: 15)
        carNameLabel.addToTop(anchor: self.bodyView.topAnchor, multiplier: 15)
        carNameLabel.height(25)
        self.carNameLabel = carNameLabel
    }
    
    // MARK: - Setup car name text field
    private func setupCarNameTextField() {
        let carNameTextField = UITextField()
        
        self.bodyView.addSubview(carNameTextField)
        carNameTextField.delegate = self
        carNameTextField.borderStyle = .roundedRect
        carNameTextField.contentVerticalAlignment = .center
        carNameTextField.font = UIFont.systemFont(ofSize: 15)
        carNameTextField.returnKeyType = UIReturnKeyType.done
        carNameTextField.keyboardType = UIKeyboardType.default
        carNameTextField.autocorrectionType = UITextAutocorrectionType.no
        carNameTextField.translatesAutoresizingMaskIntoConstraints = false
        carNameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        carNameTextField.layer.cornerRadius = 25
        carNameTextField.clipsToBounds = true
        carNameTextField.height(50)
        carNameTextField.addToTop(anchor: self.carNameLabel.bottomAnchor, multiplier: 17)
        carNameTextField.addToLeft(anchor: self.bodyView.leadingAnchor, multiplier: 15)
        carNameTextField.addToRight(anchor: self.bodyView.trailingAnchor, multiplier: -15)
        self.carNameTextField = carNameTextField
    }
    
    // MARK: - Setup close button
    private func setupCloseButton() {
        let closeButton = UIButton()
        
        addSubview(closeButton)
        closeButton.setTitle("Close", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(hideViewAction), for: .touchUpInside)
        closeButton.backgroundColor = .orange
        closeButton.layer.cornerRadius = 25
        closeButton.clipsToBounds = true
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        closeButton.addToTop(anchor: self.carNameTextField.bottomAnchor, multiplier: 17)
        closeButton.addToBottom(anchor: self.bodyView.bottomAnchor, multiplier: -17)
        closeButton.addToLeft(anchor: self.bodyView.leadingAnchor, multiplier: 17)
        closeButton.addToRight(anchor: self.bodyView.centerXAnchor, multiplier: -8)
        closeButton.height(50)

        self.closeButton = closeButton
    }
    
    // MARK: - Setup addCar button
    private func setupAddCarButton() {
        let addCarButton = UIButton()
        
        self.bodyView.addSubview(addCarButton)
        addCarButton.setTitle("Add car", for: .normal)
        addCarButton.translatesAutoresizingMaskIntoConstraints = false
        addCarButton.addTarget(self, action: #selector(addCarAction), for: .touchUpInside)
        addCarButton.backgroundColor = .orange
        addCarButton.layer.cornerRadius = 25
        addCarButton.clipsToBounds = true
        addCarButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        addCarButton.translatesAutoresizingMaskIntoConstraints = false
        addCarButton.addToBottom(anchor: self.bodyView.bottomAnchor, multiplier: -17)
        addCarButton.addToRight(anchor: self.bodyView.trailingAnchor, multiplier: -17)
        addCarButton.leadingAnchor.constraint(equalTo: self.bodyView.centerXAnchor, constant: 8).isActive = true
        addCarButton.height(50)

        self.addCarButton = addCarButton
    }
    
    // MARK: - Hide view action
    @objc private func hideViewAction() {
        self.hideOrShow(nil)
    }
    
    // MARK: - Add car action
    @objc private func addCarAction() {
        if let carName = carNameTextField.text {
            if !carName.isEmpty {
                carDelegate?.passCar(carName: carName)
                self.hideOrShow(nil)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension CarFactoryView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}
