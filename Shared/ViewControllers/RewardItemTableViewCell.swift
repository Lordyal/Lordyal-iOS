//
//  RewardItemTableViewCell.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 28/04/2023.
//

import Foundation
import UIKit

struct RewardItemModel {
    var storeName: String
    var rewardDescription: String
    var progress: RewardProgress
    var imageURL: String
}

enum RewardProgress {
    case inProgress(value: Int, total: Int)
    case claimable
}

class RewardItemTableViewCell: UITableViewCell {
    static let identifier = "RewardItemTableViewCell"

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }()

    let productImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .orange
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    let separatorView: UIView = {
        let view = UIView()

        view.backgroundColor = .mediumGreen
        view.layer.cornerRadius = 3

        return view
    }()

    let storeNameLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.textColor = .mediumGreen
        label.font = .systemFont(ofSize: 18, weight: .bold)

        return label
    }()

    let rewardDescriptionLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.textColor = .mediumGreen
        label.font = .systemFont(ofSize: 16, weight: .bold)

        return label
    }()

    let progressLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.textColor = .boldGreen
        label.font = .systemFont(ofSize: 16, weight: .bold)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupLayout()
    }

    var model: RewardItemModel? {
        didSet {
            guard let model else { return }
            updateUI(model: model)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        containerView.layer.cornerRadius = 15
        containerView.backgroundColor = .mediumLightGreen
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(separatorView)
        containerView.addSubview(storeNameLabel)
        containerView.addSubview(rewardDescriptionLabel)
        containerView.addSubview(progressLabel)
    }

    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
        productImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(62)
        }

        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(5)
            make.height.equalTo(26)
        }

        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top)
            make.leading.equalTo(separatorView.snp.trailing).offset(18)
            make.trailing.equalToSuperview().inset(28)
        }

        rewardDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(storeNameLabel)
            make.top.equalTo(storeNameLabel.snp.bottom).offset(2)
        }

        progressLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(storeNameLabel)
            make.top.equalTo(rewardDescriptionLabel.snp.bottom).offset(2)
        }
    }

    private func updateUI(model: RewardItemModel) {
        storeNameLabel.text = model.storeName
        rewardDescriptionLabel.text = model.rewardDescription

        switch model.progress {
        case .claimable:
            break
        case let .inProgress(value: value, total: total):
            progressLabel.text = "\(value) of \(total)"
        }
    }
}
