//
//  Detalhes.swift
//  Bebeaba
//
//  Created by Michelle Beadle on 20/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import CoreData

class Detalhes: UIViewController {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var detalhes: UILabel!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var exameFeitoSwitch: UISwitch!
    @IBOutlet weak var exameFeitoLabel: UILabel!
    @IBOutlet weak var atrasoImg: UIImageView!
    @IBOutlet weak var atrasoLabel: UILabel!
    @IBOutlet var viewDetalhes: UIView!
    
    var exame = Exame()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Rectangle 3")
        self.view.insertSubview(backgroundImage, at: 0)

        
        if exame.tipo == "historico" {
            exameFeitoSwitch.isHidden = true
            exameFeitoLabel.isHidden = true
        }
        
        
         viewDetalhes.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        nome.text = exame.nome
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        hora.text = timeFormatter.string(from: exame.hora as! Date)
        
        let diaFormatter = DateFormatter()
        diaFormatter.dateFormat = "dd/MM/yyyy"
        data.text = diaFormatter.string(from: exame.data as! Date)
        
        if exame.local == "" {
            local.isHidden = true
        }else{
            local.text = exame.local
        }
        if exame.descricao == "" {
            detalhes.isHidden = true
        } else {
            detalhes.text = exame.descricao
        }
        if exame.tipo == "atrasado" {
            atrasoImg.isHidden = false
            atrasoLabel.isHidden = false
        } else {
            atrasoImg.isHidden = true
            atrasoLabel.isHidden = true
        }

        
    }
    
    @IBAction func Retornar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func trocaTipo(_ sender: Any) {
        if exameFeitoSwitch.isOn == true{
            mudarTipo(tipoMudado: "historico")
        }else{
            mudarTipo(tipoMudado: exame.tipo!)
        }
    }
    
    func mudarTipo (tipoMudado: String){
        
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        let requestUser: NSFetchRequest<Exame> = Exame.fetchRequest()
        
        do{
            let resultsUser = try context.fetch(requestUser)
            let lista = resultsUser
            
            for item in lista {
                if (item.value(forKey: "data") as! NSDate).isEqual(to: exame.data as! Date) {
                    if (item.value(forKey: "hora") as! NSDate).isEqual(to: exame.hora as! Date) {
                        item.setValue(tipoMudado, forKey: "tipo")
                    }
                }
            }
        } catch {
            print("Não foi possivel encontrar")
        }
        
        //salva mudanças
        
        do{
            try context.save()
        }
        catch {
            print("error")
        }
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
