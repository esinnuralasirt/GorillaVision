
import SwiftUI
import AppTrackingTransparency
import AdSupport
import FirebaseCore
import FirebaseAnalytics
import FirebaseInstallations
import FirebaseRemoteConfigInternal
import SdkPushExpress
import AppsFlyerLib
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, DeepLinkDelegate {
    
    var window: UIWindow?
    weak var initVC: ViewController?
    
    var identAdvert: String = ""
    var time = 0
    var analytId: String = ""

    static var orientation = UIInterfaceOrientationMask.all
    
    private let pushAppId = "38232-1202"
    private var externalId = ""
    private var remote: RemoteConfig?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        remote = RemoteConfig.remoteConfig()
        setupConfig()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        initVC = viewController
        window?.rootViewController = initVC
        window?.makeKeyAndVisible()
        AppsFlyerLib.shared().appsFlyerDevKey = "YHPbRGHTtXw9P3Qja88ugg"
        AppsFlyerLib.shared().appleAppID = "6743405380"
        AppsFlyerLib.shared().deepLinkDelegate = self
        AppsFlyerLib.shared().delegate = self
        
        Task { @MainActor in
            analytId = await fetchAnalyticsId()
            externalId = analytId
        }

        loadApp(viewController: viewController)
        
        AppsFlyerLib.shared().start()
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)

        //MARK: - PUSH EXPRESS
        externalId = analytId

        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if error != nil {
            } else {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        
        UNUserNotificationCenter.current().delegate = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            do {
                try PushExpressManager.shared.initialize(appId: self.pushAppId)
                try PushExpressManager.shared.activate(extId: self.externalId)
            } catch {
                print("Error initializing or activating PushExpressManager: \(error)")
            }

            if !PushExpressManager.shared.notificationsPermissionGranted {
                print("Notifications permission not granted. Please enable notifications in Settings.")
            }
        }
       
        return true
    }
    
    func fetchAnalyticsId() async -> String {
        do {
            if let appInstanceID = Analytics.appInstanceID() {
                return appInstanceID
            } else {
                return ""
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientation
    }
    
    func setupConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remote?.configSettings = settings
    }
    
    func loadApp(viewController: ViewController) {
        remote?.fetch { [weak self] status, error in
            guard let self = self else { return }
            
            if status == .success {
                let appsID = AppsFlyerLib.shared().getAppsFlyerUID()
                
                self.remote?.activate { _, error in
                    DispatchQueue.main.async {
                        if error != nil {
                            viewController.firstOpen()
                            return
                        }
                        
                        if let remString = self.remote?.configValue(forKey: "gorilla").stringValue {
                            if !remString.isEmpty {
                                if let finalURL = UserDefaults.standard.string(forKey: "finalURL") {
                                    viewController.secondOpen(string: finalURL)
                                    print("SECOND OPEN: \(finalURL)")
                                    return
                                }
                                
                                if self.identAdvert.isEmpty {
                                    self.time = 5
                                    self.identAdvert = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                                }
                                
                                if self.identAdvert.isEmpty {
                                    viewController.firstOpen()
                                    return
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.time)) {
                                    let stringURL = viewController.setupstr(mstring: remString, deviid: self.analytId, advid: self.identAdvert, appsflif: appsID)
                                    
                                    print("Result: \(stringURL)")
                                    
                                    guard let url = URL(string: stringURL) else {
                                        viewController.firstOpen()
                                        return
                                    }
                                    
                                    if UIApplication.shared.canOpenURL(url) {
                                        viewController.secondOpen(string: stringURL)
                                    } else {
                                        viewController.firstOpen()
                                    }
                                }
                                
                            } else {
                                viewController.firstOpen()
                            }
                        } else {
                            viewController.firstOpen()
                        }
                    }
                }
            }
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        ATTrackingManager.requestTrackingAuthorization { (status) in
            self.time = 10
            switch status {
            case .authorized:
                self.identAdvert = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                self.time = 1
            case .denied:
                self.identAdvert = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            case .notDetermined:
                print("Not Determined")
            case .restricted:
                print("Restricted")
            @unknown default:
                print("Unknown")
            }
        }
        AppsFlyerLib.shared().start()
    }
    
    //MARK: - Push Notification Handling
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokPart = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let tok = tokPart.joined()
        PushExpressManager.shared.transportToken = tok
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        print("Received notification while app is in foreground: \(userInfo)")
        completionHandler([.banner, .list, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                    didReceive response: UNNotificationResponse,
                    withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        print("Handling notification response: \(userInfo)")
        NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil, userInfo: userInfo)
        completionHandler()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Gorilla")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {
        print("onConversionDataSuccess \(data)")
    }
    
    func onConversionDataFail(_ error: Error) {
        
    }
}
