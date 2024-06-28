//
//  SignUpViewController.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var spinner: CustomLoader = {
        let spinner = CustomLoader(squareLength: 50)
        return spinner
    }()
    private let backgroundImage = BackgroundImageView(image: .background)
    private let logoView: LogoView = {
        return LogoView(icon: .logoIcon, title: "RepairKit", style: .bigTitle)
    }()
    private let signUpView = UIView()
    private let signUpLabel = TitleLabel(text: String(localized: "authentication.sign_up"), style: .title)
    private let usernameTextField = CustomTextField(
        placeholder: String(localized: "authentication.username"),
        height: Layout.textFieldHeight,
        textContentType: .nickname
    )
    private let emailTextField = CustomTextField(
        placeholder: String(localized: "authentication.email"),
        height: Layout.textFieldHeight,
        textContentType: .emailAddress
    )
    private let passwordTextField = CustomTextField(
        placeholder: String(localized: "authentication.password"),
        height: Layout.textFieldHeight,
        textContentType: .password,
        isSecureTextEntry: true
    )
    private let signUpButton = ActionButton(title: String(localized: "authentication.sign_up"), style: .actionButton, action: UIAction { _ in })
    private let alreadyHaveAccountLabel = TitleLabel(text: String(localized: "authentication.already_have_account"), style: .info)
    private let logInButton = ActionButton(title: String(localized: "authentication.login"), style: .infoButton, action: UIAction { _ in })
    private let privacyPolicyLabel = TitleLabel(text: String(localized: "authentication.caption"), style: .caption)
    private let privacyPolicyButton = ActionButton(title: String(localized: "authentication.privacy"), style: .privacyPolicyButton, action: UIAction { _ in })
    private let andLabel = TitleLabel(text: String(localized: "authentication.and"), style: .caption)
    private let termsOfUseButton = ActionButton(title: String(localized: "authentication.terms"), style: .privacyPolicyButton, action: UIAction { _ in })
    private let usernameErrorAlarm = TitleLabel(text: String(localized: "authentication.already_taken"), style: .customSize)
    private let emailErrorAlarm = TitleLabel(text: String(localized: "authentication.invalid_email"), style: .customSize)
    private let passwordErrorAlarm = TitleLabel(text: String(localized: "authentication.password_contain"), style: .customSize)
    
    private let logoStackView = UIStackView()
    private let textFieldsStackView = UIStackView()
    private let infoBottomStackView = UIStackView()
    private let captionBottomStackView = UIStackView()
    
    var viewModel: SignUpViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: SignUpViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observeViewModel()
        setupKeyboardLayout()
    }
}

// MARK: - UI Setup

private extension SignUpViewController {
    func setupUI() {
        setupSpinner()
        setupBackground()
        setupLogo()
        setupSignUpView()
        setupSignUpLabel()
        setupTextFields()
        setupUsernameError()
        setupEmailErrorLabel()
        setupPasswordErrorLabel()
        setupSignUpButton()
        setupInfoBottomView()
        setupPrivacyPolicyLabel()
        setupBottomCaption()
    }
    
    // MARK: - Loader
    
    func setupSpinner() {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        keyWindow.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalTo(keyWindow)
            make.width.height.equalTo(100)
        }
    }
    
    // MARK: - Background
    
    func setupBackground() {
        view.backgroundColor = .primaryGreen
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Logo
    
    func setupLogo() {
        view.addSubview(logoStackView)
        logoStackView.addArrangedSubview(logoView)
        logoStackView.axis = .horizontal
        logoStackView.spacing = Float.m
        logoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Layout.logoTopOffset)
        }
    }
    
    // MARK: - SignUp View
    
    func setupSignUpView() {
        view.addSubview(signUpView)
        signUpView.backgroundColor = .white
        signUpView.layer.cornerRadius = .largeRadius
        signUpView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        signUpView.layer.masksToBounds = true
        signUpView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Layout.signUpViewHeight)
        }
    }
    
    // MARK: - Labels
    
    func setupSignUpLabel() {
        signUpView.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Float.xl)
            make.left.equalToSuperview().offset(Float.l)
        }
    }
    
    func setupTextFields() {
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = Float.l
        signUpView.addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(Float.l)
            make.left.equalToSuperview().offset(Float.l)
            make.right.equalToSuperview().offset(-Float.l)
        }
        textFieldsStackView.addArrangedSubview(usernameTextField)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupUsernameError() {
        signUpView.addSubview(usernameErrorAlarm)
        usernameErrorAlarm.isHidden = true
        usernameErrorAlarm.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(Float.xs)
            make.left.equalToSuperview().offset(Float.l)
        }
    }
    
    func setupEmailErrorLabel() {
        signUpView.addSubview(emailErrorAlarm)
        emailErrorAlarm.isHidden = true
        emailErrorAlarm.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Float.xs)
            make.left.equalToSuperview().offset(Float.l)
        }
    }
    
    func setupPasswordErrorLabel() {
        signUpView.addSubview(passwordErrorAlarm)
        passwordErrorAlarm.isHidden = true
        passwordErrorAlarm.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Float.xs)
            make.left.equalToSuperview().offset(Float.l)
        }
    }
    
    // MARK: - Buttons
    
    func setupSignUpButton() {
        signUpView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(Float.l)
            make.left.equalToSuperview().offset(Float.l)
            make.right.equalToSuperview().offset(-Float.l)
        }
        signUpButton.addAction(UIAction { [weak self] _ in
            self?.spinner.startAnimation(delay: 0.1, replicates: 10)
            UIApplication.shared.beginIgnoringInteractionEvents()
            self?.clearAllErrors()
            
            let account = Account(
                nickName: self?.usernameTextField.text ?? "",
                password: self?.passwordTextField.text ?? "",
                mail: self?.emailTextField.text ?? ""
            )
            
            self?.viewModel.signUp(account: account) {
                self?.spinner.stopAnimation()
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }, for: .touchUpInside)
    }
    
    func setupInfoBottomView() {
        infoBottomStackView.addArrangedSubview(alreadyHaveAccountLabel)
        infoBottomStackView.addArrangedSubview(logInButton)
        infoBottomStackView.axis = .horizontal
        infoBottomStackView.spacing = Float.xs
        
        signUpView.addSubview(infoBottomStackView)
        infoBottomStackView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(Float.l)
            make.centerX.equalToSuperview()
        }
        logInButton.addAction(UIAction { _ in
            self.viewModel.loginButtonPressed()
        } , for: .touchUpInside)
    }
    
    func setupPrivacyPolicyLabel() {
        signUpView.addSubview(privacyPolicyLabel)
        privacyPolicyLabel.snp.makeConstraints { make in
            make.top.equalTo(alreadyHaveAccountLabel.snp.bottom).offset(Float.l)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupBottomCaption() {
        captionBottomStackView.addArrangedSubview(privacyPolicyButton)
        captionBottomStackView.addArrangedSubview(andLabel)
        captionBottomStackView.addArrangedSubview(termsOfUseButton)
        captionBottomStackView.axis = .horizontal
        captionBottomStackView.spacing = Float.xs
        signUpView.addSubview(captionBottomStackView)
        captionBottomStackView.snp.makeConstraints { make in
            make.top.equalTo(privacyPolicyLabel.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - ViewModel Observing
    
    func observeViewModel() {
        viewModel.showError = { [weak self] error in
            
            DispatchQueue.main.async {
                switch error {
                case .invalidEmail:
                    self?.emailErrorAlarm.isHidden = false
                case .invalidPassword:
                    self?.passwordErrorAlarm.isHidden = false
                case .emailAlreadyExists:
                    self?.emailErrorAlarm.text = String(localized: "authentication.already_exist")
                    self?.emailErrorAlarm.isHidden = false
                case .userNameNotFound:
                    self?.usernameErrorAlarm.isHidden  = false
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func clearAllErrors() {
        DispatchQueue.main.async { [weak self] in
            self?.emailErrorAlarm.isHidden = true
            self?.passwordErrorAlarm.isHidden = true
            self?.usernameErrorAlarm.isHidden  = true
        }
    }
    // MARK: - Constants
    
    enum Layout {
        static let textFieldHeight: Float = 50
        static let signUpViewHeight: Float = 500
        static let logoTopOffset: Float = 160
    }
}

// MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

