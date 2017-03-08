//
//  WalkthroughController.swift
//  Caesar
//
//  Created by L on 3/6/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

class WalkthroughController: UIViewController {
  
  lazy var screenCollection: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    layout.scrollDirection = .horizontal
    
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.falseAutoresizingTranslation()
    
    collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "screen")
    collection.dataSource = self
    collection.backgroundColor = .white
    
    return collection
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviewsTo(view, views: screenCollection)
    addConstraints(
      screenCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      screenCollection.topAnchor.constraint(equalTo: view.topAnchor),
      screenCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      screenCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    )
  }
  
}

extension WalkthroughController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screen", for: indexPath)
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
}
