//
//  CitiesViewModel.swift
//  TaskEvaluation
//
//  Created by Evelin on 24/01/25.
//

import Foundation
import SwiftUI

struct citiesViewModel {
    
   //MARK: - Load json Data from App Bundle JSON file
    func loadJSONData() -> [CitiesModel]{
        guard let url = Bundle.main.url(forResource: "au_cities", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedData = try? JSONDecoder().decode([CitiesModel].self, from: data) else {
                  print("Failed to load or decode JSON")
                  return []
              }
         return decodedData
    }
    
    
}

