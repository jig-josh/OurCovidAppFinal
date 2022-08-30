//
//  ProvinceData.swift
//  OurCovidApp
//
//  Created by Aysha, Jignasa and Gelila on 2022-07-28.
//

import UIKit

class Province {
    
    var title : String
    init(title: String){
        self.title = title
    }
}

struct ProvinceModel: Codable {
    
    var deaths: Int
    var cases: Int
    var date: String
    var vaccinated: Int
    var recoveries: Int
}

/*
 "date": "2020-01-25",
       "change_cases": 1,
       "change_fatalities": 0,
       "change_tests": 0,
       "change_hospitalizations": 0,
       "change_criticals": 0,
       "change_recoveries": 0,
       "change_vaccinations": 0,
       "change_vaccinated": 0,
       "change_boosters_1": 0,
       "change_boosters_2": 0,
       "change_vaccines_distributed": 0,
       "total_cases": 1,
       "total_fatalities": 0,
       "total_tests": 0,
       "total_hospitalizations": 0,
       "total_criticals": 0,
       "total_recoveries": 0,
       "total_vaccinations": 0,
       "total_vaccinated": 0,
       "total_boosters_1": 0,
       "total_boosters_2": 0,
       "total_vaccines_distributed": 0
 */

extension CovidAPI {
    
    struct APIResponse: Codable {
        let data: [CovidData]
        let province: String
    }
    struct CovidData: Codable {
        let date: String
        var totalCases: Int
        var totalFatalities: Int
        var totalVaccinated: Int
        var totalRecoveries: Int
        var changeCases: Int
        var changeFatalities: Int
        var changeVaccinated: Int
        var changeRecoveries: Int
        
    }
}

