//
//  ViewController.swift
//  CoreDataLesson
//
//  Created by MP Mac on 21/04/2017.
//  Copyright © 2017 MP Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var i = 0

    @IBAction func smilePressed(_ sender: UIButton) {
        smilePress += 1
//        print("Smile pressed")
        
    }
    
    @IBOutlet weak var smilePressedResult: UILabel!
    var smilePress: Int = 0 {
        didSet {
            smilePressedResult.text = "\(smilePress)"
        }
    }
    
    
    @IBAction func plainPressed(_ sender: UIButton) {
        plainPress += 1
//        print("Plain pressed")
    }
    
    @IBOutlet weak var plainPressedResult: UILabel!
    var plainPress: Int = 0 {
        didSet {
            plainPressedResult.text = "\(plainPress)"
        }
    }
    
    @IBAction func sadPressed(_ sender: UIButton) {
        sadPress += 1
//        print("Sad pressed")
    }
    @IBOutlet weak var sadPressedResult: UILabel!
    var sadPress: Int = 0 {
        didSet {
            sadPressedResult.text = "\(sadPress)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smilePress = 0
        plainPress = 0
        sadPress = 0
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


