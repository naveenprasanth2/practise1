import UIKit
import Flutter
import GoogleMaps  // Add this line at the top of the file

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyBmDTfUb3bsz2q_8q4fhtN8Mp5Gba2qIXw")  // Replace YOUR_API_KEY with your actual API key
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
