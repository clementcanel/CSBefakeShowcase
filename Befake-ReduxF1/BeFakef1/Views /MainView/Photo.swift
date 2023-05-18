//
//  Result .swift
//  BeFakef1
//
//  Created by Elijah Senior on 5/4/23.
//

import Foundation
import SwiftUI



struct Photo: Codable, Identifiable {
    var id: String
    var urls: [String : String]
}

class UnsplashData: ObservableObject {
    @Published var photoArray: [Photo] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        let key = "25JlyZnUJRa_CkZDD1OQYf_0tBM3ys7ERVH1hNAZE1Y"
        let url = "https://api.unsplash.com/photos/random/?count=30&client_id=\(key)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string : url)!) {(data, _, error) in
            guard let data = data else {
                print("URLSEssion data error", error ?? "nil")
                return
            }
            do{
                let json = try JSONDecoder().decode([Photo].self, from: data)
                print(json)
                for photo in json {
                    DispatchQueue.main.async {
                        self.photoArray.append(photo)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
