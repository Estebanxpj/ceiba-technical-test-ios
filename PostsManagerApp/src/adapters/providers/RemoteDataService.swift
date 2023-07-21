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
    
    func getData<T>(concatUrl: String,
                     success: @escaping (Int, [T]) -> (),
                     failure: @escaping (Int) -> ()) where T: BaseMappable {
        
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
                        failure(400)
                        return
                }
                
                switch serverResponse.statusCode {
                case 200, 201:
                    success(serverResponse.statusCode, resultValue)
                default:
                    failure(serverResponse.statusCode)
                }
                
        }
        
    }
    
}
