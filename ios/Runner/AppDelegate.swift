import UIKit
import Flutter



enum ChannelName {
  static let battery = "samples.flutter.io/battery"
}

enum BatteryState {
  static let charging = "charging"
  static let discharging = "discharging"
}

enum MyFlutterErrorCode {
  static let unavailable = "UNAVAILABLE"
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,FlutterStreamHandler {

     private var eventSink: FlutterEventSink?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    //初始化DDLog
    LogManager.initLogger()
    NewBleManager.initManager()
    
    GeneratedPluginRegistrant.register(with: self)
    
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("rootViewController is not type FlutterViewController")
    }

    
    let batteryChannel = FlutterMethodChannel(name: ChannelName.battery,
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        
//      guard call.method == "getBatteryLevel" else {
//        result(FlutterMethodNotImplemented)
//        return
//      }
       switch call.method {
        case "getBatteryLevel":
          self?.receiveBatteryLevel(result: result)
        case "bindDevice":
          self?.bindDevice(result: result)
        default:
          result(FlutterMethodNotImplemented)
          break
      }
    })


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


    private func receiveBatteryLevel(result: FlutterResult) {
        
       let device = UIDevice.current
       device.isBatteryMonitoringEnabled = true
       guard device.batteryState != .unknown  else {
         result(FlutterError(code: MyFlutterErrorCode.unavailable,
                             message: "Battery info unavailable",
                             details: nil))
         return
       }
       result(Int(device.batteryLevel * 100))
     }
    
    private func bindDevice(result: FlutterResult) {
            
           let bleBusiness = XZLThirdDeviceBLEBusiness.init()
           let bleModel = BleDataModel.init()
            bleModel.mac = "3C:A5:09:0A:B5:BE"
            bleModel.imei = "864048041134481"
      
            bleBusiness.bindOnePillBoxDevice(bleModel, andTimeout: 40, sucCallBack: { (respon) in
//                result(respon)
            }) { (error) in
//                result(error)
            }
         }

     public func onListen(withArguments arguments: Any?,
                          eventSink: @escaping FlutterEventSink) -> FlutterError? {
       self.eventSink = eventSink
       UIDevice.current.isBatteryMonitoringEnabled = true
       sendBatteryStateEvent()
       NotificationCenter.default.addObserver(
         self,
         selector: #selector(AppDelegate.onBatteryStateDidChange),
         name: UIDevice.batteryStateDidChangeNotification,
         object: nil)
       return nil
     }

     @objc private func onBatteryStateDidChange(notification: NSNotification) {
       sendBatteryStateEvent()
     }

     private func sendBatteryStateEvent() {
       guard let eventSink = eventSink else {
         return
       }

       switch UIDevice.current.batteryState {
       case .full:
         eventSink(BatteryState.charging)
       case .charging:
         eventSink(BatteryState.charging)
       case .unplugged:
         eventSink(BatteryState.discharging)
       default:
         eventSink(FlutterError(code: MyFlutterErrorCode.unavailable,
                                message: "Charging status unavailable",
                                details: nil))
       }
     }

     public func onCancel(withArguments arguments: Any?) -> FlutterError? {
       NotificationCenter.default.removeObserver(self)
       eventSink = nil
       return nil
     }
}
