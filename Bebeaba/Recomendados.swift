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
    
    @IBOutlet var viewExamesRecomendados: UIView!
    
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objectsArray = [Objects]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Rectangle 3")
        self.view.insertSubview(backgroundImage, at: 0)

        
        ExamesRecomendados.delegate = self
        ExamesRecomendados.dataSource = self

        objectsArray = [Objects(sectionName: "1 Trimestre", sectionObjects: ["Pressão arterial","Altura uterina ", "Hemograma completo", "Tipo sanguíneo e fator Rh","VDRL", "HIV", "Hepatite B e C", "Tireóide", "Glicemia de Jejum ", "Toxoplasmose", "Rubéola", "Citomegalovírus (ou CMV)","Ultrassonografia Transvaginal com Doppler ", "Urina", "Exame Ginecológico"]), Objects(sectionName: "2 Trimestre", sectionObjects: ["Pressão arterial","Altura uterina", "Ultrassom morfológico","Ultrassonografia para Medida de Colo", "Urinocultura", "Fibronectina fetal", "Hemograma", "Glicose", "VDRL", "Toxoplasmose" ]), Objects(sectionName: "3 Trimestre", sectionObjects: ["Aferição da pressão arterial", "Medição da altura da barriga", "Ultrassom obstétrico","HIV I e II  ", "Plaquetas" ,  "Urinocultura", "Cardiotocografia", "Pesquisa da bactéria estreptococo B", "Perfil biofísico fetal"])]
        
        viewExamesRecomendados.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)

        
    }
 
    
    // Muda a cor do texto da sessão
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor(red: 226/255.0, green: 108/255.0, blue: 132/255.0, alpha: 1.0)
     
          //  headerTitle.backgroundColor = UIColor.black
        
        }
    }
 
    
    // Fundo levemente branco da celula
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor(white: 1, alpha: 1)
        
    }
    
    
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! /* as UITableViewCell*/
        
        cell.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
        // Muda  a cor do conteudo da celula
        cell.textLabel?.textColor = UIColor(red: 131/255.0, green: 129/255.0, blue: 134/255.0, alpha: 1.0)
   
        return cell
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ExamesRecomendados.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
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
