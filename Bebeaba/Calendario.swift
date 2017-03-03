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
import MGSwipeTableCell

class Calendario: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var calendar: FSCalendar!
  
    @IBOutlet weak var ExamesDia: UITableView!
    
    @IBOutlet var viewCalendario: UIView!
        
    var exame = [Exame]()
    var exameDia = [Exame]()
    var dia = Date()
    var edit = false
    var hora = NSDate()
    var diaSelecionado = NSDate()
    var marcou = false
    var anterior = false
    
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
        
        //viewCalendario.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
    }
    

    
    //MARK: Coredata
    
    override func viewWillAppear(_ animated: Bool) {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Rectangle 3")
        self.view.insertSubview(backgroundImage, at: 0)

        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        edit = false
        
        let fetchRequest: NSFetchRequest<Exame> = Exame.fetchRequest()
        
        do{
            let results = try context.fetch(fetchRequest)
            exame = results 
            
            if results.count>0{
                self.ExamesDia.reloadData()
            }else{
                print("Não há itens no BD")
            }
        } catch {
            print("Não foi possivel resgatar dados")
        }
        
        checkAtrasados()
        
//        if marcou == false{
//            separaDia(diaDado: dia)
//        } else {
//            separaDia(diaDado: diaSelecionado as Date)
//            marcou = false
//        }
        
        separaDia(diaDado: diaSelecionado as Date)
        ExamesDia.reloadData()
        calendar.reloadData()
        
    }
    
    
    
    
    
    
    // MARK:- FSCalendarDataSource
    
    
    
    //Coloca título no dia
    
  /*  func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return self.gregorian.isDateInToday(date) ? "今天" : nil
    }*/
    
    
    // Data limite do calendario
    
//    func maximumDate(for calendar: FSCalendar) -> Date {
//        return self.formatter.date(from: "30/10/2017")!
//    }
    
    // Coloca bolinha de evento na data
    
   func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    
    let day = date
    
    for item in todasDatas{
        
       if day == item as Date {
        
            return 1
        }
    }
  
    return 0
}
    
    
    //Coloca imagem na data
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        
//         let day: Int! = self.gregorian.component(.day, from: date)
//         let month: Int! = self.gregorian.component(.month, from: date)
//        let year: Int! = self.gregorian.component(.year, from: date)
//        
//        return [7].contains(day) && [6].contains(month) && [2017].contains(year) ? UIImage(named: "bebe") : nil
//
//    }
    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
           }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        diaSelecionado = date as NSDate
        
        checkAtrasados()
        separaDia(diaDado: date)
        ExamesDia.reloadData()
        
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
 
    //MARK: TableView
    
    // Fundo levemente branco da celula
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
    }
    
    
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext

        
        cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named:"Check.png"), backgroundColor: UIColor.clear, callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            
            self.edit = true
            
            let exame = self.exameDia[indexPath.row]
            let exameExcluido = self.exameDia[indexPath.row]
            
            self.mudaTipoExame(item: exame, tipo: "historico")
            
            var count:Int = 0
            
            if exameExcluido.tipo != "atrasado" {
                for item in self.todasDatas {
                    if item == exameExcluido.data {
                        self.todasDatas.remove(at: count)
                    }
                    count += 1
                }
            }
            
            self.exameDia.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
    
            self.calendar.reloadData()
            
            return true
        })
            ,MGSwipeButton(title: "", icon: UIImage(named:"Edit.png"), backgroundColor: UIColor.clear,callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                
                self.edit = true
                
                let exam = self.exameDia[indexPath.row]
                
                self.edit = true
                self.hora = exam.value(forKey: "hora") as! NSDate
                self.performSegue(withIdentifier: "MarcarExame", sender: nil)
                
                return true
            })
            
            ,MGSwipeButton(title: "", icon: UIImage(named:"Delete.png"), backgroundColor: UIColor.clear,callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                
                self.edit = true
                
                let exameExcluido = self.exameDia[indexPath.row]
                
                var count:Int = 0
                
               
                for item in self.todasDatas {
                    if item == exameExcluido.data {
                        
                        self.todasDatas.remove(at: count)
                        break
                    }
                    count += 1
                }
                
                count = 0
                
                for item in self.exame {
                   if item == exameExcluido {
                   self.exame.remove(at: count)
                    }
                    count += 1
                }
                
                //self.exame.remove(at: indexPath.row)
                context.delete(self.exameDia[indexPath.row])
                self.exameDia.remove(at: indexPath.row)
                
                do {
                try context.save()
                } catch {
                    print("Não foi possível retirar do BD")
                }
                
                //self.separaDia(diaDado: self.diaSelecionado as Date)
                //self.calendar.reloadData()
                self.calendar.reloadData()
                tableView.deleteRows(at: [indexPath], with: .fade)
                // let diaSelect = self.calendar.selectedDate
                //            self.separaDia(diaDado: diaSelect as Date)
                // self.calendar.reloadData()
                                
                return true
            })

        ]
        
        //                cell.leftSwipeSettings.transition = MGSwipeTransition.Rotate3D
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ExamesDia.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: Funções Auxiliares
    
    func mudaTipoExame(item: Exame, tipo: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        do{
            let requests: NSFetchRequest<Exame> = Exame.fetchRequest()
            let results = try context.fetch(requests)
            
            if(results.count > 0) {
                let horaItem = item.value(forKey: "hora") as! NSDate
                let diaItem = item.value(forKey: "data") as! NSDate
                let nome = item.value(forKey: "nome") as! String
                
                for coisa in results{
                    if (coisa.value(forKey: "data") as! NSDate).isEqual(to: diaItem as Date){
                        if (coisa.value(forKey: "hora") as! NSDate).isEqual(to: horaItem as Date){
                            if (coisa.value(forKey: "nome") as! String) == nome{
                                coisa.setValue(tipo, forKey: "tipo")
                            }
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
                            
                            self.mudaTipoExame(item: item, tipo: "atrasado")
                        }
                    }
                } else if (diaExameDate! < diaNowDate!) == true {
                    
                    self.mudaTipoExame(item: item, tipo: "atrasado")
                }
            }
        }
    }
    
    func separaDia (diaDado: Date){
        var diaExame = NSDate()
        var tipo = ""
        
        exameDia.removeAll()
        todasDatas.removeAll()
        
        for item in exame {
            
            diaExame = (item.value(forKey: "data") as? NSDate)!
            tipo = item.value(forKey: "tipo") as! String
            
            if tipo != "historico" && tipo != "preload"{
                todasDatas.append(diaExame)
                if compareDate(dateInitial: diaExame as Date, dateFinal: diaDado) == true {
                    exameDia += [item]
                }
            }
            
           
        }
        
        
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
    
    func verificaDia() {
        
        let calendario = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        let diaAnterior = calendario.isDateInToday(diaSelecionado as Date)
        
        if diaAnterior == false {
            if (diaSelecionado as Date) < Date() {
                let tempoLongo = UIAlertController(title: "Alert", message: "A data selecionada é anterior a data atual.", preferredStyle: UIAlertControllerStyle.alert)
                tempoLongo.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(tempoLongo, animated: true, completion: nil)
                
                anterior = true

            }
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
        
        else if(segue.identifier == "detalhes"){
            let indexPaths = ExamesDia.indexPathForSelectedRow
            let indexPath = indexPaths! as NSIndexPath
            let exam = exameDia[indexPath.row]
            let vc = segue.destination as! Detalhes
            vc.exame = exam
        }
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
