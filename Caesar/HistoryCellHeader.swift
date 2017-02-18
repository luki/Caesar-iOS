//
//  HistoryCellHeader.swift
//  Caesar
//
//  Created by L on 2/18/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

class HistoryCellHeader: UICollectionReusableView {
  
  let headerLabel: UILabel = {
    let label = UILabel()
    label.falseAutoresizingTranslation()
    label.font = UIFont(name: "Okomito-Regular", size: 20.5)
    label.textColor = UIColor.new(red: 120, green: 144, blue: 156)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews(views: headerLabel)
    activateLayoutConstraints(
      headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerLabel.topAnchor.constraint(equalTo: topAnchor)
    )
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
