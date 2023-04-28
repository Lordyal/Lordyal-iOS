//
//  GetAppViewController.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 26/04/2023.
//

import Foundation
import UIKit
import SnapKit

class GetAppViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    let logoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "get_app_bg"))
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    lazy var openAppStoreButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Open App Store", for: .normal)
        button.setTitle("Open App Store", for: .selected)
        button.backgroundColor = .boldGreen
        button.setTitleColor(
            .lightGreen,
            for: .normal
        )
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)

        return button
    }()

    private func setupViews() {
        view.backgroundColor = .lightGreen
        view.addSubview(backgroundImage)
        view.addSubview(logoView)
        view.addSubview(openAppStoreButton)
    }

    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(120)
        }

        openAppStoreButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(24)
            make.height.equalTo(64)
        }

        logoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(openAppStoreButton.snp.top).inset(-78)
            make.width.equalTo(280)
            make.height.equalTo(280)
        }
    }
}
