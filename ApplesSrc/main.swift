    //
//  File.swift
//  PrototypeOfAsynchronousDataStore
//
//  Created by Eugene Kalinin on 22/10/2018.
//  Copyright © 2018 user. All rights reserved.
//


import Foundation
import UIKit

    
public class AppDelegateHandler: NSObject, UIApplicationDelegate {
    
}

public class AppDelegateProxy: NSObject, UIApplicationDelegate {
    
    public var handlers:[AppDelegateHandler] = []
    
    public override func responds(to aSelector: Selector) -> Bool {
        
        if self.shouldForwardSelector(aSelector) {
            for handler in self.handlers {
                if handler.responds(to: aSelector) {
                    return true
                }
            }
        }
        return NSObject.instancesRespond(to:aSelector)
    }
    
    public override func forwardingTarget(for aSelector: Selector) -> Any? {
        for handler in self.handlers {
            if handler.responds(to: aSelector) {
                return handler
            }
        }
        return nil
    }
    
    private func shouldForwardSelector(_ aSelector: Selector) -> Bool {
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


UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), nil, NSStringFromClass(AppDelegate.self))
