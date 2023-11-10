
import Foundation

enum NetworkError: Error {
    case decodeError
}

final class NetworkService {
    
    static var shared = NetworkService()
    
    let session: URLSession
    
    init() {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        self.session = urlSession
    }
    
    func getMovieData<T: Codable>(urlString: String, completion: @escaping (Result<T,Error>) -> (Void)) {
        
        guard let url = URL(string: urlString) else { return }
        
        session.dataTask(with: URLRequest(url: url)) {data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("no response")
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("status code")
                return
            }
            
            guard let data else { return }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(MovieSearched.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(object.Search as! T))
                }
            } catch {
                completion(.failure(NetworkError.decodeError))
                print("decode error")
                print(error)
            }
        }.resume()
    }
}
