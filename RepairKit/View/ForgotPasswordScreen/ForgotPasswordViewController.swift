//
//  ForgotPasswordViewController.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    private let backgroundImage = BackgroundImageView(image: .background)
    private let logoView: LogoView = {
        return LogoView(icon: .logoIcon, title: "RepairKit", style: .bigTitle)
    }()
    private let contentView = UIView()
    private let forgotPasswordLabel = TitleLabel(text: String(localized: "recovery.reset"), style: .title)
    private let emailTextField = CustomTextField(
        placeholder: String(localized: "authentication.email"),
        height: Layout.textFieldHeight,
        textContentType: .emailAddress
    )
    private let resetMyPasswordButton = ActionButton(title: String(localized: "recovery.reset"), style: .actionButton, action: UIAction { _ in })
    
    private let logoStackView = UIStackView()
    private let textFieldsStackView = UIStackView()
    
    var viewModel: ForgotPasswordViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: ForgotPasswordViewModelProtocol) {
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

private extension ForgotPasswordViewController {
    
    func setupUI() {
        setupBackground()
        setupLogo()
        setupContentView()
        setupForgotPasswordLabel()
        setupTextFields()
        setupResetMyPasswordButton()
        emailTextField.delegate = self
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
    
    // MARK: - Content View
    
    func setupContentView() {
        view.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = .largeRadius
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.masksToBounds = true
        contentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Layout.loginViewHeight)
        }
    }
    
    // MARK: - Labels
    
    func setupForgotPasswordLabel() {
        contentView.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Float.xl)
            make.left.equalToSuperview().offset(Float.l)
        }
    }
    
    // MARK: - Text Fields
    
    func setupTextFields() {
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = Float.l
        contentView.addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(Float.l)
            make.left.equalToSuperview().offset(Float.l)
            make.right.equalToSuperview().offset(-Float.l)
        }
    }
    
    // MARK: - Reset Button
    
    func setupResetMyPasswordButton() {
        contentView.addSubview(resetMyPasswordButton)
        resetMyPasswordButton.setTitleColor(.white, for: .normal)
        resetMyPasswordButton.titleLabel?.font = .poppinsSemiBold(.body)
        resetMyPasswordButton.backgroundColor = .primaryGreen.withAlphaComponent(0.6)
        resetMyPasswordButton.layer.cornerRadius = .mediumRadius
        resetMyPasswordButton.isEnabled = false
        resetMyPasswordButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Float.l)
            make.right.equalToSuperview().offset(-Float.l)
            make.bottom.equalToSuperview().offset(-Float.xl)
        }
        resetMyPasswordButton.addAction(UIAction { [self] _ in
            self.viewModel.resetPassword()
        }, for: .touchUpInside)
    }
    
    // MARK: - ViewModel Observing
    
    func observeViewModel() {
        viewModel.validateEmail = { [weak self] isValid in
            self?.resetMyPasswordButton.isEnabled = isValid
            self?.resetMyPasswordButton.backgroundColor = isValid ? .primaryGreen : .primaryGreen.withAlphaComponent(0.6)
        }
    }
    
    // MARK: - Layout Constants
    
    enum Layout {
        static let textFieldHeight: Float = 50
        static let loginViewHeight: Float = 380
        static let logoTopOffset: Float = 160
    }
}

// MARK: - UITextFieldDelegate

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            let currentText = (textField.text ?? "") as NSString
            let proposedText = currentText.replacingCharacters(in: range, with: string)
            viewModel.textFieldDidChange(text: proposedText)
        }
        return true
    }
}
