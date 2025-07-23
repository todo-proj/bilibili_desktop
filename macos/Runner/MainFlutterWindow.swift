import Cocoa
import FlutterMacOS
import desktop_multi_window
import window_manager
import media_kit_video
import screen_retriever_macos
import path_provider_foundation
import sqflite_darwin

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
      // Register the plugin which you want access from other isolate.
      WindowManagerPlugin.register(with: controller.registrar(forPlugin: "WindowManagerPlugin"))
      ScreenRetrieverMacosPlugin.register(with: controller.registrar(forPlugin: "ScreenRetrieverMacosPlugin"))
      MediaKitVideoPlugin.register(with: controller.registrar(forPlugin: "MediaKitVideoPlugin"))
      PathProviderPlugin.register(with: controller.registrar(forPlugin: "PathProviderPlugin"))
      SqflitePlugin.register(with: controller.registrar(forPlugin: "SqflitePlugin"))
    }
    super.awakeFromNib()
  }
}
