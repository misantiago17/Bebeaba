//
//  Calendario.swift
//  Bebeaba
//
//  Created by Michelle Beadle on 08/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import FSCalendar
import CoreData

class Calendario: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ExamesDia: UITableView!
    
//    var exame = [Exame]()
//    var exameDia = [Exame]()
    var dia = NSDate()
   // var edit = false
    var hora = NSDate()
    
  //  let managedContext = (UIApplication.sharedApplication.delegate as! AppDelegate).managedObjectContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExamesDia.delegate = self
        ExamesDia.dataSource = self

        // Do any additional setup after loading the view.
    }

    
    //MARK: Coredata
    
    override func viewWillAppear(_ animated: Bool) {
        
//        edit = false
//        
//        let fetchRequest = NSFetchRequest(entityName: "Exame")
//        
//        do{
//            let results = try managedContext.executeFetchRequest(fetchRequest)
//            exame = results as! [Exame]
//            
//            if results.count>0{
//                print(results.count)
//                self.examesTableView.reloadData()
//            }else{
//                print("Não há itens no BD")
//            }
//        } catch {
//            print("Não foi possivel resgatar dados")
//        }
//        
//        checkAtrasados()
//        
        let format = DateFormatter()
        let diaString = format.string(from: dia as Date)
        separaDia(diaDado: diaString)
        
        ExamesDia.reloadData()
        
    }
    
    
    //MARK: TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return /*ExamesDia.count*/ 1
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") /*as! TableViewCell*/
        
        //        if cell == nil
        //        {
        //            cell = MGSwipeTableCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        //        }
        
       // let exam = exameDia[indexPath.row]
        
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = "HH:mm"
////        let hora = exam.valueForKey("hora") as? NSDate
////        let horario = timeFormatter.stringFromDate(hora!)
//        
//        cell.nomeLabel.text = exam.valueForKey("nome") as? String
//        cell.horarioLabel.text = horario
//        if(exam.valueForKey("local") as! String == ""){
//            cell.localLabel.hidden = true
//        }else{
//            cell.localLabel.hidden = false
//            cell.localLabel.text = exam.valueForKey("local") as? String
//        }
//        if(exam.valueForKey("tipo") as! String == "atrasado"){
//            cell.atrasoLabel.hidden = false
//        } else if (exam.valueForKey("tipo") as! String == "atual"){
//            cell.atrasoLabel.hidden = true
//        }
//        
//        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor(), callback: {
//            (sender: MGSwipeTableCell!) -> Bool in
//            
//            self.managedContext.deleteObject(self.exameDia[indexPath.row])
//            self.exameDia.removeAtIndex(indexPath.row)
//            self.exame.removeAtIndex(indexPath.row)
//            
//            do {
//                try self.managedContext.save()
//            } catch {
//                print("Não foi possível retirar do BD")
//            }
//            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            
//            return true
//        })]
//        
//        //                cell.rightSwipeSettings.transition = MGSwipeTransition.Rotate3D
//        //        cell.rightExpansion.buttonIndex = 0
//        //        cell.leftExpansion.buttonIndex = 0
//        
//        
//        cell.leftButtons = [MGSwipeButton(title: "Check", icon: UIImage(named:"check.png"), backgroundColor: UIColor.greenColor(), callback: {
//            (sender: MGSwipeTableCell!) -> Bool in
//            
//            let exam = self.exameDia[indexPath.row]
//            
//            exam.setValue("historico", forKey: "tipo")
//            
//            print(exam)
//            
//            //salva mudanças
//            
//            do{
//                try self.managedContext.save()
//            }
//            catch {
//                print("error")
//            }
//            
//            self.exameDia.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            
//            return true
//        })
//            ,MGSwipeButton(title: "Edit", icon: UIImage(named:"fav.png"), backgroundColor: UIColor.blueColor(),callback: {
//                (sender: MGSwipeTableCell!) -> Bool in
//                
//                print("eu")
//                let exam = self.exameDia[indexPath.row]
//                
//                self.edit = true
//                self.hora = exam.valueForKey("hora") as! NSDate
//                self.performSegueWithIdentifier("MarcarExame", sender: nil)
//                
//                return true
//            })
//        ]
//        
//        //                cell.leftSwipeSettings.transition = MGSwipeTransition.Rotate3D
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
//        if editingStyle == .delete {
//            
////            managedContext.deleteObject(exame[indexPath.row])
//            exame.removeAtIndex(indexPath.row)
//            exameDia.removeAtIndex(indexPath.row)
//            do {
//                try managedContext.save()
//            } catch {
//                print("Não foi possível retirar do BD")
//            }
//            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
    }

    
    //MARK: Funções Auxiliares
    
//    func mudaTipoExame(item: Exame){
//        do{
//            let request = NSFetchRequest(entityName: "Exame")
//            let results = try managedContext.executeFetchRequest(request) as! [NSManagedObject]
//            
//            if(results.count > 0) {
//                let horaItem = item.valueForKey("hora") as! NSDate
//                let diaItem = item.valueForKey("data") as! NSDate
//                let tipo = "atrasado"
//                
//                for coisa in results{
//                    if (coisa.valueForKey("data") as! NSDate).isEqualToDate(diaItem){
//                        if (coisa.valueForKey("hora") as! NSDate).isEqualToDate(horaItem){
//                            coisa.setValue(tipo, forKey: "tipo")
//                            print(coisa)
//                        }
//                    }
//                }
//            }
//            else {
//                print("Não há usuários")
//            }
//        } catch {
//            print("Não foi possivel encontrar")
//        }
//        
//        //salva mudanças
//        
//        do{
//            try managedContext.save()
//        }
//        catch {
//            print("error")
//        }
//    }
    
    func checkAtrasados(){
        
        let formatDia = DateFormatter()
        formatDia.dateFormat = "dd/MM/yyyy"
        let formatHora = DateFormatter()
        formatHora.dateFormat = "HH:mm"
        
        let diaAtual = NSDate()
        
        let diaNow = formatDia.string(from: diaAtual as Date)
        let horaNow = formatHora.string(from: diaAtual as Date)
        let diaNowDate = formatDia.date(from: diaNow)
        let horaNowDate = formatHora.date(from: horaNow)
        
//        for item in exame{
//            let horaExame = formatHora.stringFromDate(item.valueForKey("hora") as! NSDate)
//            let diaExame = formatDia.stringFromDate(item.valueForKey("data") as! NSDate)
//            let horaExameDate = formatHora.dateFromString(horaExame)
//            let diaExameDate = formatDia.dateFromString(diaExame)
//            
//            if (item.valueForKey("tipo") as! String == "atual"){
//                if (diaExameDate!.isEqualToDate(diaNowDate!) == true){
//                    if(horaExameDate!.isEqualToDate(diaNowDate!) == false){
//                        if(horaExameDate!.earlierDate(horaNowDate!) == horaExameDate){
//                            print("Meu horario tá atrasado")
//                            mudaTipoExame(item)
//                        }
//                    }
//                } else if (diaExameDate!.earlierDate(diaNowDate!) == diaExameDate){
//                    print("Meu dia tá atrasado")
//                    mudaTipoExame(item)
//                }
//            }
//            
//        }
        
    }
    
    func separaDia (diaDado: String){
        let formatDia = DateFormatter()
        var diaExame = formatDia.date(from: diaDado)
        var tipo = ""
        
//        ExamesDia.removeAll()
//        for item in exame{
//            diaExame = item.valueForKey("data") as? NSDate
//            tipo = item.valueForKey("tipo") as! String
//            if (tipo != "historico" && tipo != "preload"){
//                if (diaExame!.isEqualToDate(dia)){
//                    exameDia += [item]
//                }
//            }
//        }
//        print(exameDia.count)
//        if(exameDia.count > 2){
//            ordenaExame()
//        }
//
    }
    
    
//    func ordenaExame(){
//        var fim = exameDia.endIndex - 1
//        while fim > 0{
//            var maior = 0
//            for item in exameDia{
//                let i1 = exameDia.indexOf(item)
//                if(item != exameDia[0]){
//                    if(i1 <= fim){
//                        
//                        let horaPrim = item.valueForKey("hora") as! NSDate
//                        let horaSeg = exameDia[maior].valueForKey("hora") as! NSDate
//                        
//                        if(horaPrim.isEqualToDate(horaSeg) == false){
//                            if(horaPrim.laterDate(horaSeg) == horaPrim){
//                                maior = i1!
//                                print("i1:\(i1), fim: \(fim), maior:\(maior)")
//                            }
//                        }
//                    }
//                }
//            }
//            
//            if(fim != maior){
//                let subtituido = exameDia[fim]
//                let substituto = exameDia[maior]
//                exameDia.insert(substituto, atIndex: fim)
//                exameDia.removeAtIndex(fim+1)
//                exameDia.insert(subtituido, atIndex: maior)
//                exameDia.removeAtIndex(maior+1)
//            }
//            fim -= 1
//        }
//        
//    }
    
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "MarcarExame") {
//            let vc = segue.destinationViewController as! MarcarConsulta
//            vc.data = dia
//            vc.edit = edit
//            if edit == true{
//                vc.horaI = hora
//            }
//        }else if(segue.identifier == "detalhes"){
//            let indexPaths = examesTableView.indexPathForSelectedRow
//            let indexPath = indexPaths! as NSIndexPath
//            let exam = exameDia[indexPath.row]
//            let vc = segue.destinationViewController as! ExameViewController
//            vc.diaI = exam.valueForKey("data") as! NSDate
//            vc.horaI = exam.valueForKey("hora") as! NSDate
//            vc.tipoDoExame = exam.valueForKey("tipo") as! String
//        }
//        //        else if(segue.identifier == "editar"){
//        //            let vc = segue.destinationViewController as! MarcarConsulta
//        //        }
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
