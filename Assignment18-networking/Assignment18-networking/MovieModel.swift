
import Foundation

struct MovieSearched: Codable {
    
    struct Movie: Codable {
        let Title: String
        let Poster: String
    }
    
    let Search: [Movie]
    let totalResults: String
    let Response: String
}
