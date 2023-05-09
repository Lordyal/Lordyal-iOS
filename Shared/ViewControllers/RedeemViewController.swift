//
//  RedeemViewController.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 27/04/2023.
//

import Foundation
import UIKit

class RedeemViewController: UIViewController {
    let readyLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .lightGreen
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Reward is ready to claim"

        return label
    }()

    let rewardDescriptionLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightGreen
        label.font = .systemFont(ofSize: 36, weight: .black)
        label.text = "50% Off for Medium Size"

        return label
    }()

    let storeNameLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .lightGreen
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Mr Pijazz"

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
        label.textColor = .mediumGreen
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Redeem reward now?"

        return label
    }()

    lazy var useNowButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Redeem", for: .normal)
        button.backgroundColor = .boldGreen
        button.setTitleColor(
            .lightGreen,
            for: .normal
        )
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(self, action: #selector(tapUseNow), for: .touchUpInside)

        return button
    }()

    lazy var useLaterButton: UseLaterButton = {
        let button = UseLaterButton(frame: .zero)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUseLater))
        button.addGestureRecognizer(tapGesture)
        return button
    }()

    let buttonStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill

        return stackView
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
        let startHeight = height - 100

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: startHeight))
        path.addQuadCurve(to: CGPoint(x: x, y: startHeight), controlPoint: CGPoint(x: x / 2, y: height))
        path.addLine(to: CGPoint(x: x, y: 0))
        path.addLine(to: .zero)
        path.close() // close the path from bottom right to bottom left

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.mediumGreen.cgColor

        view.layer.addSublayer(shapeLayer)
    }

    private func setupViews() {
        view.backgroundColor = .lightGreen
        view.addSubview(readyLabel)
        view.addSubview(rewardDescriptionLabel)
        view.addSubview(storeNameLabel)
        view.addSubview(productImageView)
        view.addSubview(noteLabel)

        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(useLaterButton)
        buttonStackView.addArrangedSubview(useNowButton)
    }

    private func setupLayout() {
        readyLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        rewardDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(readyLabel.snp.bottom).offset(16)
        }

        storeNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(rewardDescriptionLabel.snp.bottom).offset(8)
        }

        productImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(16)
            make.width.height.equalTo(300)
        }

        noteLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(productImageView.snp.bottom).offset(16)
        }

        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(63)
        }
    }

    @objc private func tapUseNow() {

    }

    @objc private func tapUseLater() {

    }
}
