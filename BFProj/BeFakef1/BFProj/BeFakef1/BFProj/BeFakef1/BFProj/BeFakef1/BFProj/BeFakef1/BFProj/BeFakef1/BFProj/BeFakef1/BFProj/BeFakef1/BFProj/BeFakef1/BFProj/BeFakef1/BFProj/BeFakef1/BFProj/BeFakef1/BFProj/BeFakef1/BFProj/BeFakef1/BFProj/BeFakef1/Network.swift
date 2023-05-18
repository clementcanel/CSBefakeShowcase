import Foundation
import FirebaseAuth

typealias ResultClosure = (Result<Decodable, Error>) -> Void
protocol NetworkAble {
    func startRequest(completion: ResultClosure)  async throws -> NetworkErrorType
    func stopRequest(completion: ResultClosure)  async throws -> NetworkErrorType
}

enum NetworkType {
    case login
    case logout
    case forgotpass
    case refresh
    case get
    case put
    case update
    case delete
}

enum NetworkErrorType: Error {
    
    case serialize
    case network
    case server
    case firebaseError(String)
    case database
    case none
}

