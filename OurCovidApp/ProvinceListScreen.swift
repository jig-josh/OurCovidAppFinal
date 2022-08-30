//
//  ProvinceListScreen.swift
//  OurCovidApp
//
//  Created by Aysha, Jignasa and Gelila on 2022-07-27.
//

import UIKit

class ProvinceListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let provinces = ["Ontario" : "on", "British Columbia": "bc", "Alberta": "ab","Nova Scotia": "ns", "New Brunswick": "nb", "Quebec": "qc", "Saskatchewan": "sk", "Manitoba": "mb", "PEI": "pe", "Newfoundland": "nl"]
    
    var response: [CovidAPI.CovidData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   

}
extension ProvinceListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provinces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProvinceCell") as! ProvinceCell
        let dict = Array(provinces.keys).sorted()
        
        cell.provinceName?.text = dict[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let dict = Array(provinces.keys).sorted()
        
        print(provinces[dict[indexPath.row]] ?? "")
        
        guard let provinceCode = provinces[dict[indexPath.row]] else {
            return
        }
        print(dict[indexPath.row])
        
        
        
        let api = CovidAPI()
        api.fetchCovidData(province: provinceCode) { result in
           
         
            switch result {
            case .success(let response):
                self.response = response.data
                print(response.data.last ?? "")
                
                let vc = self.storyboard?.instantiateViewController(identifier: "display") as! ResultScreen
                vc.result = self.response
                
                let provinceList = Array(self.provinces.keys).sorted()
                vc.province = provinceList[indexPath.row]
            
                self.navigationController?.pushViewController(vc, animated: true)
              
                
               
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
