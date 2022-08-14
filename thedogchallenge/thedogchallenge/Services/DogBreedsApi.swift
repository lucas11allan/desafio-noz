//
//  FetchDogsApi.swift
//  thedogchallenge
//
//  Created by Lucas Allan Almeida Oliveira on 11/08/22.
//

import Foundation
import Alamofire

enum ServiceReturn {
    case success(Service.Images)
    case noContent
    case error(Error)
}

protocol Service {
    typealias Images = [BreedImage]
    typealias ImagesHandler = (ServiceReturn) -> Void

    func fetchImages(page: Int, completionHandler: @escaping ImagesHandler)
}

class DogBreedsApi: Service {
    private let limit = 20
    private let baseUrl = "https://api.thedogapi.com/v1"
    private let publicKey = "api_key=20febf79-3164-47bf-a653-40abca91c352"
    private let jsonDecoder: JSONDecoder  = JSONDecoder()
    
    func fetchImages (
        page: Int = 1,
        completionHandler: @escaping ImagesHandler
    ) {
        let params = ["page": page] as [String : Any]

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

            completionHandler(.success(data))
        }
    }

    func fetchApi<T>(
        endpoint: String,
        parameters: [String: Any] = [:],
        type: T.Type = T.self,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) where T: Decodable {
        var parameters = parameters
        
        parameters["limit"] = 20
        let httpHeaders = ["x-api-key": publicKey] as HTTPHeaders
        
        AF.request("\(baseUrl)\(endpoint)", parameters: parameters, headers:  httpHeaders)
            .validate(statusCode: 200..<300)
            .responseDecodable (of: type, completionHandler: completionHandler)
    }
}

