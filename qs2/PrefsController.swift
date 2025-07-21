//
//  PrefsController.swift
//  qs2
//
//  Created by Joshua Coventry on 30/04/2018.
//  Copyright © 2018 Joshua Coventry. All rights reserved.
//

import Foundation
import Cocoa
//import LaunchAtLogin

class PrefsController: NSViewController, NSWindowDelegate {
    
    
//    @IBAction func toggleLogin(_ sender: Any) {
//        LaunchAtLogin.Toggle()
//    }
    
    private var selectedFolder:URL = FileManager.default.homeDirectoryForCurrentUser
    
   // @IBOutlet weak var screenCaptureShortcutField: MASShortcutView!
   // @IBOutlet weak var windowCaptureShortcutField: MASShortcutView!
   // @IBOutlet weak var selectionCaptureShortcutField: MASShortcutView!
    @IBOutlet weak var filepathTextInput: NSTextField!
    @IBOutlet weak var fileFormatPopUp: NSPopUpButton!
    @IBOutlet weak var fileNameField: NSTextField!
    

    override func viewDidLoad() {
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        switch(title) {
            case "General":
                preferredContentSize = NSSize(width: 434, height: 171)
                break;
            case "Capture":
                preferredContentSize = NSSize(width: 434, height: 332)
                break;
            case "Watermark":
                preferredContentSize = NSSize(width: 434, height: 181)
                break;
            case "Donate":
                preferredContentSize = NSSize(width: 434, height: 135)
                break;
            default:
                preferredContentSize = NSSize(width: 434, height: 171)
                break;
        }
        
    }
    
    //User clicks to donate!
    @IBAction func donateClick(_ sender: NSButton) {
        if let url = URL(string: ""), NSWorkspace.shared.open(url) {
            print("default browser was successfully opened")
        }
    }
    
    //User has changed the file name so we need to set it
    @IBAction func fileNameChanged(_ sender: NSTextField) {
        let defaults = UserDefaults.standard
        
        if fileNameField.stringValue.isEmpty == false
        {
            defaults.set( fileNameField.stringValue , forKey: "filename")
            print(fileNameField.stringValue)
        }
        else
        {
            defaults.set( "Screenshot" , forKey: "filename")
            fileNameField.placeholderString = "Screenshot"
        }
    }
    
    //user has changed the file format so we need to set it
    @IBAction func fileFormatPopUpButton(_ sender: NSPopUpButton) {
        let defaults = UserDefaults.standard
        defaults.set(fileFormatPopUp.titleOfSelectedItem, forKey: "format")
    }
    
    //User clicks Choose... to choose path
    @IBAction func chooseFileBtnClicked(_ sender: NSButton) {
        
        guard let window = view.window else { return }
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.prompt = "Choose"
        
        panel.beginSheetModal(for: window) { (result) in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let selectedFolder = panel.urls[0]

                self.filepathTextInput.stringValue = selectedFolder.path
                UserDefaults.standard.set(selectedFolder.path, forKey: "filepath")
            }
        }
    
    }
    
}
