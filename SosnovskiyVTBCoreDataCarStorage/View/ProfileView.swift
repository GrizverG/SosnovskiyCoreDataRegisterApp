//
//  ProfileView.swift
//  SosnovskiyVTBCoreDataCarStorage
//
//  Created by Gregory Pinetree on 14.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Save credentials delegate
protocol CredentialControlDelegate: class {
    func passCredentials(_ credentials: [String])
    func passCar(_ name: String)
    func removeCredentials()
}

// MARK: - Reload delegate
protocol ReloadViewDelegate: class {
    func resetView()
}

// MARK: - Profile view
final class ProfileView: UIView {
    
    //
    // MARK: - Constants
    private let labetlTitleArray = ["First name:",
                                    "Last name:",
                                    "Login:",
                                    "Password"]
    private let textFieldTitleArray = ["Your first name here",
                                       "Your last name here",
                                       "Your login here",
                                       "Your password here"]
    private enum ButtonNames {
        static let signIn = "Sign in"
        static let signOut = "Sign out"
        static let AddCar = "Add a car"
    }
    
    private enum Constants {
        static let surraunding = 50
        static let fieldHeight = 50
        static let distance = 50
        static let buttonHeight = 70
    }
    
    // MARK: Delegate
    weak var credentialsDelegate: CredentialControlDelegate?
    weak var reloadDelegate: ReloadViewDelegate?
    private weak var carFactory: CarFactoryView!
    
    // MARK: - Properties
    private var labelArray: [UILabel] = []
    private var textFieldArray: [UITextField] = []
    private var buttonArray: [UIButton] = []
    
    private var numberOfElements = 0
    private var Distance: Int {
        numberOfElements += 1
        return Constants.distance * numberOfElements
    }
    
    private var buttonDistance = -Constants.buttonHeight
    private var ButtonDistance: Int {
        buttonDistance += Constants.buttonHeight + 20
        return buttonDistance
    }
    
    // MARK: - Registration view init
    init() {
        super.init(frame: .zero)
        backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(_ credentials: [String]?) {
        prepareView()
        if let credentials = credentials {
            for i in 0...3 {
                labelArray.append(createLabel())
                labelArray[i].text = credentials[i]
            }
            buttonArray.append(createButton(action: #selector(signOut)))
            buttonArray.append(createButton(action: #selector(AddCarrAction)))
            buttonArray[0].setTitle(ButtonNames.signOut, for: .normal)
            buttonArray[1].setTitle(ButtonNames.AddCar, for: .normal)
        } else {
            for i in 0...3 {
                labelArray.append(createLabel())
                textFieldArray.append(createTextField())
                
                labelArray[i].text = labetlTitleArray[i]
                textFieldArray[i].placeholder = textFieldTitleArray[i]
            }
            let finishRegistrationButton = createButton(action: #selector(signIn))
            finishRegistrationButton.setTitle(ButtonNames.signIn, for: .normal)
            buttonArray.append(finishRegistrationButton)
        }
    }
    
    // MARK: - Prepare registration view
    private func prepareView() {
        for element in labelArray {
            element.removeFromSuperview()
        }
        for element in textFieldArray {
            element.removeFromSuperview()
        }
        for element in buttonArray {
            element.removeFromSuperview()
        }
        labelArray = []
        textFieldArray = []
        buttonArray = []
        numberOfElements = 0
        buttonDistance = -Constants.buttonHeight
    }
    
    // MARK: - Label creation
    private func createLabel() -> UILabel {
        let label = UILabel()
        
        addSubview(label)
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.addToTop(anchor: topAnchor, multiplier: Distance)
        label.addToLeft(anchor: leadingAnchor, multiplier: Constants.surraunding)
        label.addToRight(anchor: trailingAnchor, multiplier: -Constants.surraunding)
        label.height(Constants.fieldHeight)
        return label
    }
    
    // MARK: - Text field creation
    private func createTextField() -> UITextField {
        let textField = UITextField()
        
        addSubview(textField)
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.contentVerticalAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.returnKeyType = UIReturnKeyType.done
        textField.keyboardType = UIKeyboardType.default
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.height(Constants.fieldHeight)
        textField.addToTop(anchor: topAnchor, multiplier: Distance)
        textField.addToLeft(anchor: leadingAnchor, multiplier: Constants.surraunding)
        textField.addToRight(anchor: trailingAnchor, multiplier: -Constants.surraunding)
        return textField
    }
    
    // MARK: - Button creation
    private func createButton(action: Selector) -> UIButton {
        let button = UIButton()
        
        addSubview(button)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 35
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        
        button.addToBottom(anchor: bottomAnchor, multiplier: -ButtonDistance)
        button.addToLeft(anchor: leadingAnchor, multiplier: Constants.surraunding)
        button.addToRight(anchor: trailingAnchor, multiplier: -Constants.surraunding)
        button.height(Constants.buttonHeight)
        return button
    }
    
    // MARK: Sign in selector
    @objc private func signIn(sender: UIButton!) {
        if let firstName = textFieldArray[0].text, let lastName = textFieldArray[1].text,
            let login = textFieldArray[2].text, let password = textFieldArray[3].text {
            if !firstName.isEmpty && !lastName.isEmpty && !login.isEmpty && !password.isEmpty {
                credentialsDelegate?.passCredentials([firstName, lastName, login, password])
                reloadDelegate?.resetView()
            }
        }
    }
    
    // MARK: - Sign out selector
    @objc private func signOut(sender: UIButton!) {
        credentialsDelegate?.removeCredentials()
        reloadDelegate?.resetView()
    }
    
    // MARK: - Add car selector
    @objc private func AddCarrAction(sender: UIButton!) {
        if carFactory != nil {
            carFactory.hideOrShow(nil)
        } else {
            let carFactory = CarFactoryView()
            carFactory.isHidden = true
            addSubview(carFactory)
            carFactory.hideOrShow(nil)
            carFactory.pin(superView: self)
            carFactory.carDelegate = self.credentialsDelegate as? CarCreatingDelegate
            self.carFactory = carFactory
        }
    }
    
    // MARK: - Touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension ProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}

