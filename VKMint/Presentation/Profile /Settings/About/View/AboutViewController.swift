//
//  AboutViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 16.05.2022.
//

import UIKit

protocol AboutViewInput: AnyObject {
}

protocol AboutViewOutput: AnyObject {
    func viewWantsToClose()
}

class AboutViewController: UIViewController {

    // MARK: - Properties
    private let interItemSpacing = CGFloat(10)
    var presenter: AboutPresenter!

    // MARK: - UI
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private lazy var firstLine: StackVerticalSpacingView = {
        let line = StackVerticalSpacingView(size: 1, color: .systemGray6)
        return line
    }()
    private lazy var secondLine: StackVerticalSpacingView = {
        let line = StackVerticalSpacingView(size: 1, color: .systemGray6)
        return line
    }()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "VK_Logo"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray
        label.text = "Version 1.0.0"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstLine,
            logoImage,
            versionLabel,
            secondLine
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = interItemSpacing
        return stackView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "This application was developed by a team of 2 people for a design and technological internship."
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    // MARK: - View life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        title = "About the application"
        view.backgroundColor = .systemBackground
        setUpView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewWantsToClose()
    }

    // MARK: - Configure UI
    private func setUpView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(view)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        firstLine.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        secondLine.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }

        logoImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
        }

        scrollView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - AboutViewInput
extension AboutViewController: AboutViewInput {
}
