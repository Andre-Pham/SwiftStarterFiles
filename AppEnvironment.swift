import Foundation
import UIKit

class AppEnvironment {
    
    public static let inst = AppEnvironment()
    
    private var safeAreaInsets: UIEdgeInsets? {
        return self.window?.safeAreaInsets
    }
    
    public var deviceType: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    public var deviceIsMac: Bool {
        return ProcessInfo.processInfo.isiOSAppOnMac
    }
    
    public var topSafeAreaHeight: CGFloat {
        return self.safeAreaInsets?.top ?? 0.0
    }
    
    public var bottomSafeAreaHeight: CGFloat {
        return self.safeAreaInsets?.bottom ?? 0.0
    }
    
    public var screenHeight: CGFloat {
        if self.deviceIsMac, let window = self.window {
            return window.frame.size.height
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    public var screenWidth: CGFloat {
        if self.deviceIsMac, let window = self.window {
            return window.frame.size.width
        } else {
            return UIScreen.main.bounds.width
        }
    }
    
    public var interfaceOrientation: UIInterfaceOrientation {
        return self.window?.windowScene?.interfaceOrientation ?? .unknown
    }
    
    public var deviceOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    public var screenAspectRatio: CGFloat {
        if self.deviceIsMac, let window = self.window {
            return window.frame.size.width/window.frame.size.height
        } else {
            return UIScreen.main.bounds.width/UIScreen.main.bounds.height
        }
    }
    
    public var orientatedScreenAspectRatio: CGFloat {
        switch self.interfaceOrientation {
        case .unknown:
            return self.screenAspectRatio
        case .portrait, .portraitUpsideDown:
            return self.portraitScreenAspectRatio
        case .landscapeLeft, .landscapeRight:
            return self.landscapeScreenAspectRatio
        @unknown default:
            assertionFailure("New orientation not accounted for")
            return self.screenAspectRatio
        }
    }
    
    public var portraitScreenAspectRatio: CGFloat {
        let width: CGFloat
        let height: CGFloat
        if self.deviceIsMac, let window = self.window {
            width = window.frame.size.width
            height = window.frame.size.height
        } else {
            width = UIScreen.main.bounds.width
            height = UIScreen.main.bounds.height
        }
        return min(width, height)/max(width, height)
    }
    
    public var landscapeScreenAspectRatio: CGFloat {
        let width: CGFloat
        let height: CGFloat
        if self.deviceIsMac, let window = self.window {
            width = window.frame.size.width
            height = window.frame.size.height
        } else {
            width = UIScreen.main.bounds.width
            height = UIScreen.main.bounds.height
        }
        return max(width, height)/min(width, height)
    }
    
    public var window: UIWindow? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }
    
    public var deviceIsTiny: Bool {
        return self.screenHeight.isLessOrEqual(to: 667)
    }
    
    public var deviceIsLarge: Bool {
        return self.deviceType != .phone
    }
    
    public var applicationState: UIApplication.State {
        UIApplication.shared.applicationState
    }
    
    public var executingUIPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    public var executingUnitTests: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil
    }
    
    private init() { }
    
}
