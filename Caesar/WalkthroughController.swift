//
//  WalktroughController.swift
//  Caesar
//
//  Created by L on 3/22/17.
//  Copyright © 2017 Lukas A. Muller. All rights reserved.
//

import UIKit

class WalkthroughController: UIViewController {
  
  lazy var walkthroughCollection: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let screenSize = UIScreen.main.bounds.size
    layout.itemSize = CGSize(width: screenSize.width, height: screenSize.height)
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(WalkthroughCell.self, forCellWithReuseIdentifier: WalkthroughCell.reusableIdentifier)
    cv.dataSource = self
    cv.indicatorStyle = .white
    cv.isScrollEnabled = false
    cv.falseAutoresizingTranslation()
    return cv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviewsTo(view, views:
      walkthroughCollection
    )
    addConstraints(
      walkthroughCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      walkthroughCollection.topAnchor.constraint(equalTo: view.topAnchor),
      walkthroughCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      walkthroughCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    )
  }
  
}

extension WalkthroughController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkthroughCell.reusableIdentifier, for: indexPath) as! WalkthroughCell
    cell.descLabel.text = "That means, it was in use way back in the time. Today, such ciphers are rather insecure."
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
}
