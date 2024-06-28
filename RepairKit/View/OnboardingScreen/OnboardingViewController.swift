//
//  OnboardingViewController.swift
//  RepairKit
//
//  Created by Pavel Shabliy on 28.06.2024.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    private let backgroundImage = BackgroundImageView(image: .onboardingBackground)
    private let imageView = IconImageView(image: .onboardingWelcome)
    private let informationView = UIView()
    private let titleLabel = TitleLabel(text: "", style: .headline)
    private let textLabel = TitleLabel(text: "", style: .info.update(textColor: .additionalGray))
    private let pageControl = UIPageControl()
    private let actionButton = ActionButton(title: String(localized: "onboarding.next"), style: .actionButton, action: UIAction { _ in })
    
    var viewModel: OnboardingViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: OnboardingViewModelProtocol) {
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
    }
    
}

// MARK: - Setup UI

private extension OnboardingViewController {
    func setupUI() {
        setupBackground()
        setupInformationView()
        setupImageView()
        setupTitleLabel()
        setupTextLabel()
        setupPageControl()
        setupActionButton()
    }
    
    // MARK: - Background
    
    func setupBackground() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Image Views
    
    func setupImageView() {
        view.insertSubview(imageView, belowSubview: informationView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(37)
            make.right.equalToSuperview().offset(-37)
            make.top.equalToSuperview().offset(90)
        }
    }
    
    func setupInformationView() {
        view.addSubview(informationView)
        informationView.backgroundColor = .white
        informationView.layer.cornerRadius = .largeRadius
        informationView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        informationView.layer.masksToBounds = true
        informationView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(Layout.informationViewHeight)
        }
    }
    
    // MARK: - Labels
    
    func setupTitleLabel() {
        informationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Float.xl)
            make.centerX.equalToSuperview()
            make.left.equalTo(Float.l)
            make.right.equalTo(-Float.l)
        }
    }
    
    func setupTextLabel() {
        informationView.addSubview(textLabel)
        informationView.addSubview(actionButton)
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Float.l)
            make.left.equalTo(Float.l)
            make.right.equalTo(-Float.l)
            make.bottom.greaterThanOrEqualTo(actionButton.snp.top).offset(-Float.l)
        }
    }
    
    // MARK: - Page Control
    
    func setupPageControl() {
        informationView.addSubview(pageControl)
        pageControl.numberOfPages = viewModel.maxNumberOfPages
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(-Float.xxl)
            make.left.equalTo(Float.l)
        }
    }
    
    // MARK: - Action Button
    
    func setupActionButton() {
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = .poppinsSemiBold(.body)
        actionButton.backgroundColor = .primaryGreen
        actionButton.layer.cornerRadius = .mediumRadius
        actionButton.snp.makeConstraints { make in
            make.centerY.equalTo(pageControl)
            make.width.equalTo(Layout.actionButtonWidth)
            make.right.equalTo(-Float.xl)
        }
        
        actionButton.addAction(UIAction { [weak self] _ in
            self?.viewModel.actionButtonPressed()
        }, for: .touchUpInside)
    }
    
    // MARK: - UI Updates
    
    func observeViewModel() {
        viewModel.upateScreen = { screen in
            self.titleLabel.text = screen.title
            self.textLabel.text = screen.text
            self.imageView.image = screen.image
            self.pageControl.currentPage = screen.rawValue
            
            let buttonTittle = screen.isLast ? String(localized: "onboarding.done") : String(localized: "onboarding.next")
            self.actionButton.setTitle(buttonTittle, for: .normal)
        }
        
        viewModel.setupFirstScreen()
    }
    
    // MARK: - Layout Constants
    
    enum Layout {
        static let informationViewHeight: Float = 300
        static let actionButtonWidth: Float = 104
        static let horizontalSpacing: Float = 100
    }
}

