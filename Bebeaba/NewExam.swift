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
    
    
    
    
    
    var anterior = false
    
    var data = NSDate()
    var edit = false
    var exame = [Exame]()
    var horaI = NSDate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Rectangle 3")
        self.view.insertSubview(backgroundImage, at: 0)

        
        name.delegate = self
        details.delegate = self
        local.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewExam.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    // MARK: Coredata
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        if edit == true{
            
            let fetchRequest: NSFetchRequest<Exame> = Exame.fetchRequest()

            do{
                let results = try context.fetch(fetchRequest)
                let lista = results 
                
                for item in lista{
                    if (item.value(forKey: "data") as! NSDate).isEqual(to: data as Date){
                        if (item.value(forKey: "hora") as! NSDate).isEqual(to: horaI as Date){
                            exame += [item]
                        }
                    }
                }
             
                
                if results.count>0{
                    print(exame)
                }else{
                    print("Não há itens no BD")
                }
            } catch {
                print("Não foi possivel resgatar dados")
            }
            
            for item in exame{
                
                name.text = item.value(forKey: "nome") as? String
                local.text = item.value(forKey: "local") as? String
                details.text = item.value(forKey: "descricao") as? String
                
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "HH:mm"
                let horario = timeFormatter.string(from: horaI as Date)
                let horaReal = timeFormatter.date(from: horario)
                
                hora.setDate(horaReal!, animated: true)
                
                
            }
            
        }
        
    }
    
    
    
    //MARK: Botões
    

    @IBAction func Voltar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func verificaDia() {
        
        let calendario = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        let diaAnterior = calendario.isDateInToday(data as Date)
        
        if diaAnterior == false {
            if (data as Date) < Date() {
                anterior = true
            }
        }
        
    }

    @IBAction func SalvarUsuario(_ sender: Any) {
        
        verificaDia()
        
        let dia = data
        let tipo: String
        if anterior == false {
            tipo = "atual"
        } else {
            tipo = "atrasado"
        }
        let hora = self.hora.date
        let name = self.name.text
        let place = local.text
        let description = details.text
        var alerta = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        if (name!.isEmpty) {
            
            let vazio = UIAlertController(title: "Alert", message: "Digite o nome do Exame", preferredStyle: UIAlertControllerStyle.alert)
            vazio.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(vazio, animated: true, completion: nil)
            alerta = true
            
        }
        
        if(alerta == false){
            if edit == true{
                for item in exame{
                    item.setValue(hora, forKey: "hora")
                    item.setValue(name, forKey: "nome")
                    item.setValue(place, forKey: "local")
                    item.setValue(description, forKey: "descricao")
                }
            }else {
                let newExam = NSEntityDescription.insertNewObject(forEntityName: "Exame", into: context) as NSManagedObject
                
                newExam.setValue(dia, forKey: "data")
                newExam.setValue(hora, forKey: "hora")
                newExam.setValue(description, forKey: "descricao")
                newExam.setValue(place, forKey: "local")
                newExam.setValue(name, forKey: "nome")
                newExam.setValue(tipo, forKey: "tipo")
            }
            
            //salva exame
            
            do {
                try context.save()
            } catch {
                print("error")
            }
        }
        
        if alerta == false {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
