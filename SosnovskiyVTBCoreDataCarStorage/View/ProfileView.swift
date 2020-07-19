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
@objc protocol CredentialControlDelegate: class {
    func passCredentials(_ credentials: [String])
    func passCar(_ name: String)
    func removeCredentials()
    func getCars() -> [Car]?
    func removeCar(car: Car)
}

// MARK: - Reload delegate
protocol ReloadViewDelegate: class {
    func resetView()
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

// MARK: - Profile view
final class ProfileView: UIView {
    
    //
    // MARK: - Constants
    private let labetlTitleArray = ["First name:",
                                    "Last name:",
                                    "Login:",
                                    "Password:"]
    private let textFieldTitleArray = ["Your first name here",
                                       "Your last name here",
                                       "Your login here",
                                       "Your password here"]
    private enum ButtonNames {
        static let signIn = "Sign in"
        static let signOut = "Sign out"
        static let addCar = "Add a car"
        static let showCars = "Show Cars"
    }
    
    private enum Constant {
        static let spacing = 50
        static let labelHeight = 30
        static let fieldHeight = 50
        static let buttonHeight = 70
        static let distance = 20
        static let textContainerFont = UIFont.boldSystemFont(ofSize: 22)
        static let buttonFont = UIFont.boldSystemFont(ofSize: 35)
        static let buttonCornerRadius: CGFloat = 35
        static let textColor: UIColor = .white
    }
    
    private enum Selectors {
        static let addCar = #selector(AddCarrAction)
        static let signOut = #selector(signOutAction)
        static let signIn = #selector(signInAction)
        static let showCars = #selector(showCarAction)
    }
    
    // MARK: Delegate
    weak var credentialsDelegate: CredentialControlDelegate?
    weak var reloadDelegate: ReloadViewDelegate?
    private weak var carFactory: CarFactoryView!
    
    // MARK: - Properties
    private var labelArray: [UILabel] = []
    private var textFieldArray: [UITextField] = []
    private var buttonArray: [UIButton] = []
    private var buttonStackView = UIStackView(frame: .zero)
    private var textStackView = UIStackView(frame: .zero)

    // MARK: - Registration view init
    init() {
        super.init(frame: .zero)
        backgroundColor = .darkGray
        prepareButtonStackView()
        prepareTextStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(_ person: Person?) {
        prepareView()
        if let person = person {
            let credentials = [person.firstName,
                               person.lastName,
                               person.login,
                               person.password]
            for i in 0...3 {
                createLabel(text: "\(labetlTitleArray[i]) \(credentials[i]!)")
            }
            createButton(action: Selectors.addCar, name: ButtonNames.addCar)
            createButton(action: Selectors.showCars, name:ButtonNames.showCars)
            createButton(action: Selectors.signOut, name:ButtonNames.signOut)
        } else {
            for i in 0...3 {
                createLabel(text: labetlTitleArray[i])
                createTextField(placeholder: textFieldTitleArray[i])
            }
            createButton(action: Selectors.signIn, name: ButtonNames.signIn)
        }
    }
    
    // MARK: - Prepare view
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
    }
    
    // MARK: - Prepare button stack view
    private func prepareButtonStackView() {
        addSubview(buttonStackView)
        buttonStackView.axis = NSLayoutConstraint.Axis.vertical
        buttonStackView.distribution  = UIStackView.Distribution.equalSpacing
        buttonStackView.alignment = UIStackView.Alignment.center
        buttonStackView.spacing = CGFloat(Constant.distance)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addToBottom(anchor: bottomAnchor, multiplier: -Constant.distance)
        buttonStackView.addToLeft(anchor: leadingAnchor, multiplier: Constant.spacing)
        buttonStackView.addToRight(anchor: trailingAnchor, multiplier: -Constant.spacing)
        buttonStackView.backgroundColor = .black
    }
    
    // MARK: - Prepare text stack view
    private func prepareTextStackView() {
        addSubview(textStackView)
        textStackView.axis = NSLayoutConstraint.Axis.vertical
        textStackView.distribution  = UIStackView.Distribution.equalSpacing
        textStackView.alignment = UIStackView.Alignment.center
        textStackView.spacing = CGFloat(Constant.distance)/2
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addToTop(anchor: safeAreaLayoutGuide.topAnchor, multiplier: Constant.distance)
        textStackView.addToLeft(anchor: leadingAnchor, multiplier: Constant.spacing)
        textStackView.addToRight(anchor: trailingAnchor, multiplier: -Constant.spacing)
        textStackView.backgroundColor = .black
    }
    
    // MARK: - Label creation
    private func createLabel(text: String) {
        let label = UILabel()
        
        addSubview(label)
        label.text = text
        label.textColor = Constant.textColor
        label.font = Constant.textContainerFont
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.addToLeft(anchor: leadingAnchor, multiplier: Constant.spacing)
        label.addToRight(anchor: trailingAnchor, multiplier: -Constant.spacing)
        label.height(Constant.labelHeight)
        textStackView.addArrangedSubview(label)
        labelArray.append(label)
    }
    
    // MARK: - Text field creation
    private func createTextField(placeholder: String) {
        let textField = UITextField()
        
        addSubview(textField)
        textField.delegate = self
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.contentVerticalAlignment = .center
        textField.font = Constant.textContainerFont
        textField.returnKeyType = UIReturnKeyType.done
        textField.keyboardType = UIKeyboardType.default
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.height(Constant.fieldHeight)
        textField.addToLeft(anchor: leadingAnchor, multiplier: Constant.spacing)
        textField.addToRight(anchor: trailingAnchor, multiplier: -Constant.spacing)
        textStackView.addArrangedSubview(textField)
        textFieldArray.append(textField)
    }
    
    // MARK: - Button creation
    private func createButton(action: Selector, name: String) {
        let button = UIButton()
        
        addSubview(button)
        button.setTitle(name, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = Constant.buttonCornerRadius
        button.clipsToBounds = true
        button.titleLabel?.font = Constant.buttonFont
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        button.height(Constant.buttonHeight)
        button.addToLeft(anchor: buttonStackView.leadingAnchor, multiplier: 0)
        buttonStackView.addArrangedSubview(button)
        buttonArray.append(button)
    }
    
    // MARK: Sign in selector
    @objc private func signInAction() {
        if let firstName = textFieldArray[0].text, let lastName = textFieldArray[1].text,
            let login = textFieldArray[2].text, let password = textFieldArray[3].text {
            if !firstName.isEmpty && !lastName.isEmpty && !login.isEmpty && !password.isEmpty {
                credentialsDelegate?.passCredentials([firstName, lastName, login, password])
                reloadDelegate?.resetView()
            }
        }
    }
    
    // MARK: - Sign out selector
    @objc private func signOutAction() {
        credentialsDelegate?.removeCredentials()
        reloadDelegate?.resetView()
    }
    
    // MARK: - Add car selector
    @objc private func AddCarrAction() {
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
    
    //MARK: - Show cars selector
    @objc private func showCarAction() {
        let carTable = carTableViewController()
        carTable.carDelegate = self.credentialsDelegate as? CarDelegate
        carTable.configure()
        reloadDelegate!.present(carTable, animated: true, completion: nil)
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

