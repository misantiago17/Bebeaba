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
import MGSwipeTableCell
import SACountingLabel

class Entrada: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var ExamesSemana: UITableView!
    @IBOutlet weak var NomeMulher: UILabel!
    
    var progress: KDCircularProgress!
    var tempototal = 280.0
    var ang = Double(20)
    var porc = Int(20)
    var semanaU = ""
    
    //falta criar a classe Exame
    var arrayExameSemana = [Exame]()
        
    var edit = false
    var hora = NSDate()
    var dia = NSDate()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func separaData(data: String) -> String {
        let dataArray = data.components(separatedBy: "/")
        
        var dataSeparada = DateComponents()
        dataSeparada.day = Int(dataArray[0])
        dataSeparada.month = Int(dataArray[1])
        dataSeparada.year = Int(dataArray[2])
        
        let semanas = implementaSemana(data: dataSeparada)
        
        return String(semanas)
    }
    
    func implementaSemana(data: DateComponents) -> Int {
        
        let cal = Calendar.current
        var components = cal.dateComponents([.year, .month, .day], from: NSDate() as Date)
        let today = cal.date(from: components)
        let otherDate = cal.date(from: data)
        
        components = cal.dateComponents([Calendar.Component.day], from: otherDate!, to: (today! as Date))
        
        return components.day!
    }
    
    func getUser() {
        
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        let requestUser: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            
            let resultsUser = try context.fetch(requestUser)
            let user = resultsUser
            
            for item in user{
                
                let nome = item.value(forKey: "nome") as! String
                let semana = item.value(forKey: "semana") as! String
                
                NomeMulher.text = "Olá, \(nome)"
                semanaU = separaData(data: semana)
                
            }
            
        } catch {
            print("Não foi possivel resgatar dados")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Rectangle 3")
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        ExamesSemana.delegate = self
        ExamesSemana.dataSource = self
        
        getUser()
        
        
        
        // Animação programática
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: self.view.frame.width*0.5, height: self.view.frame.width*0.5))
        progress.startAngle = -90
        progress.trackColor = UIColor(red: 161/255, green: 160/255, blue: 156/255, alpha: 0.2)
        //progress.trackColor = UIColor.blue
        progress.progressThickness = 0.5
        progress.trackThickness = 0.4
        progress.clockwise = true
        progress.gradientRotateSpeed = 2.0
        progress.roundedCorners = true
        progress.glowMode = .forward
        progress.glowAmount = 0.9
        //progress.set(colors: UIColor(red: 229/255, green: 82/255, blue: 152/255, alpha: 1.0))
        progress.set(colors: UIColor(red: 63/255, green: 184/255, blue: 175/255, alpha: 1.0))
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
        })
        
        
        view.addSubview(progress)
        
        
        
        // Label programática semanas
        let label = SACountingLabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        //label.backgroundColor = UIColor.black
        label.center = CGPoint(x: progress.center.x - 8, y: progress.center.y - 5)
        label.textAlignment = NSTextAlignment.center
        label.text = "\(porc)%"
        label.countFrom(fromValue: 0, to: Float(porc), withDuration: 2.0, andAnimationType: .Linear, andCountingType: .Int)
        label.font = UIFont(name: "Avenir-Light", size: 50.0)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = UIColor(red: 229/255, green: 82/255, blue: 152/255, alpha: 1.0)
        self.view.addSubview(label)
        
        // Label programática semanas
        let labelper = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        labelper.center = CGPoint(x: progress.center.x + 17, y: progress.center.y - 5)
        labelper.textAlignment = NSTextAlignment.center
        labelper.text = "%"
        labelper.font = UIFont(name: "Avenir-Light", size: 15.0)
        labelper.font = UIFont.boldSystemFont(ofSize: 20)
        labelper.textColor = UIColor(red: 229/255, green: 82/255, blue: 152/255, alpha: 1.0)
        self.view.addSubview(labelper)
        
        // Label do exame
        let gravidezLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        gravidezLabel.center = CGPoint(x: progress.center.x, y: progress.center.y + 17)
        gravidezLabel.textAlignment = NSTextAlignment.center
        gravidezLabel.text = "gravidez"
        gravidezLabel.font = UIFont(name: "Avenir-Light", size: 13.0)
        gravidezLabel.font = UIFont.boldSystemFont(ofSize: 14)
        gravidezLabel.textColor = UIColor(red: 229/255.0, green: 82/255.0, blue: 152/255.0, alpha: 1.0)
        self.view.addSubview(gravidezLabel)
        
//        // Image
//        var bgImage: UIImageView!
//        //let image : UIImage = UIImage(named:"babyfeet.png")!
//       // bgImage = UIImageView(image: image)
//        bgImage.frame = CGRect(x: self.view.frame.width/2 - 38, y: self.view.frame.width/4 + 82, width: self.view.frame.width/16, height: self.view.frame.width/16)
//        //bgImage.backgroundColor = UIColor.black
//        self.view.addSubview(bgImage)
//        
        
        
        // Label do exame
//        let labelexame = UILabel(frame: CGRect(x: 0, y: 240, width: self.view.frame.width, height: 65))
//        labelexame.textAlignment = NSTextAlignment.center
//        labelexame.text = "Exames da Semana"
//        labelexame.font = UIFont(name: "Avenir-Light", size: 16.0)
//        labelexame.font = UIFont.boldSystemFont(ofSize: 14)
//        labelexame.textColor = UIColor(red: 226/255.0, green: 108/255.0, blue: 132/255.0, alpha: 1.0)
//        self.view.addSubview(labelexame)


    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.tintColor = UIColor.white
            headerTitle.textLabel?.textColor = UIColor(red: 229/255, green: 82/255, blue: 152/255, alpha: 1.0)
            headerTitle.textLabel?.textAlignment = .center
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Exames da Semana"
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayExameSemana.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
//        if cell == nil {
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
        
        if(exam.value(forKey: "tipo") as! String == "atrasado"){
            cell.atraso.isHidden = false
        } else if (exam.value(forKey: "tipo") as! String == "atual"){
            cell.atraso.isHidden = true
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        //                cell.rightSwipeSettings.transition = MGSwipeTransition.Rotate3D
        //        cell.rightExpansion.buttonIndex = 0
        //        cell.leftExpansion.buttonIndex = 0
        
        
        cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named:"Check.png"), backgroundColor: UIColor.clear, callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            
            let exam = self.arrayExameSemana[indexPath.row]
            
            exam.setValue("historico", forKey: "tipo")
            
            
            //salva mudanças
            
            do{
                try context.save()
            }
            catch {
                print("error")
            }
            
            self.arrayExameSemana.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            return true
        })
            ,MGSwipeButton(title: "", icon: UIImage(named:"Edit.png"), backgroundColor: UIColor.clear,callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                
                
                let exam = self.arrayExameSemana[indexPath.row]
                
                self.edit = true
                self.dia = exam.value(forKey: "data") as! NSDate
                self.hora = exam.value(forKey: "hora") as! NSDate
                self.performSegue(withIdentifier: "MarcarExame", sender: nil)
                
                return true
            })
            
            ,MGSwipeButton(title: "",icon: UIImage(named:"Delete.png"), backgroundColor: UIColor.clear, callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                
                let exameExcluido = self.arrayExameSemana[indexPath.row]
                
                
                context.delete(self.arrayExameSemana[indexPath.row])
                self.arrayExameSemana.remove(at: indexPath.row)
                
                do {
                    try context.save()
                } catch {
                    print("Não foi possível retirar do BD")
                }
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                tableView.reloadData()
                
                return true
            })
        ]
        
        //                cell.leftSwipeSettings.transition = MGSwipeTransition.Rotate3D
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ExamesSemana.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detalhes", sender: self)
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
        
        getUser()
        
        edit = false
        
        //COREDATA
        
        let context = appDelegate.persistentContainer.viewContext as NSManagedObjectContext
        
        let fetchRequest: NSFetchRequest<Exame> = Exame.fetchRequest()
        
        do{
            let results = try context.fetch(fetchRequest)
            let exame = results
            
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
                print("ok")
            }else{
                print("Não há itens no BD")
            }
        } catch {
            print("Não foi possivel resgatar dados")
        }
        
        
        if(arrayExameSemana.count > 2){
           // ordenaExame()
        }
        
        ExamesSemana.reloadData()
    }
    
    func ordenaExame(){
        var fim = arrayExameSemana.endIndex - 1
        while fim > 0{
            var maior = 0
            for item in arrayExameSemana{
                let i1 = arrayExameSemana.index(of: item)
                if(item != arrayExameSemana[0]){
                    if(i1! <= fim){
                        
                        let horaPrim = item.value(forKey: "hora") as! NSDate
                        let horaSeg = arrayExameSemana[maior].value(forKey: "hora") as! NSDate
                        
                        if(horaPrim.isEqual(to: horaSeg as Date) == false){
                            if(horaPrim.laterDate(horaSeg as Date) == horaPrim as Date){
                                maior = i1!
                            }
                        }
                    }
                }
            }
            
            if(fim != maior){
                let subtituido = arrayExameSemana[fim]
                let substituto = arrayExameSemana[maior]
                arrayExameSemana.insert(substituto, at: fim)
                arrayExameSemana.remove(at: fim+1)
                arrayExameSemana.insert(subtituido, at: maior)
                arrayExameSemana.remove(at: maior+1)
            }
            fim -= 1
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "MarcarExame") {
            let vc = segue.destination as! NewExam
            vc.data = dia
            vc.edit = edit
            if edit == true{
                vc.horaI = hora
            }
        }
        
        if(segue.identifier == "detalhes"){
            let indexPaths = ExamesSemana.indexPathForSelectedRow
            let indexPath = indexPaths! as NSIndexPath
            let exam = arrayExameSemana[indexPath.row]
            let vc = segue.destination as! Detalhes
            vc.exame = exam
        }
    }
    
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
        //        else if(segue.identifier == "editar"){
        //            let vc = segue.destinationViewController as! MarcarConsulta
        //        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


