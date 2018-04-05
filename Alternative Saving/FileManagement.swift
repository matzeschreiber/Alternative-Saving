//
//  FileManager.swift
//  Alternative Saving
//
//  Created by Matt on 05.04.18.
//  Copyright © 2018 Matt. All rights reserved.
//

import Foundation

class FileManagement {
    
    //MARK: Properties
    var filename: String
    private let filemanager: FileManager = {
        return FileManager()
    }()
    
    //Constructor or initializer
    init(filename name: String) {
        filename = name
        if !filemanager.fileExists(atPath: name) {
            createFileAt(filename: self.filename)
        }
    }
    
    //MARK: Method
    
    //Reads 'filename's' content
    func read() -> String? {
        var savedContent: String? = nil
        guard let url = getUrl(filename: filename) else { return nil }
        do {
            savedContent = try String(contentsOf: url)
        } catch {
            print("\(FileError.WritingError.toString()): \(error)")
        }
        return savedContent
    }
    
    //Writes to 'filename'.
    func write(_ content: String) {
        guard let url = getUrl(filename: filename) else { return }
        do {
            try content.write(to: url, atomically: false, encoding: .utf8)
        } catch {
            print("\(FileError.ReadingError.toString()): \(error)")
        }
    }
    
    private func getUrl(filename name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(name)
    }
    
    private func createFileAt(filename name: String) {
            FileManager.default.createFile(atPath: name, contents: nil, attributes: nil)
    }
    
    private func createFileAt(filename name: String, content: String?=nil) -> Bool {
        if let content = content {
            let data = Data(base64Encoded: content)
            FileManager.default.createFile(atPath: name, contents: data, attributes: nil)
            return true
        }
        return false
    }
}

enum FileError: String {
    case ReadingError
    case WritingError
    case FileDoesNotExists
    
    func toString() -> String {
        return self.rawValue
    }
}
