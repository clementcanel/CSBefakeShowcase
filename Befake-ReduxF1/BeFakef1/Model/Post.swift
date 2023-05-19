//
//  Post.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/29/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Foundation


struct Post: Codable, Identifiable, Equatable, Hashable {
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
    var likedCount: Int = 0
    var tag: Bool = false
    var comments: String = ""
}
