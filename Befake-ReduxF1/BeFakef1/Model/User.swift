//
//  User.swift
//  BeFakef1
//
//  Created by Elijah Senior on 4/17/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable,Equatable, Hashable {
    @DocumentID var id: String?
    var username: String
    var userBio: String
    var userBioLink: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL
}

