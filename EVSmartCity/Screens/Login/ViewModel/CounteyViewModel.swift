//
//  CounteyViewModel.swift
//  EVSmartCity
//
//  Created by Hitman on 29/04/26.
//

import Foundation

class CountryViewModel {
    func loadCountries(completion: @escaping ([CountryModel]) -> Void) {
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: "countries_with_lengths", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([CountryModel].self, from: data)
                DispatchQueue.main.async {
                    completion(countries)
                }
            } catch {
   #if DEBUG
                    print("loadCountries function: \(error.localizedDescription)")
   #endif
                
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
}
