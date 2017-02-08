//
//  NewExam.swift
//  Bebeaba
//
//  Created by Alline Pedreira on 07/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import TextFieldEffects

class NewExam: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var name: AkiraTextField!
    @IBOutlet weak var details: AkiraTextField!
    @IBOutlet weak var local: AkiraTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        details.delegate = self
        local.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewExam.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK Botões 
    
    @IBAction func cancelar(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    

}
