//
//  ExamesFeitos.swift
//  Bebeaba
//
//  Created by Michelle Beadle on 08/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import CoreData

class ExamesFeitos: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ExamesFeitos: UITableView!
    
    var exame = [Exame]()
    var exameHistorico = [Exame]()
//    var exameTotal = [[Exame()],[Exame()],[Exame()]]
//    var exameAtraso = [Exame]()
//    var exameFuturo = [Exame]()
//    var SectionName = ["exames atrasados", "exames futuros", "exames feitos"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ExamesFeitos.delegate = self
        ExamesFeitos.dataSource = self
        
    }
    
    
    //MARK: Preenche os arrays de exames
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        
        let fetchRequest: NSFetchRequest<Exame> = Exame.fetchRequest()

        do{
            let results = try context.fetch(fetchRequest)
            exame = results
            
            if results.count>0{
                print("esses foram os resultados encontrados no BD: \(results.count)")
            }else{
                print("Não há itens no BD")
            }
        } catch {
            print("Não foi possivel resgatar dados")
        }
        
        //        exameTotal[0].removeAll()
        //        exameTotal[1].removeAll()
        //        exameTotal[3].removeAll()
        exameHistorico.removeAll()
        for item in exame{
            if (item.value(forKey: "tipo") as! String == "historico"){
                // exameTotal[0] += [item]
                exameHistorico += [item]
            }
            //            } else if (item.valueForKey("tipo") as! String == "futuro"){
            //                exameTotal[1] += [item]
            //            } else if (item.valueForKey("tipo") as! String == "atrasado"){
            //                exameTotal[2] += [item]
            //            }
        }
        
        //        for item in exame{
        //            if (item.valueForKey("tipo") as! String == "historico"){
        //                exameHistorico += [item]
        //            }
        //            if (item.valueForKey("tipo") as! String == "atrasados"){
        //                exameAtraso += [item]
        //            }
        //            if (item.valueForKey("tipo") as! String == "atual"){
        //                exameFuturo += [item]
        //            }
        //        }
        //
        //        ordenaExame(exameHistorico)
        //        ordenaExame(exameAtraso)
        //        ordenaExame(exameFuturo)
        //        if(exameTotal.count>0){
        //            exameTotal[0].removeAll()
        //            exameTotal[1].removeAll()
        //            exameTotal[2].removeAll()
        //        }
        
        //        exameTotal[0] = exameAtraso
        //        exameTotal[1] = exameFuturo
        //        exameTotal[2] = exameHistorico
        
        ExamesFeitos.reloadData()
    }
    
    //MARK: Funções auxiliares
    
    func ordenaExame( exame: [Exame]){
        var exame = exame
        var fim = exame.endIndex - 1
        while fim > 0{
            var maior = 0
            for item in exame{
                let i1 = exame.index(of: item)
                if(item != exame[0]){
             
                    if(i1! <= fim){
                        
                        let horaPrim = item.value(forKey: "hora") as! NSDate
                        let horaSeg = exame[maior].value(forKey: "hora") as! NSDate
                        
                        if(horaPrim.isEqual(to: horaSeg as Date) == false){
                            if(horaPrim.laterDate(horaSeg as Date) == horaPrim as Date){
                                maior = i1!
                                print("i1:\(i1), fim: \(fim), maior:\(maior)")
                            }
                        }
                    }
                }
            }
            
            if(fim != maior){
                let subtituido = exame[fim]
                let substituto = exame[maior]
                exame.insert(substituto, at: fim)
                exame.remove(at: fim+1)
                exame.insert(subtituido, at: maior)
                exame.remove(at: maior+1)
            }
            fim -= 1
        }
        
    }
    
    //MARK: TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return /*SectionName.count*/ 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        var rowCount = 0
        //        if section == 0 {
        //            rowCount = exameTotal[0].count
        //        }
        //        if section == 1 {
        //            rowCount = exameTotal[1].count
        //        }
        //        if section == 2 {
        //            rowCount = exameTotal[2].count
        //        }
        //        return rowCount
        return exameHistorico.count
        return 1
    }
    
    //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
    //        return SectionName[section]
    //    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        //let exam = exameTotal[indexPath.section][indexPath.row]
        let exam = exameHistorico[indexPath.row]
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        
        let hora = exam.value(forKey: "hora") as? NSDate
        let horario = timeFormatter.string(from: hora! as Date)
        let dia = exam.value(forKey: "data") as? NSDate
        let data = dateFormater.string(from: dia! as Date)
        
        cell.nome.text = exam.value(forKey: "nome") as? String
        cell.horario.text = horario
        cell.data.text = data
        if(exam.value(forKey: "local") as! String == ""){
            cell.local.isHidden = true
        }else{
            cell.local.text = exam.value(forKey: "local") as? String
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "detalhe"){
//            let indexPaths = HistoricoTableView.indexPathForSelectedRow
//            let indexPath = indexPaths! as NSIndexPath
//            let exam = exameHistorico[indexPath.row]
//            let vc = segue.destinationViewController as! ExameViewController
//            vc.diaI = exam.valueForKey("data") as! NSDate
//            vc.horaI = exam.valueForKey("hora") as! NSDate
//            vc.tipoDoExame = exam.valueForKey("tipo") as! String
//            vc.historico = true
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
