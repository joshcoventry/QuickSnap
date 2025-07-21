//
//  ViewController.swift
//  qs2
//
//  Created by Joshua Coventry on 29/04/2018.
//  Copyright © 2018 Joshua Coventry. All rights reserved.
//

import Foundation
import Cocoa
import PhotosUI
import AppKit
import SwiftUI

class ViewController: NSViewController, NSWindowDelegate {
    
    lazy var window: NSWindow! = self.view.window
    
    private var settings:String = ""
    private var filename:String = ""
    private var dest:String = ""
    private var format:String = ""
    private var TimerSetting:String = "0"
    private var copyToClipSetting:String = "0"
    private var mode:Int = 1
    private var intsuffix:Int = 0
    private var playCaptureSound:String = ""
    private var delay:String = ""
    private var captureCursorSetting:String = ""
    private var showThumbSetting:String = ""
    private var openPreviewSetting:String = ""
    private var openMailSetting:String = ""
    private var openMessagesSetting:String = ""
    private var appendDateTimeSetting:String = ""
    private var savePhotoSetting:String = ""
    private var launchPathString:String = "/usr/sbin/screencapture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Additional stuff after view load
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        window.isMovableByWindowBackground = true
        window!.standardWindowButton(.miniaturizeButton)!.isHidden = true
        window!.standardWindowButton(.zoomButton)!.isHidden = true
    }
    
    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    
    func setPrefs() {
        //get filename
        
        filename = UserDefaults.standard.string(forKey: "filename") ?? "Screenshot"
        format = UserDefaults.standard.string(forKey: "format") ?? "jpg"
        dest = UserDefaults.standard.string(forKey: "filepath")! + "/" ?? userDesktop() + "/"

        
        //get capture sound setting
        if UserDefaults.standard.string(forKey: "playCaptureSoundSetting") == "1"
        {
            playCaptureSound = ""
        }
        else {
            playCaptureSound = "x"
        }
        
        //get copy to clipboard setting
        if UserDefaults.standard.string(forKey: "copyToClipSetting") == "1"
        {
            copyToClipSetting = "c"
        }
        else {
            copyToClipSetting = ""
        }
        
        //get timer setting
        if UserDefaults.standard.string(forKey: "TimerSetting") == "1"
        {
            delay = "T" + UserDefaults.standard.string(forKey: "delaySeconds")!
        }
        else {
            delay = ""
        }
        
        //get capture cursor setting
        if UserDefaults.standard.string(forKey: "captureCursorSetting") == "1"
        {
            captureCursorSetting = "C"
        }
        else {
            captureCursorSetting = ""
        }
        
        //get thumbnail preview setting
        if UserDefaults.standard.string(forKey: "showThumbSetting") == "1"
        {
            captureCursorSetting = "u"
        }
        else {
            captureCursorSetting = ""
        }
        
        //get thumbnail preview setting
        if UserDefaults.standard.string(forKey: "openPreviewSetting") == "1"
        {
            openPreviewSetting = "P"
        }
        else {
            openPreviewSetting = ""
        }
        
        //get open mail setting
        if UserDefaults.standard.string(forKey: "openMailSetting") == "1"
        {
            openMailSetting = "M"
        }
        else {
            openMailSetting = ""
        }
        
        //get open mail setting
        if UserDefaults.standard.string(forKey: "openMessagesSetting") == "1"
        {
            openMessagesSetting = "I"
        }
        else {
            openMessagesSetting = ""
        }
        
        
        //get date time setting
        if UserDefaults.standard.string(forKey: "appendDateTimeSetting") == "1"
        {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH.mm.ss"

            appendDateTimeSetting = " " + dateFormatter.string(from: date)

        }
        else {
            appendDateTimeSetting = ""
        }
    
    }
    
//    private func windowWillClose(_ sender: Any) {
//        exit(0)
//    }
    
    func userDesktop() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        let  userDesktopDirectory = paths[0]
        return userDesktopDirectory
    }
    
    //User clicks Capture button
    @IBAction func MainCaptureBtnClicked(_ sender: Any) {
        
        //Get and set prefs before capture...
        setPrefs()
        
        intsuffix = intsuffix+1
    //    let destinationPath:String = dest + filename + appendDateTimeSetting + String(intsuffix) + "." + format
        let destinationPath:String = dest + filename + appendDateTimeSetting + "." + format

        // Hide the App
        NSApp.hide(nil)
        
        //print(self.playCaptureSound)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            var settings: [String] = [
                self.delay,
                self.openPreviewSetting,
                self.showThumbSetting,
                self.copyToClipSetting,
                self.captureCursorSetting,
                self.playCaptureSound,
                self.openMailSetting,
                self.openMessagesSetting
            ]
            //print(settings)
            //print(self.settings)
            
//            for ss in settings {
//                print(ss, terminator: "") // output 1 2 3 4 5
//                let combinedSettings:String = print(ss, terminator: "")
//            }
            
            var combinedSettings: String?
                for s in settings {
                    if combinedSettings == nil {
                        combinedSettings = s
                    } else {
                    combinedSettings = combinedSettings! + "" + s
                    }
                }
                print(combinedSettings!) // output - 1, 2, 3, 4, 5
            
            switch(self.mode) {
                

            // Screen
            case 1 :
//                var combinedSettings: String?
                shell(launchPath:self.launchPathString, arguments:["-" + combinedSettings! + "t"+self.format,destinationPath])
                NSApp.activate(ignoringOtherApps: true)
                break;
            // Window
            case 2 :
                shell(launchPath:self.launchPathString, arguments:["-" + combinedSettings! + "it"+self.format,destinationPath])
                NSApp.activate(ignoringOtherApps: true)
                break;
            // Selection
            case 3 :
                shell(launchPath:self.launchPathString, arguments:["-" + combinedSettings! + "wt"+self.format,destinationPath])
                NSApp.activate(ignoringOtherApps: true)
                break;
            // Recording
            case 4 :
                shell(launchPath:self.launchPathString, arguments:["-" + combinedSettings! + "v"+self.format,destinationPath])
                NSApp.activate(ignoringOtherApps: true)
                break;
            // Recording with Audio
            case 5 :
                shell(launchPath:self.launchPathString, arguments:["-" + combinedSettings! + ""+self.format,destinationPath])
                NSApp.activate(ignoringOtherApps: true)
                break;
            default :
                shell(launchPath:"/usr/sbin/screencapture", arguments:[destinationPath])
                NSApp.activate(ignoringOtherApps: true)
                break;
            }
        }
        
        // Play system beep if the user said so...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if UserDefaults.standard.string(forKey: "beepSetting") == "1"
            {
                NSSound.beep()
            }
        }
        
       // print (destinationPath)
        
        if UserDefaults.standard.string(forKey: "savePhotoSetting") == "1"
        {
            PHPhotoLibrary.shared().performChanges ({
            //let image = NSImage(contentsOfFile: destinationPath)
            //let imageData =
           
            func loadFileFromLocalPath(_ localFilePath: String) ->Data? {
                return try? Data(contentsOf: URL(fileURLWithPath: destinationPath))
            }
                
            let assetType:PHAssetResourceType = .photo
            let request:PHAssetCreationRequest = .forAsset()
            let createOptions:PHAssetResourceCreationOptions = PHAssetResourceCreationOptions()
                createOptions.originalFilename = self.filename
                    request.addResource(with: assetType, data: loadFileFromLocalPath(destinationPath)!, options: createOptions)

                }, completionHandler: { success, error in
                    if success == true && error == nil {
                        print("Success saving image")
                    } else {
                        print("Error saving image: \(error!.localizedDescription)")
                    }
                })

        }
        
        }
        
    @IBOutlet weak var screenCaptureToggleBtn: NSButton!
    @IBOutlet weak var windowCaptureToggleBtn: NSButton!
    @IBOutlet weak var selectionCaptureToggleBtn: NSButton!
    @IBOutlet weak var movieCaptureToggleBtn: NSButton!
    @IBOutlet weak var movieSelectionCaptureToggleBtn: NSButton!
    
    // MODE SETTINGS 
    
    @IBAction func screenCaptureToggle(_ sender: Any) {
        screenCaptureToggleBtn.isBordered = true
        windowCaptureToggleBtn.state = NSControl.StateValue.off
        selectionCaptureToggleBtn.state = NSControl.StateValue.off
        movieCaptureToggleBtn.state = NSControl.StateValue.off
        movieSelectionCaptureToggleBtn.state = NSControl.StateValue.off
        movieCaptureToggleBtn.isBordered = false
        movieSelectionCaptureToggleBtn.isBordered = false
        windowCaptureToggleBtn.isBordered = false
        selectionCaptureToggleBtn.isBordered = false
        self.mode = 1
    }

    @IBAction func selectionCaptureToggle(_ sender: Any) {
        selectionCaptureToggleBtn.isBordered = true
        screenCaptureToggleBtn.state = NSControl.StateValue.off
        windowCaptureToggleBtn.state = NSControl.StateValue.off
        screenCaptureToggleBtn.isBordered = false
        windowCaptureToggleBtn.isBordered = false
        movieCaptureToggleBtn.state = NSControl.StateValue.off
        movieSelectionCaptureToggleBtn.state = NSControl.StateValue.off
        movieCaptureToggleBtn.isBordered = false
        movieSelectionCaptureToggleBtn.isBordered = false
        self.mode = 2
    }
    
    @IBAction func windowCaptureToggle(_ sender: Any) {
        windowCaptureToggleBtn.isBordered = true
        screenCaptureToggleBtn.state = NSControl.StateValue.off
        selectionCaptureToggleBtn.state = NSControl.StateValue.off
        screenCaptureToggleBtn.isBordered = false
        selectionCaptureToggleBtn.isBordered = false
        movieCaptureToggleBtn.state = NSControl.StateValue.off
        movieSelectionCaptureToggleBtn.state = NSControl.StateValue.off
        movieCaptureToggleBtn.isBordered = false
        movieSelectionCaptureToggleBtn.isBordered = false
        self.mode = 3
    }

    @IBAction func movieCaptureToggle(_ sender: Any) {
        movieCaptureToggleBtn.isBordered = true
        windowCaptureToggleBtn.state = NSControl.StateValue.off
        screenCaptureToggleBtn.state = NSControl.StateValue.off
        selectionCaptureToggleBtn.state = NSControl.StateValue.off
        windowCaptureToggleBtn.isBordered = false
        screenCaptureToggleBtn.isBordered = false
        selectionCaptureToggleBtn.isBordered = false
        self.mode = 4
    }
    
    @IBAction func movieSelectionCaptureToggle(_ sender: Any) {
        movieSelectionCaptureToggleBtn.isBordered = true
        windowCaptureToggleBtn.state = NSControl.StateValue.off
        screenCaptureToggleBtn.state = NSControl.StateValue.off
        selectionCaptureToggleBtn.state = NSControl.StateValue.off
        movieCaptureToggleBtn.state = NSControl.StateValue.off
        windowCaptureToggleBtn.isBordered = false
        screenCaptureToggleBtn.isBordered = false
        selectionCaptureToggleBtn.isBordered = false
        movieCaptureToggleBtn.isBordered = false
        self.mode = 5
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
