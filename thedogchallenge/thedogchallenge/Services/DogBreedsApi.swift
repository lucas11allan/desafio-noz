//
//  FetchDogsApi.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import Alamofire

enum ServiceReturn {
    case success(Service.Image)
    case successImage(Service.Images)
    case successSearch(Service.Search)
    case noContent
    case error(Error)
}

protocol Service {
    typealias Image = BreedImage
    typealias Images = [BreedImage]
    typealias Search = [Breed]
    typealias Handler = (ServiceReturn) -> Void

    func fetchImages(page: Int, order: String, completionHandler: @escaping Handler)
}

class DogBreedsApi: Service {
    private let limit = 20
    private let baseUrl = "https://api.thedogapi.com/v1"
    private let publicKey = "api_key=20febf79-3164-47bf-a653-40abca91c352"
    
    func fetchImages (
        page: Int = 0,
        order: String,
        completionHandler: @escaping Handler
    ) {
        let params = ["page": page, "limit": 20, "order": order] as [String : Any]

        fetchApi(
            endpoint: "/images/search",
            parameters: params,
            type: Images.self
        ) { response in
            print(response)
            if let error = response.error {
                completionHandler(.error(error))
                return
            }

            guard let data = response.value else {
                completionHandler(.noContent)
                return
            }

            completionHandler(.successImage(data))
        }
    }
    
    func fetchImage (id: String, completionHandler: @escaping Handler) {
        fetchApi(
            endpoint: "/images/\(id)",
            type: Image.self
        ) { response in
            if let error = response.error {
                completionHandler(.error(error))
                return
            }

            guard let data = response.value else {
                completionHandler(.noContent)
                return
            }

            completionHandler(.success(data))
        }
    }
    
    func fetchSearchBreeds (
        query: String,
        page: Int = 1,
        completionHandler: @escaping Handler
    ) {
        let params = ["page": page, "q": query] as [String : Any]

        fetchApi(
            endpoint: "/breeds/search",
            parameters: params,
            type: Search.self
        ) { response in
            if let error = response.error {
                completionHandler(.error(error))
                return
            }

            guard let data = response.value else {
                completionHandler(.noContent)
                return
            }

            completionHandler(.successSearch(data))
        }
    }

    func fetchApi<T>(
        endpoint: String,
        parameters: [String: Any] = [:],
        type: T.Type = T.self,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) where T: Decodable {
        
        let httpHeaders = ["x-api-key": publicKey] as HTTPHeaders
        
        AF.request("\(baseUrl)\(endpoint)", parameters: parameters, headers:  httpHeaders)
            .validate(statusCode: 200..<300)
            .responseDecodable (of: type, completionHandler: completionHandler)
    }
}

