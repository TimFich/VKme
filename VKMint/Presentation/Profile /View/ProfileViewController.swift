//
//  ProfileViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 10.05.2022.
//

import Foundation
import UIKit

protocol ProfileViewOutput {
    func needToLoadData()
    func signOutPressed()
    func itemPressed(flag: Int)
}

protocol ProfileViewInput {
    func needToUpdateProfile(person: ProfileData)
}

class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: ProfilePresenter!
    
    //MARK: - UI
    private let interItemSpacing = CGFloat(10)
    
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var nickName: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var number: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    lazy var stackViewProfile: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                StackVerticalSpacingView(size: 30, color: .clear),
                avatar,
                fullNameLabel,
                nickName,
                number,
                StackVerticalSpacingView(size: 30, color: .clear)
            ]
        )
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray6
        stackView.alignment = .center
        stackView.spacing = interItemSpacing
        return stackView
    }()
    
    private lazy var stackViewSettings: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                StackVerticalSpacingView(size: 40, color: .clear),
                ProfileSettingsItemView(
                    title: "Appearance",
                    image: UIImage(systemName: "paintpalette")!,
                    output: self
                ),
                ProfileSettingsItemView(
                    title: "Security",
                    image: UIImage(systemName: "lock")!,
                    output: self),
                ProfileSettingsItemView(
                    title: "About the application",
                    image: UIImage(systemName: "exclamationmark.circle")!,
                    output: self
                ),
                StackVerticalSpacingView(
                    size: 1,
                    color: .lightGray
                )
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.contentHorizontalAlignment = .center
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(nil, action: #selector(didClickSigOutButton), for: .touchUpInside)
        return button
    }()

    //MARK: - View life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.needToLoadData()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Configure UI
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(stackViewProfile)
        stackViewProfile.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(view)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        avatar.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        number.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
        }
        
        scrollView.addSubview(stackViewSettings)
        stackViewSettings.snp.makeConstraints { make in
            make.top.equalTo(stackViewProfile.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        scrollView.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(stackViewSettings.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    private func updateProfile(person: ProfileData) {
        avatar.image = person.photo
        fullNameLabel.text = person.firstName + " " + person.lastName
        nickName.text = "@" + person.nickname!
        number.text = person.number
    }
    
    //MARK: - Action
    @objc
    func didClickSigOutButton() {
        presenter.signOutPressed()
    }
}

//MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {
    func needToUpdateProfile(person: ProfileData) {
        updateProfile(person: person)
    }
}

//MARK: - ProfileSettingsItemOutput
extension ProfileViewController: ProfileSettingsItemOutput {
    func buttonTaped(flag: Int) {
        presenter.itemPressed(flag: flag)
    }
}
