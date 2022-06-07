import Cocoa
import FlutterMacOS

import FlutterMacOS
/// START BITSDOJO_WINDOWS FLUTTER PLUGIN
import bitsdojo_window_macos // Add this line
/// END BITSDOJO_WINDOWS FLUTTER PLUGIN

/// START BITSDOJO_WINDOWS FLUTTER PLUGIN
class MainFlutterWindow: BitsdojoWindow {
  override func bitsdojo_window_configure() -> UInt {
  //return BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP
  return BDW_HIDE_ON_STARTUP
}
/// END BITSDOJO_WINDOWS FLUTTER PLUGIN
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
