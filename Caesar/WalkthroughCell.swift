//
//  WalkthroughCell.swift
//  Caesar
//
//  Created by L on 3/22/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

extension UIView {
  func onTop(_ views: UIView...) {
    for view in views {
      self.addSubview(view)
    }
  }
}

class WalkthroughCell: UICollectionViewCell {
  
  let descriptionArea: UIView = {
    let view = UIView()
    view.falseAutoresizingTranslation()
    view.backgroundColor = .white
    return view
  }()
  
  let inclinedPlane: UIImageView = {
    let iv = UIImageView()
    iv.falseAutoresizingTranslation()
    iv.image = UIImage(named: "plane")
    return iv
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.falseAutoresizingTranslation()
    label.font = UIFont(name: "Okomito-Medium", size: 51/2)
    label.text = "Historical Cipher"
    return label
  }()
  
  let descLabel: UILabel = {
    let text = "Hello"
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 90/2
    
    let attrString = NSMutableAttributedString(string: text)
    attrString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
    
    let label = UILabel()
    label.falseAutoresizingTranslation()
    label.attributedText = attrString
    label.numberOfLines = 3
    return label
  }()
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.falseAutoresizingTranslation()
    imageView.backgroundColor = .red
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .black
    addSubviews(views:
      imageView,
      descriptionArea,
      inclinedPlane
    )
    descriptionArea.onTop(
      titleLabel,
      descLabel
    )
    addConstraints(
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: descriptionArea.topAnchor),
      descriptionArea.heightAnchor.constraint(equalToConstant: 479/2),
      descriptionArea.leadingAnchor.constraint(equalTo: leadingAnchor),
      descriptionArea.trailingAnchor.constraint(equalTo: trailingAnchor),
      descriptionArea.bottomAnchor.constraint(equalTo: bottomAnchor),
      inclinedPlane.bottomAnchor.constraint(equalTo: descriptionArea.topAnchor),
      inclinedPlane.leadingAnchor.constraint(equalTo: leadingAnchor),
      inclinedPlane.trailingAnchor.constraint(equalTo: trailingAnchor),
      inclinedPlane.heightAnchor.constraint(equalToConstant: 0.121657754010695 * frame.height),
      titleLabel.leadingAnchor.constraint(equalTo: descriptionArea.leadingAnchor, constant: 44),
      titleLabel.trailingAnchor.constraint(equalTo: descriptionArea.trailingAnchor, constant: -44),
      titleLabel.topAnchor.constraint(equalTo: descriptionArea.topAnchor, constant: 30.5/2),
      descLabel.leadingAnchor.constraint(equalTo: descriptionArea.leadingAnchor, constant: 44),
      descLabel.trailingAnchor.constraint(equalTo: descriptionArea.trailingAnchor, constant: -44),
      descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.5/2)
    )
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
