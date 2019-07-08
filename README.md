## Scorp Viewer | iOS Photo Viewer  V 1.0.1##
 **It's finally here!** Scorp Viewer is the simplest photo viewer for iOS development
Reale simple to use 
Only do:
`Import ScorpViewer` 
**And you are ready to go!**

On version **V 1.0.1**:

- [X] Supports N amounts of photographs, customize your own controller with **_ScorpViewerView_** and add specific and custom events
- [X] Use the simple **_ScorpViewerViewController_** and only send it the photographs you want to use and present it!
- [X] iOS 10 + 
- [X] Resizing photo to Device Size

Coming Soon:

- [ ] Pinch to zoom
- [ ] Gallery View
- [ ] Share options
- [ ] Cocoa Pods Support
- [ ] Carthage Support

## Getting Started ##

### Installing ###

**First** you have to download the framework. You can download the ScorpViewer.framework.zip from here: https://github.com/ios-scorp-dev-syndicate/ScorpViewer/releases/tag/v1.0.1
Then simply just drag and drop onto your project

[Demo App](https://github.com/rud0lph09/ScorpViewerDemo.git)

### How to use ###

If you want to use the **_ScorpViewerViewController_** For a simple and photo viewer implementation here is an example of a view controller that presents our Scorp Viewer View Controller: 

```
import UIKit
import ScorpViewer

class ViewController: UIViewController {

  @IBAction func showPhotos(){
    let imagesArray: [UIImage] = [UIImage(named: "one")!,
                                  UIImage(named: "two")!,
                                  UIImage(named: "three")!,
                                  UIImage(named: "four")!,
                                  UIImage(named: "five")!, ]
    guard let fotoViewer = ScorpViewerViewController.instantiate(withPhotos: imagesArray) else { return }
    self.present(fotoViewer, animated: true, completion: nil)
  }
}
```

But if you want to implement our view on your own costum controller you should checkout here is a controller example:

```
import UIKit
import ScorpViewer


class MyController: UIViewController {

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
}
```
**Dont forget about the protocol!**
```

extension MyController: ScorpViewerProtocol {
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
    return UIImage(named: "imageName")
  }
}
```

And You are done!

[Demo Giphy](http://www.giphy.com/gifs/JORRiFX1P5fTGP2j1J)

### Publishing an App with this framework to the App Store ###

We are currently working on our licensing but... You are free to publish this on any app!
But before you get all happy you should know...

This framework has FAT binaries so first you have to trim it! You can simple add this script to your project in:
**Target > Build Phases > Add run Script**

```
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

# This script loops through the frameworks embedded in the application and
# removes unused architectures.
find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
    FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
    FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
    echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

    EXTRACTED_ARCHS=()

    for ARCH in $ARCHS
    do
        echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
        lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
        EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
    done

    echo "Merging extracted architectures: ${ARCHS}"
    lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
    rm "${EXTRACTED_ARCHS[@]}"

    echo "Replacing original executable with thinned version"
    rm "$FRAMEWORK_EXECUTABLE_PATH"
    mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

done
```

This script was published by Yarik Arsenkin on: http://arsenkin.com/ios-universal-framework.html
