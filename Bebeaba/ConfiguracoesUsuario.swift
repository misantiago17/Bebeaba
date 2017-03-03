//
//  ConfiguracoesUsuario.swift
//  Bebeaba
//
//  Created by Michelle Beadle on 18/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects

class ConfiguracoesUsuario: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nome: AkiraTextField!
    @IBOutlet weak var ultimaData: AkiraTextField!
    
    var alerta = false
    var nomeOrig = ""
    var semOrig = ""
    var usuario = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Rectangle 3")
        self.view.insertSubview(backgroundImage, at: 0)

        
        nome.delegate = self
        ultimaData.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Home.dissmissKeyboard))
        view.addGestureRecognizer(tap)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        let requestUser: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            
            let resultsUser = try context.fetch(requestUser)
            let user = resultsUser
            
            for item in user {
                
                let nomeM = item.value(forKey: "nome") as! String
                let semana = item.value(forKey: "semana") as! String
                
                nomeOrig = nomeM
                semOrig = semana
                
                nome.text = nomeM
                ultimaData.text = semana
                
                usuario = item
            }
            
        } catch {
            print("Não foi possivel resgatar dados")
        }
    }

    @IBAction func salvar(_ sender: Any) {
        let newName = nome.text
        let newDate = ultimaData.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let semanaDate = dateFormatter.date(from: ultimaData.text!)
        let today = Date()
        
        var diaValido = Date()
        
        if semanaDate != nil {
            
            let dateComponent = NSDateComponents()
            dateComponent.day = 280
            let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))
            
            diaValido = (calendar?.date(byAdding: dateComponent as DateComponents , to: semanaDate!, options: .matchLast))!
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        if( newName!.isEmpty || newDate!.isEmpty) {
            
            let nada = UIAlertController(title: "Alert", message: "Há campos não preenchidos", preferredStyle: UIAlertControllerStyle.alert)
            nada.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(nada, animated: true, completion: nil)
            alerta = true
        }
            
        else if(newDate!.characters.count < 10) {
            
            let semanaLim = UIAlertController(title: "Alert", message: "A data do ultimo dia da menstruação deve estar completa.", preferredStyle: UIAlertControllerStyle.alert)
            semanaLim.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(semanaLim, animated: true, completion: nil)
            alerta = true
            
            ultimaData.text = ""
        }
            
        else if semanaDate == nil {
            
            let tempoLongo = UIAlertController(title: "Alert", message: "Coloque uma data válida.", preferredStyle: UIAlertControllerStyle.alert)
            tempoLongo.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(tempoLongo, animated: true, completion: nil)
            alerta = true
            
            ultimaData.text = ""
        }
            
        else if semanaDate! > today {
            
            let tempoLongo = UIAlertController(title: "Alert", message: "Coloque uma data menor que a atual.", preferredStyle: UIAlertControllerStyle.alert)
            tempoLongo.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(tempoLongo, animated: true, completion: nil)
            alerta = true
            
            ultimaData.text = ""
        }
            
        else if diaValido < today {
            
            let tempoLongo = UIAlertController(title: "Alert", message: "Seu bebê já deveria ter nascido.", preferredStyle: UIAlertControllerStyle.alert)
            tempoLongo.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(tempoLongo, animated: true, completion: nil)
            alerta = true
            
            ultimaData.text = ""
        }
        
        if(alerta == false) {
            
            usuario.setValue(nome.text, forKey: "nome")
            usuario.setValue(ultimaData.text, forKey: "semana")
                        
            //salva usuário
            
            do {
                try context.save()
            } catch {
                print("error")
            }
            
        }
        
        if alerta == false {
            dismiss(animated: true, completion: nil)
        }
        
        alerta = false
    }
    
    func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == ultimaData {
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
            
            var originalText = ultimaData.text
            
            //Put / space after 2 digit
            if range.location == 2 || range.location == 5 {
                
                originalText?.append("/")
                ultimaData.text = originalText
            }
            
        }
        
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
