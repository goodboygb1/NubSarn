//
//  ViewController.swift
//  NubSarn
//
//  Created by PMJs on 6/1/2564 BE.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var wantedCarbPerDay: UILabel!
    
    @IBOutlet weak var wantedProteinPerDay: UILabel!
    
    @IBOutlet weak var wantedFatPerDay: UILabel!
    
    @IBOutlet weak var eatenCarbPerDay: UILabel!
    
    @IBOutlet weak var eatenProteinPerDay: UILabel!
    
    @IBOutlet weak var eatenFatPerDay: UILabel!
    
    @IBOutlet weak var moreCarbPerDay: UILabel!
    
    @IBOutlet weak var moreProteinPerDay: UILabel!
    
    @IBOutlet weak var moreFatPerDay: UILabel!
    
    @IBOutlet weak var addMoreCarbTextField: UITextField!
    
    @IBOutlet weak var addMoreProteinTextField: UITextField!
    
    @IBOutlet weak var addMoreFatTextField: UITextField!
    
    
    
    lazy var presenter = Presenter(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.forViewDidload()
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        presenter.updateButton(carb: addMoreCarbTextField.text!, protien: addMoreProteinTextField.text!, fat: addMoreFatTextField.text!)
    }
    
    @IBAction func resetButton(_ sender: Any) {
        presenter.resetButton()
    }
    
    
    
}

extension ViewController : PresenterView {
    func clearAddTextFiled() {
        addMoreCarbTextField.text = ""
        addMoreProteinTextField.text = ""
        addMoreFatTextField.text = ""
    }
    
   func updateWantedPerDay(with Data: [[Int]]) {
        let wantedPerDay = Data[0]
        wantedCarbPerDay.text = String(wantedPerDay[0])
        wantedProteinPerDay.text = String(wantedPerDay[1])
        wantedFatPerDay.text = String(wantedPerDay[2])
    }
    
    func updateEatenPerDay(with Data: [[Int]]) {
        let eatenPerDay = Data[1]
        eatenCarbPerDay.text = String(eatenPerDay[0])
        eatenProteinPerDay.text = String(eatenPerDay[1])
        eatenFatPerDay.text = String(eatenPerDay[2])
    }
    
    func updateMorePerDay(with Data: [[Int]]) {
        let morePerDay = Data[2]
        moreCarbPerDay.text = String(morePerDay[0])
        moreProteinPerDay.text = String(morePerDay[1])
        moreFatPerDay.text = String(morePerDay[2])
    }
    
    func alert(withMessage message: String,_ title : String,_ actionMessage : [String]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for actionMess in actionMessage {
            let action = UIAlertAction(title: actionMess, style: .default, handler: nil)
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}

