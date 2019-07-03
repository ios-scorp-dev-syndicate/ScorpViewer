//
//  ViewController.swift
//  GalleryExample
//
//  Created by Rodolfo Castillo Vidrio on 7/2/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ScorpViewerViewController: UIViewController {

  @IBOutlet private weak var scorpViewer: ScorpViewerView!

  var photosArray: [UIImage] = []
  var selectedBackgroundColor: UIColor = UIColor.black

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.layoutIfNeeded()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.scorpViewer.setUpView(withHandler: self)

  }

  class func instantiate(withPhotos photos: [UIImage], andSelectedBackgroundColor color: UIColor = UIColor.black) -> ScorpViewerViewController? {
    guard let controller = UIStoryboard(name: "ScorpViewerViewController", bundle: nil).instantiateViewController(withIdentifier: "ScorpViewerControllerID") as? ScorpViewerViewController else { return nil }
    controller.photosArray = photos
    controller.selectedBackgroundColor = color
    return controller
  }


}

extension ScorpViewerViewController: ScorpViewerProtocol {
  var photos: [UIImage] {
    get {
      return self.photosArray
    }
  }

  var backgroundColor: UIColor {
    get {
      return self.selectedBackgroundColor
    }
  }

  func didPressActionButton(inScorpView: ScorpViewerView) {
    guard let navController = self.navigationController else {
      self.dismiss(animated: true, completion: nil)
      return
    }
    navController.popViewController(animated: true)
  }

  func scorpView(_ scorpView: ScorpViewerView, iconForButtonItem: UIButton) -> UIImage? {
    return UIImage(named: "close-icon")
  }


}

