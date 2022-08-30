//
//  ResultScreen.swift
//  OurCovidApp
//
//  Created by Aysha, Jignasa and Gelila on 2022-07-29.
//
import UIKit


class ResultScreen: UIViewController {

    var result: [CovidAPI.CovidData] = []
    var province: String = "test";
    
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var provinceName: UILabel!
    
    @IBOutlet weak var totalCases: UILabel!
    
    
    @IBOutlet weak var totalVaccinated: UILabel!
    
    @IBOutlet weak var totalRecoveries: UILabel!
    
    @IBOutlet weak var totalDeaths: UILabel!
    
    
    @IBOutlet weak var casesToday: UILabel!
    
    
    @IBOutlet weak var vaccinatedToday: UILabel!
    
    
    @IBOutlet weak var recoveriesToday: UILabel!
    
    
    @IBOutlet weak var deathsToday: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provinceName.text = province
        
        
        
        let totalData = result.compactMap { $0 }
        let covidData = totalData.last
        totalCases.text = String(describing: covidData?.totalCases ?? 0)
        totalVaccinated.text = String(describing: covidData?.totalVaccinated ?? 0)
        totalDeaths.text = String(describing: covidData?.totalFatalities ?? 0)
        totalRecoveries.text = String(describing: covidData?.totalRecoveries ?? 0)
        date.text = covidData?.date ?? ""
        casesToday.text = String(describing: covidData?.changeCases ?? 0)
        vaccinatedToday.text = String(describing: covidData?.changeVaccinated ?? 0)
        deathsToday.text = String(describing: covidData?.changeFatalities ?? 0)
        recoveriesToday.text = String(describing: covidData?.changeRecoveries ?? 0)
        
        
      }
    
}
