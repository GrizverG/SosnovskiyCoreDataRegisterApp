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
    
    // MARK: - Constants
    private enum Constant {
        static let buttonBackgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
        static let viewCornerRadius: CGFloat = 20
        static let viewSpacing = 30
        static let labelText = "Enter car name:"
        static let elementHeight = 50
        static let labelTextSize: CGFloat = 26
        static let buttonTextSize: CGFloat = 30
        static let elementCornerRadius: CGFloat = 25
        static let betweenButtonSpacing = 8
        static let elementSpacing = 17
        static let labelHeight = 25
        static let closeButtonText = "Close"
        static let addCarButtonText = "Add car"
        static let buttonFont = UIFont.boldSystemFont(ofSize: Constant.buttonTextSize)
        static let textContainerFont = UIFont.boldSystemFont(ofSize: Constant.labelTextSize)
    }
    
    // MARK: - Delegate
    weak var carDelegate: CarCreatingDelegate?
    
    //
    // MARK: - Car factory init
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
        hideButton.backgroundColor = Constant.buttonBackgroundColor
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
        bodyView.layer.cornerRadius = Constant.viewCornerRadius
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bodyView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bodyView.addToLeft(anchor: leadingAnchor, multiplier: Constant.viewSpacing)
        self.bodyView = bodyView
    }
    
    // MARK: - Setup car name label
    private func setupCarNameLabel() {
        let carNameLabel = UILabel()
        
        self.bodyView.addSubview(carNameLabel)
        carNameLabel.text = Constant.labelText
        carNameLabel.translatesAutoresizingMaskIntoConstraints = false
        carNameLabel.textColor = .white
        carNameLabel.font = Constant.textContainerFont
        carNameLabel.xAnchor(anchor: bodyView.centerXAnchor, multiplier: -Constant.elementSpacing)
        carNameLabel.addToLeft(anchor: bodyView.leadingAnchor, multiplier: Constant.elementSpacing)
        carNameLabel.addToTop(anchor: bodyView.topAnchor, multiplier: Constant.elementSpacing)
        carNameLabel.height(Constant.labelHeight)
        self.carNameLabel = carNameLabel
    }
    
    // MARK: - Setup car name text field
    private func setupCarNameTextField() {
        let carNameTextField = UITextField()
        
        self.bodyView.addSubview(carNameTextField)
        carNameTextField.delegate = self
        carNameTextField.borderStyle = .roundedRect
        carNameTextField.contentVerticalAlignment = .center
        carNameTextField.font = Constant.textContainerFont
        carNameTextField.returnKeyType = UIReturnKeyType.done
        carNameTextField.keyboardType = UIKeyboardType.default
        carNameTextField.autocorrectionType = UITextAutocorrectionType.no
        carNameTextField.translatesAutoresizingMaskIntoConstraints = false
        carNameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        carNameTextField.layer.cornerRadius = Constant.elementCornerRadius
        carNameTextField.clipsToBounds = true
        carNameTextField.height(Constant.elementHeight)
        carNameTextField.addToTop(anchor: carNameLabel.bottomAnchor, multiplier: Constant.elementSpacing)
        carNameTextField.addToLeft(anchor: bodyView.leadingAnchor, multiplier: Constant.elementSpacing)
        carNameTextField.addToRight(anchor: bodyView.trailingAnchor, multiplier: -Constant.elementSpacing)
        self.carNameTextField = carNameTextField
    }
    
    // MARK: - Setup close button
    private func setupCloseButton() {
        let closeButton = UIButton()
        
        addSubview(closeButton)
        closeButton.setTitle(Constant.closeButtonText, for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(hideViewAction), for: .touchUpInside)
        closeButton.backgroundColor = .orange
        closeButton.layer.cornerRadius = Constant.elementCornerRadius
        closeButton.clipsToBounds = true
        closeButton.titleLabel?.font = Constant.buttonFont
        closeButton.addToTop(anchor: self.carNameTextField.bottomAnchor, multiplier: Constant.elementSpacing)
        closeButton.addToBottom(anchor: bodyView.bottomAnchor, multiplier: -Constant.elementSpacing)
        closeButton.addToLeft(anchor: bodyView.leadingAnchor, multiplier: Constant.elementSpacing)
        closeButton.addToRight(anchor: bodyView.centerXAnchor, multiplier: -Constant.betweenButtonSpacing)
        closeButton.height(Constant.elementHeight)

        self.closeButton = closeButton
    }
    
    // MARK: - Setup addCar button
    private func setupAddCarButton() {
        let addCarButton = UIButton()
        
        bodyView.addSubview(addCarButton)
        addCarButton.setTitle(Constant.addCarButtonText, for: .normal)
        addCarButton.translatesAutoresizingMaskIntoConstraints = false
        addCarButton.addTarget(self, action: #selector(addCarAction), for: .touchUpInside)
        addCarButton.backgroundColor = .orange
        addCarButton.layer.cornerRadius = Constant.elementCornerRadius
        addCarButton.clipsToBounds = true
        addCarButton.titleLabel?.font = Constant.buttonFont
        addCarButton.translatesAutoresizingMaskIntoConstraints = false
        addCarButton.addToBottom(anchor: bodyView.bottomAnchor, multiplier: -Constant.elementSpacing)
        addCarButton.addToRight(anchor: bodyView.trailingAnchor, multiplier: -Constant.elementSpacing)
        addCarButton.addToLeft(anchor: bodyView.centerXAnchor, multiplier: Constant.betweenButtonSpacing)
        addCarButton.height(Constant.elementHeight)

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
