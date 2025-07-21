//
//  capture.swift
//  qs2
//
//  Created by Joshua Coventry on 29/04/2018.
//  Copyright © 2018 Joshua Coventry. All rights reserved.
//
 
import Foundation
//import SwiftShell

func shell(launchPath: String, arguments: [String]) -> String {
    
    let process = Process()
    process.launchPath = launchPath
    process.arguments = arguments
    
    let pipe = Pipe()
    process.standardOutput = pipe
    process.launch()
    
    let output_from_command = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8)!
    
    // remove the trailing new-line char
    if output_from_command.count > 0 {
        let lastIndex = output_from_command.index(before: output_from_command.endIndex)
        return String(output_from_command[output_from_command.startIndex ..< lastIndex])
    }
    return output_from_command
}
