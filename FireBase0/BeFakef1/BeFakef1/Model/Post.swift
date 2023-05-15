//
//  Post.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/29/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Foundation


struct Post: Codable, Identifiable {
    @DocumentID var id: String?
    var text: String
    var imageURL: URL? = nil
    var imageReferenceID: String = ""
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var dislikedIDs: [String] = []
    var userName: String
    var userUID: String
    var userProfileURL: URL

    
    enum CodingKeys: CodingKey {
        case id
        case text
        case imageURL
        case imageReferenceID
        case publishedDate
        case likedIDs
        case dislikedIDs
        case userName
        case userUID
        case userProfileURL
        
    }
    
}
