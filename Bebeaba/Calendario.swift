//
//  Calendario.swift
//  Bebeaba
//
//  Created by Michelle Beadle on 08/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit
import FSCalendar

class Calendario: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    func calendar(_ calendar: FSCalendar, hasEventFor date: Date) -> Bool {
    
        
        return true
        
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
