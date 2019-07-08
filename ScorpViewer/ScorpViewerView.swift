//
//  ScorpViewerView.swift
//  GalleryExample
//
//  Created by Rodolfo Castillo Vidrio on 7/2/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

public class ScorpViewerView: UIView {

  public var handler: ScorpViewerProtocol!

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
    let bundle = Bundle(for: ScorpViewerView.self)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: ScorpViewerCell.xibFileName, bundle: bundle), forCellWithReuseIdentifier: ScorpViewerCell.reusableID)
  }

  public func setUpView(withHandler handler: ScorpViewerProtocol!) {
    self.handler = handler
    let icon = self.handler.scorpView(self, iconForButtonItem: actionButton)
    self.actionButton.setImage(icon, for: .normal)
    self.registerCell()
  }

  public class func instantiate() -> ScorpViewerView? {
    let bundle = Bundle(for: ScorpViewerView.self)
    return UINib(nibName: "ScorpViewerView", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? ScorpViewerView
  }

}

extension ScorpViewerView: UICollectionViewDelegate, UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return handler.photos.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScorpViewerCell.reusableID, for: indexPath) as! ScorpViewerCell
    let photo = handler.photos[indexPath.row]
    cell.set(withImage: photo)
    cell.set(backgroundColor: handler.backgroundColor)
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
      let _ = self.collectionView(self.collectionView, layout: layout, sizeForItemAt: indexPath)
    }
    return cell
  }
}

public protocol ScorpViewerProtocol {
  var photos: [UIImage] { get }
  var backgroundColor: UIColor { get }
  func didPressActionButton(inScorpView: ScorpViewerView)
  func scorpView(_ scorpView: ScorpViewerView, iconForButtonItem: UIButton) -> UIImage?
}


extension ScorpViewerView: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.bounds.width + 5, height: self.bounds.height)

  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5
  }

  public func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
                             minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5
  }
}

