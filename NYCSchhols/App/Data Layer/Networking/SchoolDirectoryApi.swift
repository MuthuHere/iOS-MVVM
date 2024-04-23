//
//
// Copyright © 2024 
//


import Foundation
import Alamofire

typealias SchoolListApiResponse =  (Swift.Result<[School]?, DataError>) -> Void


protocol SchoolApiLogic {
    func getSchools(completion: @escaping  (SchoolListApiResponse))
}

class SchoolDirectoryApi : SchoolApiLogic {
    
    private struct APIConstants {
        static let schoolDataUrl = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=L1KwLSwm1yz1N7aWqFCF4dLmM"
    }
    
    func getSchools(completion: @escaping (SchoolListApiResponse)) {
       
        AF.request(APIConstants.schoolDataUrl)
            .validate()
            .responseDecodable(of: [School].self) { response in
                switch response.result {
                case .failure (let error):
                    completion(.failure(.networkingError(error.localizedDescription)))
                 case .success (let schools):
                    completion(.success(schools))
                }
            }
    }
    
    
    private func getSchoolsUsingAppleStandardApi() {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "data.cityofnewyork.us"
        urlComponent.path = "/resource/s3k6-pzi2.json"
        urlComponent.queryItems = [URLQueryItem(name: "$$app_token", value: "L1KwLSwm1yz1N7aWqFCF4dLmM")]
        
        if let url = urlComponent.url {
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { data, response, error in
                
                guard error == nil else {
                    print("error thrown \(String(describing: error))")
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let schools = try decoder.decode([School].self, from: data)
                        
                        print(schools)
                        
                    } catch let error {
                        print ("error \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}
