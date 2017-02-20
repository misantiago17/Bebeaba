//
//  Recomendados.swift
//  Bebeaba
//
//  Created by Michelle Beadle on 08/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit

class Recomendados: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ExamesRecomendados: UITableView!
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objectsArray = [Objects]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExamesRecomendados.delegate = self
        ExamesRecomendados.dataSource = self

        objectsArray = [Objects(sectionName: "Semana 2", sectionObjects: ["Primeira Consulta","Ultrassonografia", "Exame de Sangue", "Preveção do colo de útero"]), Objects(sectionName: "Semana 9", sectionObjects: ["Consulta pré-natal","Agendar ultrasom translucência nucal"]), Objects(sectionName: "Semana 13", sectionObjects: ["Avaliação odontológica"]), Objects(sectionName: "Semana 24", sectionObjects: ["Teste de tolerância a glicose", "Hemograma Completo", "Agendar ultrassom"])]
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! /* as UITableViewCell*/
        
        cell.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
        return cell
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectsArray[section].sectionObjects.count
    }
    
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
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
