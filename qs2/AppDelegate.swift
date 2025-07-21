//
//  AppDelegate.swift
//  qs2
//
//  Created by Joshua Coventry on 29/04/2018.
//  Copyright © 2018 Joshua Coventry. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var window: NSWindow!
    private var statusItem: NSStatusItem!
    private var timer: Timer!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.changeStatusBarButtonFromAsset(ass:"recordingStatusItem", accessibilityDescription: "not connected")
                
//                timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
//                    if fethInterfaceExists() {
//                        //self.changeStatusBarButton(icon: "bolt.horizontal.circle.fill", accessibilityDescription: "connected")
//                        self.changeStatusBarButtonFromAsset(ass: "ornage", accessibilityDescription: "")
//
//                    } else {
//                        self.changeStatusBarButton(icon: "circle", accessibilityDescription: "not connected")
//                    }
//                })
                
        setupMenus()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func setupMenus() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Capture screen", action: "", keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Capture selection", action: "", keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Capture window", action: "", keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Record screen", action: "", keyEquivalent: ""))
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "Options...", action: "", keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Show History...", action: "", keyEquivalent: ""))
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "About...", action: "", keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        
        statusItem.menu = menu
    }
    
//    func changeStatusBarButton(icon: String, accessibilityDescription: String) {
//         if let button = statusItem.button {
//             button.image = NSImage(named: icon, accessibilityDescription: accessibilityDescription)
//         }
//     }
     
     func changeStatusBarButtonFromAsset(ass: String, accessibilityDescription: String) {
         if let button = statusItem.button {
             button.image = NSImage(named: NSImage.Name(ass))
             
         }
     }
    
}
