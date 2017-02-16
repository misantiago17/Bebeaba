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

    
    @IBOutlet weak var calendar: FSCalendar!
  
    @IBOutlet weak var ExamesDia: UITableView!
    
        
    var exame = [Exame]()
    var exameDia = [Exame]()
    var dia = Date()
    var edit = false
    var hora = NSDate()
    var diaSelecionado = NSDate()
    var marcou = false
    
    var todasDatas = [NSDate]()
  
    
    
    // Formato de data
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    
    // Tipo de calendario
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)

    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExamesDia.delegate = self
        ExamesDia.dataSource = self
        
        
        
        

    }

    
    //MARK: Coredata
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        edit = false
        
        let fetchRequest: NSFetchRequest<Exame> = Exame.fetchRequest()
        
        do{
            let results = try context.fetch(fetchRequest)
            exame = results 
            
            if results.count>0{
                print("quantidade de itens no BD \(results.count)")
                self.ExamesDia.reloadData()
            }else{
                print("Não há itens no BD")
            }
        } catch {
            print("Não foi possivel resgatar dados")
        }
        
        checkAtrasados()
        
        if marcou == false{
            separaDia(diaDado: dia)
        } else {
            separaDia(diaDado: diaSelecionado as Date)
            marcou = false
        }
        
        ExamesDia.reloadData()
        calendar.select(Date())
        calendar.reloadData()
        
    }
    
    
    
    
    
    
    // MARK:- FSCalendarDataSource
    
    
    
    //Coloca título no dia
    
  /*  func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return self.gregorian.isDateInToday(date) ? "今天" : nil
    }*/
    
    
    // Data limite do calendario
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "30/10/2017")!
    }
    
    // Coloca bolinha de evento na data
    
   func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    
    let day = date
    
    print("todas as datas: \(todasDatas)")
    print("count todas as datas : \(todasDatas.count)")
 
    for item in todasDatas{
        
       if day == item as Date {
        
            return 1
        }
    }
  
    return 0
}
    
    
    //Coloca imagem na data
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        
         let day: Int! = self.gregorian.component(.day, from: date)
         let month: Int! = self.gregorian.component(.month, from: date)
        let year: Int! = self.gregorian.component(.year, from: date)
        
        return [7].contains(day) && [6].contains(month) && [2017].contains(year) ? UIImage(named: "bebe") : nil

    }
    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        diaSelecionado = date as NSDate
        
        separaDia(diaDado: date)
        checkAtrasados()
        ExamesDia.reloadData()
        
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
 
    //MARK: TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exameDia.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        //        if cell == nil
        //        {
        //            cell = MGSwipeTableCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        //        }
        
        let exam = exameDia[indexPath.row]
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let hora = exam.value(forKey: "hora") as? NSDate
        let horario = timeFormatter.string(from: hora! as Date)
        
        cell.nome.text = exam.value(forKey: "nome") as? String
        cell.horario.text = horario
        if(exam.value(forKey: "local") as! String == ""){
            cell.local.isHidden = true
        }else{
            cell.local.isHidden = false
            cell.local.text = exam.value(forKey: "local") as? String
        }
        if(exam.value(forKey: "tipo") as! String == "atrasado"){
            cell.atraso.isHidden = false
        } else if (exam.value(forKey: "tipo") as! String == "atual"){
            cell.atraso.isHidden = true
        }
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
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        if editingStyle == .delete {
            
            context.delete(exame[indexPath.row])
            exame.remove(at: indexPath.row)
            exameDia.remove(at: indexPath.row)
            do {
                try context.save()
            } catch {
                print("Não foi possível retirar do BD")
            }
            
            calendar.reloadData()
            
            separaDia(diaDado: diaSelecionado as Date)
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }

    
    //MARK: Funções Auxiliares
    
    func mudaTipoExame(item: Exame){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        do{
            let requests: NSFetchRequest<Exame> = Exame.fetchRequest()
            let results = try context.fetch(requests)
            
            if(results.count > 0) {
                let horaItem = item.value(forKey: "hora") as! NSDate
                let diaItem = item.value(forKey: "data") as! NSDate
                let tipo = "atrasado"
                
                for coisa in results{
                    if (coisa.value(forKey: "data") as! NSDate).isEqual(to: diaItem as Date){
                        if (coisa.value(forKey: "hora") as! NSDate).isEqual(to: horaItem as Date){
                            coisa.setValue(tipo, forKey: "tipo")
                            print(coisa)
                        }
                    }
                }
            }
            else {
                print("Não há usuários")
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
        
        for item in exame{
            let horaExame = formatHora.string(from: (item.value(forKey: "hora") as! NSDate) as Date)
            let diaExame = formatDia.string(from: (item.value(forKey: "data") as! NSDate) as Date)
            let horaExameDate = formatHora.date(from: horaExame)
            let diaExameDate = formatDia.date(from: diaExame)
            
            if (item.value(forKey: "tipo") as! String == "atual") {
                if (diaExameDate! == diaNowDate!) == true {
                    if (horaExameDate! == diaNowDate!) == false {
                        if (horaExameDate! < horaNowDate!) == true {
                            print("Meu horario tá atrasado")
                            self.mudaTipoExame(item: item)
                        }
                    }
                }
            } else if (diaExameDate! < diaNowDate!) == true {
                    print("Meu dia tá atrasado")
                    self.mudaTipoExame(item: item)
            }
        }
    }
    
    func separaDia (diaDado: Date){
        var diaExame = NSDate()
        var tipo = ""
        
        exameDia.removeAll()
        todasDatas.removeAll()
        
        for item in exame{
            diaExame = (item.value(forKey: "data") as? NSDate)!
            tipo = item.value(forKey: "tipo") as! String
            
            todasDatas.append(diaExame)
            
            if tipo != "historico" && tipo != "preload"{
                if compareDate(dateInitial: diaExame as Date, dateFinal: diaDado) == true {
                    exameDia += [item]
                }
            }
            
           
        }
        
        
    
        
        
        print("exames totais \(exame.count)")
        print("exames do dia \(exameDia.count)")
        
        if(exameDia.count > 2){
            ordenaExame()
        }

    }
    
    func compareDate(dateInitial:Date, dateFinal:Date) -> Bool {
        let order = Calendar.current.compare(dateInitial, to: dateFinal, toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    
    func ordenaExame(){
        var fim = exameDia.endIndex - 1
        while fim > 0{
            var maior = 0
            for item in exameDia{
                let i1 = exameDia.index(of: item)
                if(item != exameDia[0]){
                    if(i1! <= fim){
                        
                        let horaPrim = item.value(forKey: "hora") as! NSDate
                        let horaSeg = exameDia[maior].value(forKey: "hora") as! NSDate
                        
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
                let subtituido = exameDia[fim]
                let substituto = exameDia[maior]
                exameDia.insert(substituto, at: fim)
                exameDia.remove(at: fim+1)
                exameDia.insert(subtituido, at: maior)
                exameDia.remove(at: maior+1)
            }
            fim -= 1
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "MarcarExame") {
            let vc = segue.destination as! NewExam
            marcou = true
            vc.data = diaSelecionado
            vc.edit = edit
            if edit == true{
                vc.horaI = hora
            }
        }
        
        /*else if(segue.identifier == "detalhes"){
         ////            let indexPaths = examesTableView.indexPathForSelectedRow
         ////            let indexPath = indexPaths! as NSIndexPath
         ////            let exam = exameDia[indexPath.row]
         ////            let vc = segue.destinationViewController as! ExameViewController
         ////            vc.diaI = exam.valueForKey("data") as! NSDate
         ////            vc.horaI = exam.valueForKey("hora") as! NSDate
         ////            vc.tipoDoExame = exam.valueForKey("tipo") as! String
         ////        }*/
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
