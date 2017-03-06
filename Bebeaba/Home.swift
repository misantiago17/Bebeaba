
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
    
    var name : UITextField!
    var pregnancyWeek: UITextField!
    
    var alerta = false
    
    //Devices
    let modelName = UIDevice.current.modelName
    let widhtSE: CGFloat = 320
    let heightSE: CGFloat = 568
    var screenSize = UIScreen.main.bounds

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factorX = screenSize.width/widhtSE
        let factorY = screenSize.height/heightSE

        // Logo Image
        let logoImage = UIImageView(image: UIImage(named:"logo"))
        logoImage.frame = CGRect(x: 124*factorX, y: 44*factorY, width: 72*factorX, height: 100*factorY)
        self.view.addSubview(logoImage)
        
        // Name textField
        let placeholder = NSAttributedString(string: "Nome", attributes: [NSForegroundColorAttributeName : UIColor.gray])
        name = UITextField(frame: CGRect(x: 36*factorX, y: 211*factorY, width: 249*factorX, height: 16*factorY))
        name.attributedPlaceholder = placeholder
        name.font = UIFont(name: "System", size: 13)
        self.view.addSubview(name)
        
        // PregnancyWeek textField
        let placeholderweek = NSAttributedString(string: "Última data da menstruação", attributes: [NSForegroundColorAttributeName : UIColor.gray])
        pregnancyWeek = UITextField(frame: CGRect(x: 36*factorX, y: 266*factorY, width: 249*factorX, height: 16*factorY))
        pregnancyWeek.attributedPlaceholder = placeholderweek
        pregnancyWeek.font = UIFont(name: "System", size: 13)
        pregnancyWeek.keyboardType = .numberPad
        self.view.addSubview(pregnancyWeek)

        //textField delegate
        name.delegate = self
        pregnancyWeek.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Home.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Add Line 1
        let lineView = UIView(frame: CGRect(x: 35*factorX, y: 233.5*factorY, width: 250*factorX, height: 1*factorY))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor(red: 255/255, green: 145/255, blue: 164/255, alpha: 1).cgColor
        self.view.addSubview(lineView)
        
        // Add Line 2
        let lineView2 = UIView(frame: CGRect(x: 35*factorX, y: 289.5*factorY, width: 250*factorX, height: 1*factorY))
        lineView2.layer.borderWidth = 1.0
        lineView2.layer.borderColor = UIColor(red: 255/255, green: 145/255, blue: 164/255, alpha: 1).cgColor
        self.view.addSubview(lineView2)
        
        // Button
        let button = UIButton(type: .system) // let preferred over var here
        button.frame = CGRect(x: 114*factorX, y: 345*factorY, width: 92*factorX, height: 38*factorY)
        button.backgroundColor = UIColor(red: 255/255, green: 145/255, blue: 164/255, alpha: 1)
        button.setTitle("Bem-vinda", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.addTarget(self, action: #selector(Home.cadastrarUsuario(_:)), for: UIControlEvents.touchUpInside)
        button.layer.cornerRadius = 10
        self.view.addSubview(button)
        
        
        
        
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
            
            let semanaLim = UIAlertController(title: "Alert", message: "A data do ultimo dia da menstruação deve estar completa (dd/mm/aaaa)", preferredStyle: UIAlertControllerStyle.alert)
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
            performSegue(withIdentifier: "nextView", sender: self)
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
