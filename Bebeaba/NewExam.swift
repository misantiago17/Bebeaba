//
//  NewExam.swift
//  Bebeaba
//
//  Created by Alline Pedreira on 07/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import TextFieldEffects
import CoreData

class NewExam: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var name: AkiraTextField!
    @IBOutlet weak var details: AkiraTextField!
    @IBOutlet weak var local: AkiraTextField!

    @IBOutlet weak var hora: UIDatePicker!
    
   // let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var data = NSDate()
    var edit = false
  //  var exame = [Exame]()
    var horaI = NSDate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        details.delegate = self
        local.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewExam.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    // MARK: Coredata
    
    override func viewWillAppear(_ animated: Bool) {
        
//        if edit == true{
//            let fetchRequest = NSFetchRequest(entityName: "Exame")
//            
//            do{
//                let results = try context.executeFetchRequest(fetchRequest)
//                let lista = results as! [Exame]
//                
//                for item in lista{
//                    if (item.valueForKey("data") as! NSDate).isEqualToDate(data){
//                        if (item.valueForKey("hora") as! NSDate).isEqualToDate(horaI){
//                            exame += [item]
//                        }
//                    }
//                }
//                
//                if results.count>0{
//                    print(exame)
//                }else{
//                    print("Não há itens no BD")
//                }
//            } catch {
//                print("Não foi possivel resgatar dados")
//            }
//            
//            for item in exame{
//                
//                nome.text = item.valueForKey("nome") as? String
//                local.text = item.valueForKey("local") as? String
//                descricao.text = item.valueForKey("descricao") as? String
//                
//                let timeFormatter = NSDateFormatter()
//                timeFormatter.dateFormat = "HH:mm"
//                let horario = timeFormatter.stringFromDate(horaI)
//                let horaReal = timeFormatter.dateFromString(horario)
//                
//                horarioDatePicker.setDate(horaReal!, animated: true)
//                
//                
//            }
//            
//        }
        
    }

    @IBAction func Voltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func Salvar(_ sender: Any) {
//        let dia = data
//        let tipo = "atual"
//        let hora = horarioDatePicker.date
//        let name = nome.text
//        let place = local.text
//        let description = descricao.text
//        var alerta = false
//        
//        if (name!.isEmpty) {
//            
//            let vazio = UIAlertController(title: "Alert", message: "Digite o nome do Exame", preferredStyle: UIAlertControllerStyle.Alert)
//            vazio.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(vazio, animated: true, completion: nil)
//            alerta = true
//            
//        }
//        
//        if(alerta == false){
//            if edit == true{
//                for item in exame{
//                    item.setValue(hora, forKey: "hora")
//                    item.setValue(name, forKey: "nome")
//                    item.setValue(place, forKey: "local")
//                    item.setValue(description, forKey: "descricao")
//                }
//            }else {
//                let newExam = NSEntityDescription.insertNewObjectForEntityForName("Exame", inManagedObjectContext: context) as NSManagedObject
//                
//                newExam.setValue(dia, forKey: "data")
//                newExam.setValue(hora, forKey: "hora")
//                newExam.setValue(description, forKey: "descricao")
//                newExam.setValue(place, forKey: "local")
//                newExam.setValue(name, forKey: "nome")
//                newExam.setValue(tipo, forKey: "tipo")
//            }
//            
//            //salva exame
//            
//            do {
//                try context.save()
//            } catch {
//                print("error")
//            }
//        }
//        
//        if alerta == false {
//            dismissViewControllerAnimated(true, completion: nil)
//        }

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
