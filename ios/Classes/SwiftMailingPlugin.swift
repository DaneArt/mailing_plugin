import Flutter
import UIKit
import MessageUI


public class SwiftMailingPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mailing_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftMailingPlugin()
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   switch call.method {
    case "send_mail":
       
    if MFMailComposeViewController.canSendMail() {
        let appDelegate  = UIApplication.shared.delegate as! FlutterAppDelegate
        let viewController = appDelegate.window!.rootViewController

     let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.delegate = self
            
        mailComposeViewController.setToRecipients(["publice.centaurus@gmail.com"])
     mailComposeViewController.setSubject("Subject")
     mailComposeViewController.setMessageBody("Hello!!!", isHTML: false)
    
        viewController?.present(mailComposeViewController, animated: true, completion: nil)
 
       }
    default:
        print("не удалось распознать число")
    }
  }
}
