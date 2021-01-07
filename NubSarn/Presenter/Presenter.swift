//
//  mainPresenter.swift
//  NubSarn
//
//  Created by PMJs on 7/1/2564 BE.
//

import Foundation

protocol PresenterView {
    
    func updateWantedPerDay(with Data : [[Int]])
    func updateEatenPerDay(with Data : [[Int]])
    func updateMorePerDay(with Data : [[Int]])
    func alert(withMessage message: String,_ title : String,_ actionMessage : [String])
    func clearAddTextFiled()
    
}

class Presenter {
    
    let mainViewController : PresenterView
    let defaults = UserDefaults.standard
    var userData : [[Int]] = [[160,130,55],[0,0,0],[0,0,0]] // wanted,eaten,more // carb,protein,fat
    
    init(with mainViewController : PresenterView) {
        self.mainViewController = mainViewController
    }
    
    func forViewDidload()  {
        loadDataFromUserDefaults()
        updateUIPerday()
    }
    
    func loadDataFromUserDefaults() {
        
        if let loadedUserData = defaults.array(forKey: "userData") as? [[Int]] {
            userData = loadedUserData
        } else {
            defaults.setValue(userData, forKey: "userData")
        }
    }
    
    func updateUIPerday() {
        mainViewController.updateWantedPerDay(with: userData)
        mainViewController.updateEatenPerDay(with: userData)
        calculateMorePerDay()
    }
    
    func calculateMorePerDay() {
        //calculate
        let moreCard = userData[0][0] - userData[1][0]
        let moreProtein = userData[0][1] - userData[1][1]
        let moreFat = userData[0][2] - userData[1][2]
        
        //save back to userDefault
        userData[2][0] = moreCard //carb
        userData[2][1] = moreProtein // protein
        userData[2][2] = moreFat // fat
        defaults.setValue(userData, forKey: "userData")
        
        //change UI
        mainViewController.updateMorePerDay(with: userData)
    }
    
    func calculateNewEatenPerDay(with userFillCarb : Int,with userFillProtein : Int,with userFillFat : Int)  {
        let oldEatenCarbPerDay = userData[1][0]
        let oldEatenProteinPerDay = userData[1][1]
        let oldEatenFatPerDay = userData[1][2]
        
        let newEatenCarbPerDay = userFillCarb + oldEatenCarbPerDay
        let newEatenProteinPerDay = userFillProtein + oldEatenProteinPerDay
        let newEatenFatPerDay = userFillFat + oldEatenFatPerDay
        
        userData[1][0] = newEatenCarbPerDay
        userData[1][1] = newEatenProteinPerDay
        userData[1][2] = newEatenFatPerDay
    }
    
  
    func updateButton(carb : String, protien : String, fat : String)  {
        if let userFillCarb = Int(carb) ,
           let userFillProtein = Int(protien),
           let userFillFat = Int(fat) {
            
            loadDataFromUserDefaults()  // load data
            calculateNewEatenPerDay(with: userFillCarb, with: userFillProtein, with: userFillFat) // calculate new one
            defaults.setValue(userData, forKey: "userData") // save back to cache
            updateUIPerday()
            mainViewController.clearAddTextFiled()
            
        } else {
            mainViewController.alert(withMessage: "Please fill the empty text filed", "error", ["dismiss"])
        }
    }
    
    func resetButton()  {
        resetEaten()
    }
    
    func resetEaten() {
        //update userData to be present
        loadDataFromUserDefaults()
        
        //reset eaten
        userData[1][0] = 0
        userData[1][1] = 0
        userData[1][2] = 0
        
        //save eaten
        defaults.setValue(userData, forKey: "userData")
        
        //updateUI
        updateUIPerday()
    }
    
    
    
}
