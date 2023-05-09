//
//  UseLaterButton.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 07/05/2023.
//

import Foundation
import UIKit

class UseLaterButton: UIButton {
    let label: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.textColor = .boldGreen
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Later"
        label.textAlignment = .center

        return label
    }()

    let icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.backward"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .boldGreen

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(label)
        addSubview(icon)
    }

    private func setupLayout() {
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }

        label.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }
}
