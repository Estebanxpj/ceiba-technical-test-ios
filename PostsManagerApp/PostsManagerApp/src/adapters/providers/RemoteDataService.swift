//
//  RemoteDataService.swift
//  PostsManagerApp
//
//  Created by Sebastian Betancur Salazar on 21/07/23.
import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class RemoteDataService {

    var baseURL: URL?
    lazy var serviceUrl: String = {
        return "https://jsonplaceholder.typicode.com/"
    }()
    
    required init(){
        self.baseURL = URL(string: serviceUrl)
    }
    
    func getData<T>(_type: T.Type, concatUrl: String,
                    complete: @escaping (Int, [T]) -> ()) where T: BaseMappable {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        guard let url = NSURL(string: concatUrl , relativeTo: self.baseURL as URL?) else {
            return
        }
        
        let urlString = url.absoluteString!
        	
        Alamofire
            .request(urlString,
                     method: .get,
                     encoding: JSONEncoding.default,
                     headers: headers)
            .responseArray { (dataResponse: DataResponse<[T]>) in
                
                guard let serverResponse = dataResponse.response,
                    let resultValue = dataResponse.result.value else {
                    complete(400, [])
                        return
                }
                
                switch serverResponse.statusCode {
                case 200, 201:
                    complete(serverResponse.statusCode, resultValue)
                default:
                    complete(serverResponse.statusCode, [])
                }
                
        }
        
    }
    
}

