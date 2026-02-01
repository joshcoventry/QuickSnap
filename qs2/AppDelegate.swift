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
    private var prefsWindowController: NSWindowController?
    private var settingsWindow: NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        
        
//        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        self.changeStatusBarButtonFromAsset(ass:"recordingStatusItem", accessibilityDescription: "not connected")
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            // Try a symbol to confirm it shows up
            if let img = NSImage(systemSymbolName: "record.circle", accessibilityDescription: "qs2") {
                button.image = img
                button.image?.isTemplate = true // makes it adapt to light/dark
            } else {
                button.title = "QS" // fallback text so it’s always visible
            }
        }
                
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
        let captureItem = NSMenuItem(title: "Capture screen", action: #selector(captureScreen), keyEquivalent: "")
        captureItem.target = self
        menu.addItem(captureItem)
        menu.addItem(NSMenuItem(title: "Capture selection", action: nil, keyEquivalent: "")) // no action yet
        menu.addItem(NSMenuItem(title: "Capture window", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Record screen", action: nil, keyEquivalent: ""))
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "Options...", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Show History...", action: nil, keyEquivalent: ""))
        menu.addItem(.separator())
        let settingsItem = NSMenuItem(title: "Settings...", action: #selector(openPreferences(_:)), keyEquivalent: "")
        settingsItem.target = self
        menu.addItem(settingsItem)
        menu.addItem(NSMenuItem(title: "About...", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

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
    
    @objc func openPreferences(_ sender: Any?) {
        if prefsWindowController == nil {
            // Adjust storyboard name and controller identifier to match your project
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            prefsWindowController = storyboard.instantiateController(withIdentifier: "PreferencesWindowController") as? NSWindowController
        }
        guard let windowController = prefsWindowController else { return }
        NSApp.activate(ignoringOtherApps: true)
        windowController.showWindow(self)
        windowController.window?.makeKeyAndOrderFront(self)
    }
    
    @objc private func openSettings() {
        if settingsWindow == nil {
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 480, height: 320),
                styleMask: [.titled, .closable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
            window.center()
            window.title = "Settings"
            window.isReleasedWhenClosed = false
            // Basic placeholder content view
            let contentView = NSView(frame: NSRect(x: 0, y: 0, width: 480, height: 320))
            window.contentView = contentView
            settingsWindow = window
        }
        NSApp.activate(ignoringOtherApps: true)
        settingsWindow?.makeKeyAndOrderFront(nil)
    }
    
    @objc private func captureScreen() {
        // implement
    }
    
}
