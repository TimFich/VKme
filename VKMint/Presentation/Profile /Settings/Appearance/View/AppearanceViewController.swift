//
//  AppearanceViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 15.05.2022.
//

import UIKit
import SnapKit

protocol AppearanceViewInput: AnyObject {
    
}

protocol AppearanceViewOutput: AnyObject {
    
}

class AppearanceViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: AppearancePresenter!
    private let idetifier = "logoCells"
    private let namesOfIcons = ["First_Logo", "Second_Logo", "Third_Logo", "Fourth_Logo", "Fifth_Logo"]
    private let interItemSpacing = CGFloat(10)
    private var layout = UICollectionViewFlowLayout()
    
    //MARK: - UI
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .systemGray
        label.text = "Icon of application"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            collectionView
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = interItemSpacing
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .normal
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        layout.scrollDirection = .horizontal
        return collectionView
    }()
    
    //MARK: - View life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
        title = "Appearance"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LogoCollectionViewCell.self, forCellWithReuseIdentifier: idetifier)
        setUpUI()
    }
    
    private func setUpUI() {
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
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: view.bounds.width, height: 70))
            make.left.right.equalToSuperview()
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AppearanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namesOfIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idetifier, for: indexPath) as? LogoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        UIApplication.shared.setAlternateIconName(
            namesOfIcons[indexPath.row],
            completionHandler: { (error) in
            if let error = error {
                print("App icon failed to change due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully")
            }
        })
    }
}

//MARK: - AppearanceViewInput
extension AppearanceViewController: AppearanceViewInput {
    
}
