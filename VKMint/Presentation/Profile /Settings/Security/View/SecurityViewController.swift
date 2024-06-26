//
//  SecurityViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 24.05.2022.
//

import UIKit
import SmileLock

protocol SecurityViewInput: AnyObject {
}

protocol SecurityViewOutput: AnyObject {
    func openLockScreen()
    func viewWantsToClose()
    func isExist() -> Bool
}

class SecurityViewController: UIViewController {

    // MARK: - Properties
    var presenter: SecurityPresenter!
    private let interItemSpacing = CGFloat(20)
    private var flag = false

    // MARK: - UI
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private lazy var addPasswordButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(nil, action: #selector(touchItem), for: .touchUpInside)
        button.setTitle("Add Pin-Code", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitleColor(UIColor.gray, for: .disabled)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            StackVerticalSpacingView(size: 30, color: .clear),
            addPasswordButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = interItemSpacing
        return stackView
    }()

    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(touchBackButton))
        return button
    }()

    // MARK: - View life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        title = "Security"
        navigationController?.navigationItem.setLeftBarButton(backButton, animated: true)
        view.backgroundColor = .systemBackground
        flag = presenter.isExist()
        setUpUI()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewWantsToClose()
    }

    // MARK: - Configure UI
    private func setUpUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        addPasswordButton.isEnabled = !flag

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(view)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

    // MARK: - Actions
    @objc
    private func touchItem() {
        presenter.openLockScreen()
    }

    @objc
    private func touchBackButton() {
        dismiss(animated: true)
    }
}

// MARK: - SecurityViewInput
extension SecurityViewController: SecurityViewInput {
}
