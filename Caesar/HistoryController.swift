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

extension Array {
  public func get(atIndex: Int) -> Element {
    return self[atIndex]
  }
}

class HistoryController: UIViewController {

  var cipherHistory: [Cipher] = [
    Cipher(offset: 7, appliedMethod: 0, content: "oCz GvNO CDNOJMT xGvNN"),
    Cipher(offset: 7, appliedMethod: 0, content: "oCz GvNO CDNOJMT xGvNN"),
    Cipher(offset: 9, appliedMethod: 1, content: "The last history class was so"),
  ]
  
  let publicDb = CKContainer(identifier: "iCloud.guru.luke.Caesar").publicCloudDatabase
  
//  func retrieveData() -> CKRecord {
//    let query = CKQuery(recordType: "Cipher", predicate: NSPredicate(format: "TRUEPREDICATE"))
//    
//    query.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
//    
//    publicDb.perform(query, inZoneWith: nil) { record, error in
//      
//    }
//    
//  }
  
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
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 88, height: 21.5)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
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
    addSubviewsTo(view, views: button, historyCollection)
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
    cell.contentLabel.text = cipherHistory
                                .filter {$0.appliedMethod == indexPath.section}
                                .get(atIndex: indexPath.row)
                                .content
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
