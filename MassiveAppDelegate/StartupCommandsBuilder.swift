//
//  StartupCommandsBuilder.swift
//  MassiveAppDelegate
//
//  Created by Quincy-QC on 2019/2/15.
//  Copyright © 2019 Quincy-QC. All rights reserved.
//

import UIKit

protocol Command {
    func execute()
}

struct InitializeThirdPartiesCommand: Command {
    func execute() {
        print("Third parties are initialized")
    }
}

struct InitialViewControllerCommand: Command {
    let keyWindow: UIWindow
    
    func execute() {
        print("Pick root view controller here")
        keyWindow.frame = UIScreen.main.bounds
        keyWindow.backgroundColor = UIColor.white
        keyWindow.makeKeyAndVisible()
        keyWindow.rootViewController = ViewController()
    }
}

struct InitializeAppearanceCommand: Command {
    func execute() {
        print("Setup UIAppearance")
    }
}

struct RegisterToRemoteNotificationsCommand: Command {
    func execute() {
        print("Register for remote notifications here")
    }
}

// MARK: -------- StartupCommandsBuilder --------

final class StartupCommandsBuilder {
    private var window: UIWindow!
    
    func setKeyWindow(_ window: UIWindow) -> StartupCommandsBuilder {
        self.window = window
        return self
    }
    
    func build() -> [Command] {
        return [InitializeThirdPartiesCommand(),
                InitialViewControllerCommand(keyWindow: window),
                InitializeAppearanceCommand(),
                RegisterToRemoteNotificationsCommand()]
    }
}
