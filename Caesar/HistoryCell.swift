//
//  HistoryCell.swift
//  Caesar
//
//  Created by L on 2/17/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
  func addSubviews(views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
  func activateLayoutConstraints(_ constraints: NSLayoutConstraint...) {
    NSLayoutConstraint.activate(constraints)
  }
}

class HistoryCell: UICollectionViewCell {
  
  let contentLabel: UILabel = {
    let label = UILabel()
    label.falseAutoresizingTranslation()
    label.font = UIFont(name: "Okomito-Regular", size: 20.5)
    label.textColor = .white
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews(views: contentLabel)
    
    activateLayoutConstraints(
      contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    )
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
