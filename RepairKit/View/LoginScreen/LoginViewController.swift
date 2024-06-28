//
//  ViewController.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 24.06.2024.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var spinner: CustomLoader = {
        let spinner = CustomLoader(squareLength: 50)
        return spinner
    }()
    private let backgroundImage = BackgroundImageView(image: .background)
    private let logoView: LogoView = {
        return LogoView(icon: .logoIcon, title: "RepairKit", style: .bigTitle)
    }()
    private let loginView = UIView()
    private let loginLabel = TitleLabel(text: String(localized: "authentication.login"), style: .title)
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
    private let logInButton = ActionButton(title: String(localized: "authentication.login"), style: .actionButton, action: UIAction { _ in })
    private let signUpButton = ActionButton(title: String(localized: "authentication.sign_up"), style: .infoButton, action: UIAction { _ in })
    private let dontHaveAccountLabel = TitleLabel(text: String(localized: "authentication.do_not_have_account"), style: .info)
    private let forgotPasswordButton = ActionButton(title: String(localized: "authentication.forgot_password"), style: .infoButton, action: UIAction { _ in })
    private let privacyPolicyLabel = TitleLabel(text: String(localized: "authentication.caption"), style: .caption)
    private let privacyPolicyButton = ActionButton(title: String(localized: "authentication.privacy"), style: .privacyPolicyButton, action: UIAction { _ in })
    private let andLabel = TitleLabel(text: String(localized: "authentication.and"), style: .caption)
    private let termsOfUseButton = ActionButton(title: String(localized: "authentication.terms"), style: .privacyPolicyButton, action: UIAction { _ in })
    private let emailErrorAlarm = TitleLabel(text: String(localized: "authentication.invalid_email"), style: .customSize)
    private let passwordErrorAlarm = TitleLabel(text: String(localized: "authentication.incorrect_password"), style: .customSize)
    
    private let logoStackView = UIStackView()
    private let textFieldsStackView = UIStackView()
    private let infoBottomStackView = UIStackView()
    private let captionBottomStackView = UIStackView()
    
    var viewModel: LoginViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: LoginViewModelProtocol) {
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

private extension LoginViewController {
    
    func setupUI() {
        setupSpinner()
        setupBackground()
        setupLogo()
        setupLoginView()
        setupLoginLabel()
        setupTextFields()
        setupEmailErrorLable()
        setupPasswordErrorLable()
        setupLoginButton()
        setupForgotPasswordButton()
        setupInfoBottomView()
        setupPrivacyPolicyLabel()
        setupBottomCaption()
    }
    
    // MARK: - Spinner
    
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
    
    // MARK: - Login View
    
    func setupLoginView() {
        view.addSubview(loginView)
        loginView.backgroundColor = .white
        loginView.layer.cornerRadius = .largeRadius
        loginView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        loginView.layer.masksToBounds = true
        loginView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Layout.loginViewHeight)
        }
    }
    
    // MARK: - Labels
    
    func setupLoginLabel() {
        loginView.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Float.xl)
            make.left.equalToSuperview().offset(Float.l)
        }
    }
    
    func setupTextFields() {
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = Float.l
        loginView.addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(Float.l)
            make.left.equalToSuperview().offset(Float.l)
            make.right.equalToSuperview().offset(-Float.l)
        }
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupEmailErrorLable() {
        loginView.addSubview(emailErrorAlarm)
        emailErrorAlarm.isHidden = true
        emailErrorAlarm.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Float.xs)
            make.left.equalToSuperview().offset(Float.l)
        }
    }
    
    func setupPasswordErrorLable() {
        loginView.addSubview(passwordErrorAlarm)
        passwordErrorAlarm.isHidden = true
        passwordErrorAlarm.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Float.xs)
            make.left.equalToSuperview().offset(Float.l)
        }
    }
    
    // MARK: - Login Button
    
    func setupLoginButton() {
        loginView.addSubview(logInButton)
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(Float.l)
            make.left.equalToSuperview().offset(Float.l)
            make.right.equalToSuperview().offset(-Float.l)
        }
        logInButton.addAction(UIAction { [self] _ in
            self.spinner.startAnimation(delay: 0.1, replicates: 10)
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.clearAllErrors()
            
            self.viewModel.login(nickname: emailTextField.text ?? "", password: passwordTextField.text ?? "")
            self.spinner.stopAnimation()
            UIApplication.shared.endIgnoringInteractionEvents()
        }, for: .touchUpInside)
    }
    
    // MARK: - Forgot Password Button
    
    func setupForgotPasswordButton() {
        loginView.addSubview(forgotPasswordButton)
        forgotPasswordButton.setTitle(String(localized: "authentication.forgot_password"), for: .normal)
        forgotPasswordButton.setTitleColor(.primaryGreen, for: .normal)
        forgotPasswordButton.titleLabel?.font = .poppinsRegular(.info)
        forgotPasswordButton.backgroundColor = .clear
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(Float.xs)
            make.right.equalTo(logInButton).offset(Float.s)
        }
        
        forgotPasswordButton.addAction(UIAction { _ in
            self.viewModel.forgotPasswordButtonPressed()
        }, for: .touchUpInside)
    }
    
    // MARK: - Info Bottom View
    
    func setupInfoBottomView() {
        infoBottomStackView.addArrangedSubview(dontHaveAccountLabel)
        infoBottomStackView.addArrangedSubview(signUpButton)
        infoBottomStackView.axis = .horizontal
        infoBottomStackView.spacing = Float.xs
        loginView.addSubview(infoBottomStackView)
        infoBottomStackView.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(Float.l)
            make.centerX.equalToSuperview()
        }
        
        signUpButton.addAction(UIAction { _ in
            self.viewModel.signUpButtonPressed()
        }, for: .touchUpInside)
    }
    
    // MARK: - Privacy Policy
    
    func setupPrivacyPolicyLabel() {
        loginView.addSubview(privacyPolicyLabel)
        privacyPolicyLabel.snp.makeConstraints { make in
            make.top.equalTo(dontHaveAccountLabel.snp.bottom).offset(Float.l)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Bottom Caption
    
    func setupBottomCaption() {
        captionBottomStackView.addArrangedSubview(privacyPolicyButton)
        captionBottomStackView.addArrangedSubview(andLabel)
        captionBottomStackView.addArrangedSubview(termsOfUseButton)
        captionBottomStackView.axis = .horizontal
        captionBottomStackView.spacing = Float.xs
        loginView.addSubview(captionBottomStackView)
        captionBottomStackView.snp.makeConstraints { make in
            make.top.equalTo(privacyPolicyLabel.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - ViewModel Observing
    
    func observeViewModel() {
        viewModel.chekError = { [weak self] error in
            DispatchQueue.main.async {
                switch error {
                case .invalidEmail:
                    self?.emailErrorAlarm.isHidden = false
                case .invalidPassword:
                    self?.passwordErrorAlarm.isHidden = false
                case .emailAlreadyExists:
                    self?.emailErrorAlarm.text = String(localized: "authentication.found_account")
                    self?.emailErrorAlarm.isHidden = false
                case .userNameNotFound:
                    return
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func clearAllErrors() {
        DispatchQueue.main.async { [weak self] in
            self?.emailErrorAlarm.isHidden = true
            self?.passwordErrorAlarm.isHidden = true
        }
    }
    
    // MARK: - Layout Constants
    
    enum Layout {
        static let textFieldHeight: Float = 50
        static let signUpViewHeight: Float = 500
        static let loginViewHeight: Float = 470
        static let logoTopOffset: Float = 160
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

