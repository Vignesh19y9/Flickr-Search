//
//  NetworkEngine.swift
//  Network Layer Flicker
//
//  Created by Vignesh on 29/03/22.
//

import Foundation

//Network protocol is used for dependency injection in view model
protocol NetworkProtocol{
    
}

class NetworkEngine : NetworkProtocol{
    /*Executes the web call and will decode the JSON response into codable  object provided
     - parameters
      - endpoint: the end point to make the HTTP request against
      - completion: the JSON response converted to the provided Codable object */
    //1
    func request<T: Codable>(endpoint: FlickrEndpoint, completion: @escaping (Result<T, Error>) -> ()){
        
        //2
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        //3
        guard let url = components.url else { return }
        print("url : ",url)
        //4
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        //5
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest){data, response, error in
            
            //6
            guard error == nil else{
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data){
                    
                    completion(.success(responseObject))
                }else{
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "bad response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
