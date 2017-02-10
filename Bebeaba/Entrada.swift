//
//  Entrada.swift
//  Bebeaba
//
//  Created by Michelle Beadle on 08/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import CoreData
import KDCircularProgress

class Entrada: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ExamesSemana: UITableView!
    var progress: KDCircularProgress!
    var tempototal = 30.0*9.0/7.0
    var ang = Double(20)
    var porc = Int(20)
    var semanaU = "30"
    
    //falta criar a classe Exame
    var arrayExameSemana = [Exame]()
        
    var edit = false
    var hora = NSDate()
    var dia = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExamesSemana.delegate = self
        ExamesSemana.dataSource = self
        
        // Animação programática
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: self.view.frame.width/2))
        progress.startAngle = -90
        
        
        /*progress.progressThickness = 0.2
        progress.trackThickness = 0.6
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .forward
        progress.glowAmount = 0.9*/
        

        progress.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
        progress.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/4)
        
        ang = Double(Double(semanaU)!*360.0/tempototal)
        
        if(ang > 360.0){
            progress.angle = 360.0
        }
        else {
            progress.angle = ang
        }
        
        porc = Int(Int(semanaU)!*100/Int(tempototal))
        
        if(porc > 100){
            porc = 100
        }
        
        
        progress.animate(fromAngle: 0, toAngle: progress.angle, duration: 2, completion: { completed in
            if completed {
                print("animation stopped, completed")
            } else {
                print("animation stopped, was interrupted")
            }
        })
        
        
        view.addSubview(progress)
        
        
        //Ícone do centro da animação
        var bgImage: UIImageView!
        let image : UIImage = UIImage(named:"homeicone.png")!
        bgImage = UIImageView(image: image)
        bgImage.frame = CGRect(x: self.view.frame.width/4 + 5, y: self.view.frame.width/4 - 15, width: self.view.frame.width/2 - 10, height: self.view.frame.width/2 - 10)
        view.addSubview(bgImage)
        
        
        // Label programática semanas
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        label.center = CGPoint(x: progress.center.x, y: progress.center.y - self.view.frame.width/4 - 10)
        label.textAlignment = NSTextAlignment.center
        label.text = "\(porc)% da Gravidez"
        label.font = UIFont(name: "Avenir-Light", size: 18.0)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 115/255.0, green: 53/255.0, blue: 121/255.0, alpha: 1.0)
        self.view.addSubview(label)
        
        
        // Label do exame
        let labelexame = UILabel(frame: CGRect(x: 0, y: 300, width: self.view.frame.width, height: 65))
        labelexame.textAlignment = NSTextAlignment.center
        labelexame.text = "Exames da Semana"
        labelexame.font = UIFont(name: "Avenir-Light", size: 16.0)
        labelexame.font = UIFont.boldSystemFont(ofSize: 14)
        labelexame.textColor = UIColor(red: 115/255.0, green: 53/255.0, blue: 121/255.0, alpha: 1.0)
        self.view.addSubview(labelexame)

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayExameSemana.count
        //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        //        if cell == nil
        //        {
        //            cell = MGSwipeTableCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        //        }
        
        let exam = arrayExameSemana[indexPath.row]
        
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
        //cell.dataLabel.text = data
        if(exam.value(forKey: "local") as! String == ""){
            cell.local.isHidden = true
        }else{
            cell.local.isHidden = false
            cell.local.text = exam.value(forKey: "local") as? String
        }
        
        //fazer a função que deixa o exame como atrasado
//        if(exam.value(forKey: "tipo") as! String == "atrasado"){
//            cell.atrasoLabel.hidden = false
//        } else if (exam.value(forKey: "tipo") as! String == "atual"){
//            cell.atrasoLabel.hidden = true
//        }
        
        //PRECISA DO MGSWIPE
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
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
            
            context.delete(arrayExameSemana[indexPath.row])
            arrayExameSemana.remove(at: indexPath.row)
            do {
                try context.save()
            } catch {
                print("Não foi possível retirar do BD")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: Funções Auxiliares
    
    func getDayOfWeek(today:NSDate)->Int? {
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: today as Date)
        let weekDay = myComponents.weekday
        return weekDay
    }
    
    func isDate (date : NSDate, inRange fromDate : NSDate, toDate : NSDate, inclusive : Bool) -> Bool { if inclusive { return !(date.compare (fromDate as Date) == .orderedAscending) && !(date.compare (toDate as Date) == .orderedDescending) } else { return date.compare (fromDate as Date) == .orderedDescending && date.compare (toDate as Date) == .orderedAscending } }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
//        if (arrayExameSemana.count == 0){
//            self.labelexame.text = "Não há exames essa semana."
//            self.ExamesSemana.separatorStyle = UITableViewCellSeparatorStyle.none
//        }
//        else {
//            labelexame.text = "Exames da Semana"
//            self.SemanaTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
//        }
        
        edit = false
        
        //COREDATA
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        let fetchRequest: NSFetchRequest<Exame> = Exame.fetchRequest()
        let requestUser: NSFetchRequest<User> = User.fetchRequest()

        
        do{
            let resultsUser = try context.fetch(requestUser)
            let results = try context.fetch(fetchRequest)
            let exame = results
            let user = resultsUser
            
            let format = DateFormatter()
            let data = NSDate()
            let sem = getDayOfWeek(today: data)
            
            var dataInicio = NSDate()
            var dataFinal = NSDate()
            let components = NSDateComponents()
            let calendario = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            let ano = calendario.components(.year, from: data as Date)
            let mes = calendario.components(.month, from: data as Date)
            let dia = calendario.components(.day, from: data as Date)
            
            switch sem! {
            case 1:
                components.year = ano.year!
                components.month = mes.month!
                components.day = dia.day!
                
                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
            case 2:
                components.year = ano.year!
                components.month = mes.month!
                components.day = dia.day! - 1
                
                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
            case 3:
                components.year = ano.year!
                components.month = mes.month!
                components.day = dia.day! - 2
                
                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
            case 4:
                components.year = ano.year!
                components.month = mes.month!
                components.day = dia.day! - 3
                
                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
            case 5:
                components.year = ano.year!
                components.month = mes.month!
                components.day = dia.day! - 4
                
                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
            case 6:
                components.year = ano.year!
                components.month = mes.month!
                components.day = dia.day! - 5
                
                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
            default:
                components.year = ano.year!
                components.month = mes.month!
                components.day = dia.day! - 6
                
                dataInicio = calendario.date(from: components as DateComponents)! as NSDate
            }
            
            let componentsFinal = NSDateComponents()
            
            switch sem! {
            case 1:
                componentsFinal.year = ano.year!
                componentsFinal.month = mes.month!
                componentsFinal.day = dia.day! + 6
                
                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
            case 2:
                componentsFinal.year = ano.year!
                componentsFinal.month = mes.month!
                componentsFinal.day = dia.day! + 5
                
                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
            case 3:
                componentsFinal.year = ano.year!
                componentsFinal.month = mes.month!
                componentsFinal.day = dia.day! + 4
                
                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
            case 4:
                componentsFinal.year = ano.year!
                componentsFinal.month = mes.month!
                componentsFinal.day = dia.day! + 3
                
                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
            case 5:
                componentsFinal.year = ano.year!
                componentsFinal.month = mes.month!
                componentsFinal.day = dia.day! + 2
                
                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
            case 6:
                componentsFinal.year = ano.year!
                componentsFinal.month = mes.month!
                componentsFinal.day = dia.day! + 1
                
                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
            default:
                componentsFinal.year = ano.year!
                componentsFinal.month = mes.month!
                componentsFinal.day = dia.day!
                
                dataFinal = calendario.date(from: componentsFinal as DateComponents)! as NSDate
            }
            
            arrayExameSemana.removeAll()
            
            for item in user{
                let nome = item.value(forKey: "nome") as! String
                let semana = item.value(forKey: "semana") as! String
                
                semanaU = semana
                print("semana de gravidez \(semanaU)")
            }
            
            for item in exame{
                let dataI = item.value(forKey: "data") as! NSDate
                let tipo = item.value(forKey: "tipo") as! String
                if isDate(date: dataI, inRange: dataInicio, toDate: dataFinal, inclusive: true) == true{
                    if (tipo != "historico" && tipo != "preload"){
                        arrayExameSemana += [item]
                    }
                }
            }
            
            if results.count>0{
                print(arrayExameSemana)
            }else{
                print("Não há itens no BD")
            }
        } catch {
            print("Não foi possivel resgatar dados")
        }
        
        ExamesSemana.reloadData()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
