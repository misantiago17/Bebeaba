//
//  Home.swift
//  Bebeaba
//
//  Created by Alline Pedreira on 07/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import TextFieldEffects
import CoreData

class Home: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var name: AkiraTextField!
    @IBOutlet weak var pregnancyWeek: AkiraTextField!
    
     var alerta = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        pregnancyWeek.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Home.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
    }

    @IBAction func cadastrarUsuario(_ sender: Any) {
        let nome = name.text
        let semana = pregnancyWeek.text
        
        if( nome!.isEmpty || semana!.isEmpty) {
            
            let nada = UIAlertController(title: "Alert", message: "Há campos não preenchidos", preferredStyle: UIAlertControllerStyle.alert)
            nada.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(nada, animated: true, completion: nil)
            alerta = true
        }
            
        else if(semana!.characters.count > 2) {
            
            let semanaLim = UIAlertController(title: "Alert", message: "A semana da gravidez deve ter 2 dígitos.", preferredStyle: UIAlertControllerStyle.alert)
            semanaLim.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(semanaLim, animated: true, completion: nil)
            alerta = true
            
            pregnancyWeek.text = ""
        }
            
        else if(Double(semana!)! > 50) {
            let tempoLongo = UIAlertController(title: "Alert", message: "Seu bebê já deveria ter nascido. Procure um médico.", preferredStyle: UIAlertControllerStyle.alert)
            tempoLongo.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(tempoLongo, animated: true, completion: nil)
            alerta = true
            
            name.text = ""
            pregnancyWeek.text = ""
        }
        

        //PARTE DO CORE DATA
        
//        let context = (UIApplication.sharedApplication.delegate as! AppDelegate).managedObjectContext
//        
//        if(alerta == false){
//            let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as NSManagedObject
//            
//            
//            newUser.setValue(nomeTxt.text, forKey: "nome")
//            newUser.setValue(SemanaTxt.text, forKey: "semana")
//            
//            
//            //salva usuário
//            
//            do {
//                try context.save()
//            } catch {
//                print("error")
//            }
//            
//            print("4")
//            performSegueWithIdentifier("gohome", sender: self)
//            
//            
//        }
//        alerta = false
//        print("alerta")
    }
    
    
    //ver se esse prepareForSegue ainda é necessário
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("Caracaaaaaaaaa")
//        
//        if segue.identifier == "gohome" {
//            
//            let tabBar: UITabBarController = segue.destinationViewController as! UITabBarController
//            let desView: Perfil = tabBar.viewControllers?.first as! Perfil
//            
//            print(SemanaTxt.text)
//            desView.semanaU = SemanaTxt.text!
//            
//            
//        }
//        
//    }
    
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
