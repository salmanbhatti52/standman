import UIKit
import Flutter

@UIApplicationMain
GMSServices.provideAPIKey("AIzaSyA1kEvCbj9i4-ez8d8KEvEfUuoDzFyjvEc")
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
