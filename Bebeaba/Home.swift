
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
        
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "Rectangle 3")!)
        
        name.delegate = self
        pregnancyWeek.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Home.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Logo Image
//        let logoImage = UIImageView(image: UIImage(named:"logo.png"))
//        logoImage.frame = CGRect(x: self.view.frame.width/3, y: 60, width: self.view.frame.width/3, height: self.view.frame.width/3)
//        self.view.addSubview(logoImage)
//        
//        // Button Image
//        let homeIcone = UIImageView(image: UIImage(named:"chocalho.png"))
//        homeIcone.frame = CGRect(x: 110, y: 365, width: 30, height: 30)
//        self.view.addSubview(homeIcone)
//
//        
    }
    

    @IBAction func cadastrarUsuario(_ sender: Any) {
        let nome = name.text
        let semana = pregnancyWeek.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let semanaDate = dateFormatter.date(from: pregnancyWeek.text!)
        let today = Date()
                
        var diaValido = Date()
        
        if semanaDate != nil {
            
            let dateComponent = NSDateComponents()
            dateComponent.day = 280
            let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))
            
            diaValido = (calendar?.date(byAdding: dateComponent as DateComponents , to: semanaDate!, options: .matchLast))!
        }
        
        if( nome!.isEmpty || semana!.isEmpty) {
            
            let nada = UIAlertController(title: "Alert", message: "Há campos não preenchidos", preferredStyle: UIAlertControllerStyle.alert)
            nada.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(nada, animated: true, completion: nil)
            alerta = true
        }
            
        else if(semana!.characters.count < 10) {
            
            let semanaLim = UIAlertController(title: "Alert", message: "A data do ultimo dia da menstruação deve estar completa.", preferredStyle: UIAlertControllerStyle.alert)
            semanaLim.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(semanaLim, animated: true, completion: nil)
            alerta = true
            
            pregnancyWeek.text = ""
        }

        else if semanaDate == nil {
            
            let tempoLongo = UIAlertController(title: "Alert", message: "Coloque uma data válida.", preferredStyle: UIAlertControllerStyle.alert)
            tempoLongo.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(tempoLongo, animated: true, completion: nil)
            alerta = true
            
            pregnancyWeek.text = ""
        }
            
        else if semanaDate! > today {
            
            let tempoLongo = UIAlertController(title: "Alert", message: "Coloque uma data menor que a atual.", preferredStyle: UIAlertControllerStyle.alert)
            tempoLongo.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(tempoLongo, animated: true, completion: nil)
            alerta = true
            
            pregnancyWeek.text = ""
        }
        
        else if diaValido < today {
            
            let tempoLongo = UIAlertController(title: "Alert", message: "Seu bebê já deveria ter nascido.", preferredStyle: UIAlertControllerStyle.alert)
            tempoLongo.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(tempoLongo, animated: true, completion: nil)
            alerta = true
            
            pregnancyWeek.text = ""
        }

        //MARK: CoreData
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        if(alerta == false){
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as NSManagedObject
            
            newUser.setValue(name.text, forKey: "nome")
            newUser.setValue(pregnancyWeek.text, forKey: "semana")
            
            //salva usuário
            
            do {
                try context.save()
            } catch {
                print("error")
            }
            
        }
        alerta = false
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == pregnancyWeek {
            //Range.Lenth will greater than 0 if user is deleting text - Allow it to replce
            if range.length > 0
            {
                return true
            }
            
            //Check for max length including the spacers we added
            if range.location >= 10
            {
                return false
            }
            
            var originalText = pregnancyWeek.text
            
            //Put / space after 2 digit
            if range.location == 2 || range.location == 5 {
                
                originalText?.append("/")
                pregnancyWeek.text = originalText
            }

        }
        
        return true
    }
    
    func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
