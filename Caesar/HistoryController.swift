//
//  HistoryController.swift
//  Caesar
//
//  Created by L on 2/13/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit
import CloudKit
import CoreData

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
//    Cipher(offset: 7, appliedMethod: 0, content: "oCz GvNO CDNOJMT xGvNN"),
//    Cipher(offset: 7, appliedMethod: 0, content: "oCz GvNO CDNOJMT xGvNN"),
//    Cipher(offset: 9, appliedMethod: 1, content: "The last history class was so"),
  ]
  
  let publicDb = CKContainer(identifier: "iCloud.guru.luke.Caesar").publicCloudDatabase
  
  let closeButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
    button.contentMode = .scaleAspectFit
    button.setImage(UIImage(named: "up"), for: UIControlState.normal)
    button.falseAutoresizingTranslation()
    button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    return button
  }()
  
  let clearHistoryButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
    button.contentMode = .scaleAspectFit
    button.setImage(UIImage(named: "trash"), for: UIControlState.normal)
    button.falseAutoresizingTranslation()
    button.addTarget(self, action: #selector(clearHistory), for: .touchUpInside)
    return button
  }()
  
  lazy var historyCollection: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 88, height: 21.5)
    layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 70, right: 0)
    layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - 88, height: 21.5)
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.falseAutoresizingTranslation()
    cv.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.reusableIdentifier)
    cv.register(HistoryCellHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HistoryCellHeader.reusableIdentifier)
    cv.dataSource = self
    cv.backgroundColor = .clear
    return cv
  }()
  
  let loadingIndicator: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    aiv.falseAutoresizingTranslation()
//    aiv.hidesWhenStopped = true
    return aiv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.new(red: 38, green: 50, blue: 56)
    addSubviewsTo(view, views: closeButton, historyCollection, clearHistoryButton, loadingIndicator)
    addConstraints(
      closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
      closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
      
      historyCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
      historyCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
      historyCollection.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 44),
      historyCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      clearHistoryButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -16),
      clearHistoryButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
      
      loadingIndicator.trailingAnchor.constraint(equalTo: clearHistoryButton.leadingAnchor, constant: -16),
      loadingIndicator.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor)
    )
      fetchData(entityName: "Cipher")
//    fetchData(database: publicDb, loadingIndicator: loadingIndicator)
  }
  
  // MARK: CoreData
  
  func fetchData(entityName: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    do {
      let results = try managedContext.fetch(fetchRequest)
      for result in results as! [NSManagedObject] {
        cipherHistory.append(Cipher(managedObject: result))
      }
      historyCollection.reloadData()
    }
    catch let error as NSError {
      print("Could not fetch \(error.userInfo)")
    }
  }
  
  // MARK: Target actions

  func dismissController(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  func clearHistory(_ sender: UIButton) {
    // Clear CoreData First
    deleteCoreData(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    cipherHistory.removeAll()
    historyCollection.reloadData()
//    clearData(database: publicDb)
  }
  
  // MARK: Helper Methods
  
  func deleteCoreData(appDelegate: AppDelegate) {
    let managedContext = appDelegate.persistentContainer.viewContext
    let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Cipher"))
    do {
      try managedContext.execute(DelAllReqVar)
    } catch {
      print(error)
    }
  }
  
  func fetchData(database: CKDatabase, loadingIndicator: UIActivityIndicatorView) {
    loadingIndicator.startAnimating()
    let query = CKQuery(recordType: "Cipher", predicate: NSPredicate(value: true))
    database.perform(query, inZoneWith: nil) { results, error in
      if error != nil {
        print(error!.localizedDescription)
      } else {
        results?.forEach { self.cipherHistory.append(Cipher(record: $0)) }
        self.historyCollection.reloadData()
      }
      loadingIndicator.stopAnimating()
    }
  }
  
  func clearData(database: CKDatabase) {
    self.createAlert(title: "Are you sure you want to empty your trash?", message: nil, style: .alert, actions: [
      UIAlertAction(title: "Yes", style: .destructive) { _ in
        if self.cipherHistory.isEmpty {
          self.fetchData(database: database, loadingIndicator: self.loadingIndicator)
        }
        self.cipherHistory.forEach {
          database.delete(withRecordID: $0.id!) { _, _ in }
        }
      },
      UIAlertAction(title: "No", style: .default) { _ in
        self.dismiss(animated: true, completion: nil)
      }
    ])
  }
  
  func createAlert(title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    for action in actions {
      alert.addAction(action)
    }
    present(alert, animated: true, completion: nil)
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
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HistoryCellHeader.reusableIdentifier, for: indexPath) as! HistoryCellHeader
    
    let headerNames = ["Enciphered", "Deciphered"]
    
    headerView.headerLabel.text = headerNames.get(atIndex: indexPath.section)
    return headerView
  }
    
}
