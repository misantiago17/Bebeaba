//
//  Entrada.swift
//  Bebeaba
//
//  Created by Michelle Beadle on 08/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import CoreData

class Entrada: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ExamesSemana: UITableView!
    
    //falta criar a classe Exame
   // var arrayExameSemana = [Exame]()
    
    var semanaU = ""
    //var edit = false     precisa do swipe da célula
    var hora = NSDate()
    var dia = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExamesSemana.delegate = self
        ExamesSemana.dataSource = self
                
        //todas a animação da roda com o progresso da gestação estava aqui

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return arrayExameSemana.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") /*as! TableViewCell*/
        
        //        if cell == nil
        //        {
        //            cell = MGSwipeTableCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        //        }
        
       // let exam = arrayExameSemana[indexPath.row]
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        
//        let hora = exam.valueForKey("hora") as? NSDate
//        let horario = timeFormatter.stringFromDate(hora!)
//        let dia = exam.valueForKey("data") as? NSDate
//        let data = dateFormater.stringFromDate(dia!)
//        
//        cell.nomeLabel.text = exam.valueForKey("nome") as? String
//        cell.horarioLabel.text = horario
//        cell.dataLabel.text = data
//        //cell.dataLabel.text = data
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
//            self.managedContext.deleteObject(self.exameSemana[indexPath.row])
//            self.exameSemana.removeAtIndex(indexPath.row)
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
//            let exam = self.exameSemana[indexPath.row]
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
//            self.exameSemana.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            
//            return true
//        })
//            ,MGSwipeButton(title: "Edit", icon: UIImage(named:"fav.png"), backgroundColor: UIColor.blueColor(),callback: {
//                (sender: MGSwipeTableCell!) -> Bool in
//                
//                print("eu")
//                let exam = self.exameSemana[indexPath.row]
//                
//                self.edit = true
//                self.dia = exam.valueForKey("data") as! NSDate
//                self.hora = exam.valueForKey("hora") as! NSDate
//                self.performSegueWithIdentifier("MarcarExame", sender: nil)
//                
//                return true
//            })
//        ]
//        
//        //                cell.leftSwipeSettings.transition = MGSwipeTransition.Rotate3D
//        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
//        
//        if editingStyle == .Delete {
//            
//            managedContext.deleteObject(exameSemana[indexPath.row])
//            exameSemana.removeAtIndex(indexPath.row)
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
    
    func getDayOfWeek(today:NSDate)->Int? {
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: today as Date)
        let weekDay = myComponents.weekday
        return weekDay
    }
    
    func isDate (date : NSDate, inRange fromDate : NSDate, toDate : NSDate, inclusive : Bool) -> Bool { if inclusive { return !(date.compare (fromDate as Date) == .orderedAscending) && !(date.compare (toDate as Date) == .orderedDescending) } else { return date.compare (fromDate as Date) == .orderedDescending && date.compare (toDate as Date) == .orderedAscending } }
    

    //MARK: Preenche o array de exames da semana
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //        if (exameSemana.count == 0){
        //            self.labelexame.text = "Não há exames essa semana."
        //            self.SemanaTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //        }
        //        else {
        //            labelexame.text = "Exames da Semana"
        //            self.SemanaTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        //        }
        
       // edit = false - precisa do swipe
        
        //COREDATA
        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exame")
//        
//        do{
//            let results = try managedContext.executeFetchRequest(fetchRequest)
//            let exame = results as! [Exame]
//            
//            let format = DateFormatter()
//            let data = NSDate()
//            let sem = getDayOfWeek(today: data)
//            
//            var dataInicio = NSDate()
//            var dataFinal = NSDate()
//            let components = NSDateComponents()
//            let calendario = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
//            let ano = calendario.components(.year, from: data as Date)
//            let mes = calendario.components(.month, from: data as Date)
//            let dia = calendario.components(.day, from: data as Date)
//            
//            switch sem! {
//            case 1:
//                components.year = ano.year!
//                components.month = mes.month!
//                components.day = dia.day!
//                
//                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
//            case 2:
//                components.year = ano.year!
//                components.month = mes.month!
//                components.day = dia.day! - 1
//                
//                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
//            case 3:
//                components.year = ano.year!
//                components.month = mes.month!
//                components.day = dia.day! - 2
//                
//                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
//            case 4:
//                components.year = ano.year!
//                components.month = mes.month!
//                components.day = dia.day! - 3
//                
//                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
//            case 5:
//                components.year = ano.year!
//                components.month = mes.month!
//                components.day = dia.day! - 4
//                
//                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
//            case 6:
//                components.year = ano.year!
//                components.month = mes.month!
//                components.day = dia.day! - 5
//                
//                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
//            default:
//                components.year = ano.year!
//                components.month = mes.month!
//                components.day = dia.day! - 6
//                
//                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
//            }
//            
//            let componentsFinal = NSDateComponents()
//            
//            switch sem! {
//            case 1:
//                componentsFinal.year = ano.year!
//                componentsFinal.month = mes.month!
//                componentsFinal.day = dia.day! + 6
//                
//                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
//            case 2:
//                componentsFinal.year = ano.year!
//                componentsFinal.month = mes.month!
//                componentsFinal.day = dia.day! + 5
//                
//                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
//            case 3:
//                componentsFinal.year = ano.year!
//                componentsFinal.month = mes.month!
//                componentsFinal.day = dia.day! + 4
//                
//                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
//            case 4:
//                componentsFinal.year = ano.year!
//                componentsFinal.month = mes.month!
//                componentsFinal.day = dia.day! + 3
//                
//                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
//            case 5:
//                componentsFinal.year = ano.year!
//                componentsFinal.month = mes.month!
//                componentsFinal.day = dia.day! + 2
//                
//                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
//            case 6:
//                componentsFinal.year = ano.year!
//                componentsFinal.month = mes.month!
//                componentsFinal.day = dia.day! + 1
//                
//                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
//            default:
//                componentsFinal.year = ano.year!
//                componentsFinal.month = mes.month!
//                componentsFinal.day = dia.day!
//                
//                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
//            }
//            
//            //arrayExameSemana.removeAll()
//            for item in exame{
//                let dataI = item.valueForKey("data") as! NSDate
//                let tipo = item.valueForKey("tipo") as! String
//                if isDate(dataI, inRange: dataInicio, toDate: dataFinal, inclusive: true) == true{
//                    if (tipo != "historico" && tipo != "preload"){
//                        arrayExameSemana += [item]
//                    }
//                }
//            }
//            
//            if results.count>0{
//                print(arrayExameSemana)
//            }else{
//                print("Não há itens no BD")
//            }
//        } catch {
//            print("Não foi possivel resgatar dados")
//        }
//        
//        ExamesSemana.reloadData()
    }
    
    
    //PRECISA DE CRIAR DETAIS PARA OS EXAMES
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if(segue.identifier == "MarcarExame") {
//            let vc = segue.destinationViewController as! MarcarConsulta
//            vc.data = dia
//            vc.edit = edit
//            if edit == true{
//                vc.horaI = hora
//            }
//        }else if(segue.identifier == "detail"){
//            let indexPaths = SemanaTableView.indexPathForSelectedRow
//            let indexPath = indexPaths! as NSIndexPath
//            let exam = exameSemana[indexPath.row]
//            let vc = segue.destinationViewController as! ExameViewController
//            vc.diaI = exam.valueForKey("data") as! NSDate
//            vc.horaI = exam.valueForKey("hora") as! NSDate
//            vc.tipoDoExame = exam.valueForKey("tipo") as! String
//        }
//        //        else if(segue.identifier == "editar"){
//        //            let vc = segue.destinationViewController as! MarcarConsulta
//        //        }
//    }

    
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
