//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var remainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.textView.layer.borderWidth = 1
        self.textView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        let length = (textView.text as NSString).length + (text as NSString).length - range.length
        
        if length > 140 {
            return false
        }
        remainLabel.text = "残り \(140 - length)"
        return true
    }
    
    @IBAction func submit(sender: UIButton) {
        let toitaObject = PFObject(className: "ToitaObject")
        toitaObject["text"] = textView.text
        toitaObject["userName"] = "User100"
        toitaObject.saveInBackground()
        
        let alert = UIAlertController(title: "", message: "投稿しました", preferredStyle:.Alert)
        let ok = UIAlertAction(title: "OK", style: .Default) {
            action in
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

