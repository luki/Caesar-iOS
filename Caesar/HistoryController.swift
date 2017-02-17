//
//  HistoryController.swift
//  Caesar
//
//  Created by L on 2/13/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit
import CloudKit

extension UIView {
  static var reusableIdentifier: String {
    return String(describing: self)
  }
}

class HistoryController: UIViewController {
  
  let publicDb = CKContainer.default().publicCloudDatabase
  let cipherHistory: [Cipher] = [
    Cipher(offset: 5, appliedMethod: 0, content: "Hi", date: Date())
  ]
  
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
    cv.falseAutoresizingTranslation()
    cv.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.reusableIdentifier)
    cv.dataSource = self
    cv.backgroundColor = .clear
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.new(red: 38, green: 50, blue: 56)
    addSubviews([button, historyCollection])
    addConstraints([
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
      button.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
      
      historyCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
      historyCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
      historyCollection.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 44),
      historyCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  // MARK: Target actions

  func dismissController(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}

extension HistoryController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.reusableIdentifier, for: indexPath) as! HistoryCell
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // uses section for appliedMethod, as 0 stands for enciphered & 2 for deciphered
    return cipherHistory.filter { $0.appliedMethod == section }.count
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
}
