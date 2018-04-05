//
//  ViewController.swift
//  Alternative Saving
//
//  Created by Matt on 05.04.18.
//  Copyright © 2018 Matt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let management: FileManagement = {
        return FileManagement(filename: "TryMe.txt")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        management.write("Hello Herby :), how are you?")
        guard let content = management.read() else {
            print("Doesn't worked.")
            return
        }
        
        print(content)
    }


}

