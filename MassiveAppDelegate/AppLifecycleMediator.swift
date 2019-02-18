//
//  AppLifecycleMediator.swift
//  MassiveAppDelegate
//
//  Created by Quincy-QC on 2019/2/18.
//  Copyright © 2019 Quincy-QC. All rights reserved.
//

import UIKit

protocol AppLifecycleListener {
    func onAppWillEnterForeground()
    func onAppDidEnterBackground()
    func onAppDidFinishLaunching()
}

extension AppLifecycleListener {
    func onAppWillEnterForeground() {}
    func onAppDidEnterBackground() {}
    func onAppDidFinishLaunching() {}
}

struct listen1: AppLifecycleListener {
    func onAppDidFinishLaunching() {
        print("app did finish launching1")
    }
    
    func onAppWillEnterForeground() {
        print("app will enter foreground")
    }
}

struct listen2: AppLifecycleListener {
    func onAppDidEnterBackground() {
        print("app did enter background")
    }
}

struct listen3: AppLifecycleListener {
    func onAppDidFinishLaunching() {
        print("app did finish launching2")
    }
}

class AppLifecycleMediator: NSObject {
    private let listeners: [AppLifecycleListener]
    
    init(listeners: [AppLifecycleListener]) {
        self.listeners = listeners
        super.init()
        subscribe()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(onAppWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppDidFinishLaunching), name: UIApplication.didFinishLaunchingNotification, object: nil)
    }
    
    @objc func onAppWillEnterForeground() {
        listeners.forEach { $0.onAppWillEnterForeground() }
    }
    
    @objc func onAppDidEnterBackground() {
        listeners.forEach { $0.onAppDidEnterBackground() }
    }
    
    @objc func onAppDidFinishLaunching() {
        listeners.forEach { $0.onAppDidFinishLaunching() }
    }
}

extension AppLifecycleMediator {
    static func makeDefaultMediator() -> AppLifecycleMediator {
        return AppLifecycleMediator(listeners: [listen1(), listen2(), listen3()])
    }
}

