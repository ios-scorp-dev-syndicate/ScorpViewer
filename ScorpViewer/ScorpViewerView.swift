//
//  ScorpViewerView.swift
//  GalleryExample
//
//  Created by Rodolfo Castillo Vidrio on 7/2/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ScorpViewerView: UIView {

  var handler: ScorpViewerProtocol!

  @IBOutlet weak private var collectionView: UICollectionView!
  @IBOutlet private weak var actionButton: UIButton!

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  @IBAction func didPressActionButton(sender: UIButton) {
    self.handler.didPressActionButton(inScorpView: self)
  }

  private func registerCell() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: ScorpViewerCell.xibFileName, bundle: nil), forCellWithReuseIdentifier: ScorpViewerCell.reusableID)
  }

  func setUpView(withHandler handler: ScorpViewerProtocol!) {
    self.handler = handler
    let icon = self.handler.scorpView(self, iconForButtonItem: actionButton)
    self.actionButton.setImage(icon, for: .normal)
    self.registerCell()
  }

  class func instantiate() -> ScorpViewerView? {
    return UINib(nibName: "ScorpViewerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? ScorpViewerView
  }

}

extension ScorpViewerView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return handler.photos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScorpViewerCell.reusableID, for: indexPath) as! ScorpViewerCell
    let photo = handler.photos[indexPath.row]
    cell.set(withImage: photo)
    cell.set(backgroundColor: handler.backgroundColor)
    return cell
  }
}

protocol ScorpViewerProtocol {
  var photos: [UIImage] { get }
  var backgroundColor: UIColor { get }
  func didPressActionButton(inScorpView: ScorpViewerView)
  func scorpView(_ scorpView: ScorpViewerView, iconForButtonItem: UIButton) -> UIImage?
}


extension ScorpViewerView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return self.bounds.size
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }

  func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }
}

