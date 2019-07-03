//
//  ScorpViewCellCollectionViewCell.swift
//  GalleryExample
//
//  Created by Rodolfo Castillo Vidrio on 7/2/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ScorpViewerCell: UICollectionViewCell {

  static var reusableID = "scorpViewCellID"
  static var xibFileName = "ScorpViewerCell"

  @IBOutlet private weak var photoView: UIImageView!

  func set(withImage image: UIImage){
    self.photoView.image = image
  }

  func set(backgroundColor color: UIColor){
    self.backgroundColor = color
  }
    
}
