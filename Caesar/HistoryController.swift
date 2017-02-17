//
//  HistoryController.swift
//  Caesar
//
//  Created by L on 2/13/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit
import CloudKit

class HistoryController: UIViewController {
  
  let publicDb = CKContainer.default().publicCloudDatabase
  
  let button: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
    button.contentMode = .scaleAspectFit
    button.setImage(UIImage(named: "up"), for: UIControlState.normal)
    button.falseAutoresizingTranslation()
    button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    return button
  }()
  
  lazy var historyCollection: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.new(red: 38, green: 50, blue: 56)
    addSubviews([button])
    addConstraints([
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
      button.topAnchor.constraint(equalTo: view.topAnchor, constant: 44)
    ])
  }
  
  // MARK: Target actions

  func dismissController(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}
