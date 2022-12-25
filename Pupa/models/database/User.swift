import Foundation

class User : Codable {
    var Id: UUID
    var Login: String
    var Email: String
    var PhoneNumber: String
    var Password: String
    
    init(Login: String, Email: String, PhoneNumber: String, Password: String) {
        self.Id = UUID()
        self.Login = Login
        self.Email = Email
        self.PhoneNumber = PhoneNumber
        self.Password = Password
    }
    
    init(Id: UUID, Login: String, Email: String, PhoneNumber: String, Password: String) {
        self.Id = Id
        self.Login = Login
        self.Email = Email
        self.PhoneNumber = PhoneNumber
        self.Password = Password
    }
    
    init(json: Any) {
        let jsonDictionary = json as! [String: Any]
        self.Id = UUID(uuidString: (jsonDictionary["id"] as? String)!)!
        self.Login = (jsonDictionary["login"] as? String)!
        self.Email = (jsonDictionary["email"] as? String)!
        self.PhoneNumber = (jsonDictionary["phoneNumber"] as? String)!
        self.Password = (jsonDictionary["password"] as? String)!
    }
    
    init(data: Data){
        var tmpUser = try? JSONDecoder().decode(User.self,from:data)
        self.Id = tmpUser!.Id
        self.Login = tmpUser!.Login
        self.Email = tmpUser!.Email
        self.PhoneNumber = tmpUser!.PhoneNumber
        self.Password = tmpUser!.Password
    }
    
    func toJson() -> Any {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return jsonData
    }
    
    func toData() -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return jsonData
    }
}
