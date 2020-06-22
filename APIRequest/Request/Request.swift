
import Foundation

enum RequestMethod : String{
    case post = "POST"
    case get = "GET"
}

enum Result {
    case success([User])
    case failure(String)
}

public struct ServerTrustFailureReason : Decodable {
    public let status: String?
    public let message: String?
    public let code: String?
}
    



struct Request{
    var request : RequestMethod
    var headers : [String : String]?
    var params : [String : String]?
    var api : String
    
    
    init( api : String ,request : RequestMethod, headers: [String : String]? , params : [String : String]?)  {
        self.request = request
        self.api = api
        self.params = params
        self.headers = headers
    }
    
    
     func setRequest ()->URLRequest{
        var stringUrl = api
        var url = URL(string: stringUrl)
        var urlRequest = URLRequest(url: url!)
        let urlEncode = URLEncode()
  
        
        
        if let param = self.params {
            //set parameters
            if self.request == .get{
                let string = urlEncode.query(param)
                stringUrl += "?\(string)"
                url = URL(string: stringUrl)
                urlRequest = URLRequest(url: url!)
                urlRequest = NSMutableURLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0) as URLRequest
                urlRequest.httpMethod = self.request.rawValue
            }else{
                urlRequest = URLRequest(url: url!)
                urlRequest = NSMutableURLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0) as URLRequest
                urlRequest.httpMethod = self.request.rawValue
                let jsonData = try? JSONSerialization.data(withJSONObject: params as Any, options: [])
                let jsonString = String(data: jsonData!, encoding: .utf8)
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = jsonString!.data(using: .utf8)
            }
        }else{
            urlRequest = URLRequest(url: url!)
            urlRequest = NSMutableURLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0) as URLRequest
            urlRequest.httpMethod = self.request.rawValue
            
        }
        
       
        //set header
        if let header = self.headers{
            for h in header{
                urlRequest.addValue(h.value, forHTTPHeaderField: h.key)
            }
        }
        return urlRequest
       
    }
    
    
    
    func request(_ completion: @escaping(Result, _ a : String) -> Void) {
        let urlRequest = setRequest()
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data ,response, error in
           
            if let dataResponse = data{
                
                do{ let jsonString = String(data: dataResponse, encoding: .utf8)
                
                  let jsonResponse = try JSONSerialization.jsonObject(with:
                                     dataResponse, options: [])
                    
//                    print(jsonResponse)
                    let users = self.parseUsers(jsonResponse)
                    DispatchQueue.main.async {
                        completion(.success(users), jsonString!)
                    }
                }catch{
                   completion(.failure("Fail"),"Load fail")
                }
            }else{
                DispatchQueue.main.async {
                    completion(.failure("Fail"),"Load fail")
                }
            }
        }
        dataTask.resume()
    }
    
    
    func parseError(jsonString : String) -> ServerTrustFailureReason? {
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        let jsonDecoder = JSONDecoder()
        let error: ServerTrustFailureReason? = (try? jsonDecoder.decode(ServerTrustFailureReason.self, from: jsonData!))
        return error
    }
    
    func parseUsers(_ jsonResponse : Any) -> [User] {
        var users = [User]()
        guard let jsonArray = jsonResponse as? [[String: Any]] else {
              return users
        }
        for dic in jsonArray{
            users.append(User(dic)) // adding now value in Model array
        }
      
       return users
    }
   
}
    
    





