//
//  RedeemViewController.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 27/04/2023.
//

import Foundation
import UIKit

class RedeemViewController: UIViewController {
    let pointsLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .mediumGreen
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "You earned +2 points"

        return label
    }()

    let totalPointsLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .mediumGreen
        label.font = .systemFont(ofSize: 64, weight: .bold)
        label.text = "5 of 6"

        return label
    }()

    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.backgroundColor = .orange
        return imageView
    }()

    let noteLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGreen
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Come back 1 more time(s) to get your reward"

        return label
    }()

    lazy var openAppStoreButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("GET LORDYAL", for: .normal)
        button.backgroundColor = .boldGreen
        button.setTitleColor(
            .lightGreen,
            for: .normal
        )
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)

        return button
    }()

    lazy var openRewardListButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackground()
        setupViews()
        setupLayout()
    }

    private func addBackground() {
        let path = UIBezierPath()

        let y: CGFloat = UIScreen.main.bounds.size.height
        let x: CGFloat = UIScreen.main.bounds.size.width
        let height: CGFloat = y / 2
        let startHeight = height + 100

        path.move(to: CGPoint(x: 0, y: startHeight)) // bottom left
        path.addQuadCurve(to: CGPoint(x: x, y: startHeight), controlPoint: CGPoint(x: x / 2, y: height))
        path.addLine(to: CGPoint(x: x, y: y)) // bottom right
        path.addLine(to: CGPoint(x: 0, y: y))
        path.close() // close the path from bottom right to bottom left

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.mediumGreen.cgColor

        view.layer.addSublayer(shapeLayer)
    }

    private func setupViews() {
        view.backgroundColor = .lightGreen
        view.addSubview(pointsLabel)
        view.addSubview(totalPointsLabel)
        view.addSubview(productImageView)
        view.addSubview(noteLabel)
        view.addSubview(openAppStoreButton)
        view.addSubview(openRewardListButton)
    }

    private func setupLayout() {
        pointsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(74)
        }

        totalPointsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(pointsLabel.snp.bottom)
        }

        productImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }

        noteLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(productImageView.snp.bottom).offset(16)
        }

        openAppStoreButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(64)
            make.bottom.equalTo(openRewardListButton.snp.top)
        }

        openRewardListButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
