    //
//  File.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 user. All rights reserved.
//


import Foundation
import UIKit
/*
@objc public class AppDelegateHandler: NSObject, UIApplicationDelegate {
    
}

public class AppDelegateProxy: NSObject, UIApplicationDelegate {
    
    public var handlers:[AppDelegateHandler] = []
    
    public override func respondsToSelector(aSelector: Selector) -> Bool {
        
        if self.shouldForwardSelector(aSelector) {
            for handler in self.handlers {
                if handler.respondsToSelector(Selector(aSelector)) {
                    return true
                }
            }
        }
        return NSObject.instancesRespondToSelector(aSelector)
    }
    
    public override func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
        for handler in self.handlers {
            if handler.respondsToSelector(aSelector) {
                return handler
            }
        }
        return nil
    }
    
    private func shouldForwardSelector(aSelector: Selector) -> Bool {
        return isSelector(aSelector, fromProtocol: UIApplicationDelegate.self) &&
            !isSelector(aSelector, fromProtocol: NSObjectProtocol.self)
    }
    
    private func isSelector(_ aSelector: Selector, fromProtocol aProtocol:Protocol) -> Bool {
        
        let requiredMethod = [false,false,true,true]
        let instanceMethod = [false,true,false,true]
        
        for callVariant in 0..<4 {
            let methodDescription = protocol_getMethodDescription(aProtocol,
                                                                  aSelector,
                                                                  requiredMethod[callVariant],
                                                                  instanceMethod[callVariant])
            if methodDescription.types != nil && methodDescription.name != nil {
                return true
            }
        }
        
        return false;
    }
}
*/

UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), nil, NSStringFromClass(AppDelegate.self))
