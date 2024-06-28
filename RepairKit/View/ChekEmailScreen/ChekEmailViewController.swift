//
//  ChekEmailViewController.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit

class ChekEmailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let backgroundImage = BackgroundImageView(image: .background)
    private let logoView: LogoView = {
        return LogoView(icon: .logoIcon, title: "RepairKit", style: .bigTitle)
    }()
    private let contentView = UIView()
    private let contentImage = UIImageView(image: .forgotPasswordEnvelope)
    private let checkEmaiLabel = TitleLabel(text: String(localized: "authentication.email_title"), style: .title)
    private let sentPassworLabel = TitleLabel(text: String(localized: "authentication.sent"), style: .info)
    private let gotItButton = ActionButton(title: String(localized: "authentication.got_it"), style: .actionButton)
    
    private let logoStackView = UIStackView()
    
    let viewModel: ChekEmailViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: ChekEmailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardLayout()
    }
}

// MARK: - Setup UI

private extension ChekEmailViewController {
    func setupUI() {
        setupBackground()
        setupLogo()
        setupContentView()
        setupContentImage()
        setupСheckEmaiLabel()
        setupSentPassworLabel()
        setupGotItButton()
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
    
    // MARK: - Content Image
    
    func setupContentImage() {
        contentView.addSubview(contentImage)
        contentImage.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(Float.l)
        }
    }
    
    // MARK: - Check Email Label
    
    func setupСheckEmaiLabel() {
        contentView.addSubview(checkEmaiLabel)
        checkEmaiLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentImage.snp.bottom).offset(Float.l)
        }
    }
    
    // MARK: - Sent Password Label
    
    func setupSentPassworLabel() {
        contentView.addSubview(sentPassworLabel)
        sentPassworLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Float.xl)
            make.centerX.equalTo(checkEmaiLabel)
            make.top.equalTo(checkEmaiLabel.snp.bottom).offset(Float.s)
        }
    }
    
    // MARK: - Got It Button
    
    func setupGotItButton() {
        contentView.addSubview(gotItButton)
        gotItButton.setTitleColor(.white, for: .normal)
        gotItButton.titleLabel?.font = .poppinsSemiBold(.body)
        gotItButton.backgroundColor = .primaryGreen
        gotItButton.layer.cornerRadius = .mediumRadius
        gotItButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Float.l)
            make.right.equalToSuperview().offset(-Float.l)
            make.top.equalTo(sentPassworLabel.snp.bottom).offset(Float.xl)
        }
        gotItButton.addAction(UIAction { [self] _ in
            // Handle button action
        }, for: .touchUpInside)
    }
    
    // MARK: - Layout Constants
    
    enum Layout {
        static let loginViewHeight: Float = 284
        static let logoTopOffset: Float = 160
    }
}

