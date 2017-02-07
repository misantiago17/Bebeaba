//
//  Home.swift
//  Bebeaba
//
//  Created by Alline Pedreira on 07/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import TextFieldEffects

class Home: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var nomeTxt: AkiraTextField!
    @IBOutlet weak var semanaTxt: AkiraTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeTxt.delegate = self
        semanaTxt.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Home.dissmissKeyboard))
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

}
