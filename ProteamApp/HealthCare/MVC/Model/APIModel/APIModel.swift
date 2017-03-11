//
//  APIModel.swift
//  HealthCare
//
//  Created by IchIT on 3/11/17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit
import Alamofire

class APIModel: NSObject {
    static let headers:[String:String] = ["Content-Type": "application/json","Accept": "application/json"]
    
    //MARK: header token
    class func getHeaderWithToken() -> [String : String] {

            let token = UserDefaults.standard.string(forKey: "access_token")

        if token != nil {
            let headers:[String:String] = [
                "Content-Type": "application/json", "authorization": String(format:"bearer %@", token!)
            ]
            return headers
        }
        return ["":""]
    }
    //MARK: - LOGIN
    class func  loginFace(_ access_token: String, completion:@escaping (_ token:String)->Void, failure:@escaping (_ errorString: String)->Void){
        
        var parameters = Dictionary<String, Any>()
        parameters["access_token"] = access_token
        
        let header = headers
        
        let request = Alamofire.request(Constants.URLs.login, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                if let access_token = result["access_token"] as? String{
                    UserDefaults.standard.set(access_token, forKey: "access_token")
                    UserDefaults.standard.synchronize()
                    completion(access_token)
                }
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }

    //MARK: - ALL CATEGORY EXERCISE
    class func  getAllExerciseCategory(completion:@escaping (_ exerciseCategory:[ExerciseCategory])->Void, failure:@escaping (_ errorString: String)->Void){

        let request = Alamofire.request(Constants.URLs.excerciseCategory, method: .get, parameters: nil, headers: nil)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                
                if let code = result["code"] as? Bool,code == true{
                    
                    if let results = result["result"] as? [[String:Any]] {
                        var tmpExercise = [ExerciseCategory]()
                        for each in results{
                            if let exerciseCategory = ExerciseCategory.init(jsonData: each) {
                                tmpExercise.append(exerciseCategory)
                            }
                        }
                        completion(tmpExercise)
                        
                    }
                } else {
                    if let results = result["message"] as? [String:Any],let mes = results["message"] {
                        failure(mes as! String)
                    }
                }
                
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }
    
    //MARK: - ALL CATEGORY EXERCISE
    class func  getAllEatCategory(completion:@escaping (_ exerciseCategory:[EatCategory])->Void, failure:@escaping (_ errorString: String)->Void){
        
        let request = Alamofire.request(Constants.URLs.eeatCategory, method: .get, parameters: nil, headers: nil)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                
                if let code = result["code"] as? Bool,code == true{
                    
                    if let results = result["result"] as? [[String:Any]] {
                        var tmpEat = [EatCategory]()
                        for each in results{
                            if let eatCategory = EatCategory.init(jsonData: each) {
                                tmpEat.append(eatCategory)
                            }
                        }
                        completion(tmpEat)
                        
                    }
                } else {
                    if let results = result["message"] as? [String:Any],let mes = results["message"] {
                        failure(mes as! String)
                    }
                }
                
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }
    
    //MARK: - POST SETTING
    class func  postSetting(_param:[String:Any],completion:@escaping (_ message:String)->Void, failure:@escaping (_ errorString: String)->Void){
        
        let header = self.getHeaderWithToken()
        var parameters = [String: Any]()
        parameters["setting"] = ""

        let request = Alamofire.request(Constants.URLs.setting, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: header)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                
                if let code = result["code"] as? Bool,code == true{
                    
                    if let message = result["message"] as? String {
                        completion(message)
                        
                    }
                } else {
                    if let results = result["message"] as? [String:Any],let mes = results["message"] {
                        failure(mes as! String)
                    }
                }
                
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }

    //MARK: - GET SETTING
    class func  getSetting(completion:@escaping (_ message:Any)->Void, failure:@escaping (_ errorString: String)->Void){
        
        let header = self.getHeaderWithToken()
        
        let request = Alamofire.request(Constants.URLs.setting, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: header)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                
                if let code = result["code"] as? Bool,code == true{
                    
                    if let message = result["message"] as? String {
                        completion(message)
                        
                    }
                } else {
                    if let results = result["message"] as? [String:Any],let mes = results["message"] {
                        failure(mes as! String)
                    }
                }
                
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }
    
    //MARK: - Like Exercise
    class func  likeExercise(_ _id:String,completion:@escaping (_ message:Any)->Void, failure:@escaping (_ errorString: String)->Void){
        
        let header = self.getHeaderWithToken()
        
        let request = Alamofire.request(Constants.URLs.likeExercise + "\(_id)", method: .post, parameters: nil,encoding: JSONEncoding.default, headers: header)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                
                if let code = result["code"] as? Bool,code == true{
                    
                    if let message = result["message"] as? String {
                        completion(message)
                        
                    }
                } else {
                    if let results = result["message"] as? [String:Any],let mes = results["message"] {
                        failure(mes as! String)
                    }
                }
                
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }
    
    //MARK: - Like Exercise
    class func  unlikeExercise(_ _id:String,completion:@escaping (_ message:Any)->Void, failure:@escaping (_ errorString: String)->Void){
        
        let header = self.getHeaderWithToken()
        
        let request = Alamofire.request(Constants.URLs.unlikeExercise + "\(_id)", method: .post, parameters: nil,encoding: JSONEncoding.default, headers: header)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                
                if let code = result["code"] as? Bool,code == true{
                    
                    if let message = result["message"] as? String {
                        completion(message)
                        
                    }
                } else {
                    if let results = result["message"] as? [String:Any],let mes = results["message"] {
                        failure(mes as! String)
                    }
                }
                
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }
    
    //MARK: - Like FOOD
    class func  likeFood(_ _id:String,completion:@escaping (_ message:Any)->Void, failure:@escaping (_ errorString: String)->Void){
        
        let header = self.getHeaderWithToken()
        
        let request = Alamofire.request(Constants.URLs.likeFood + "\(_id)", method: .post, parameters: nil,encoding: JSONEncoding.default, headers: header)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                
                if let code = result["code"] as? Bool,code == true{
                    
                    if let message = result["message"] as? String {
                        completion(message)
                        
                    }
                } else {
                    if let results = result["message"] as? [String:Any],let mes = results["message"] {
                        failure(mes as! String)
                    }
                }
                
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }
    
    //MARK: - UnLike FOOD
    class func  unlikeFood(_ _id:String,completion:@escaping (_ message:Any)->Void, failure:@escaping (_ errorString: String)->Void){
        
        let header = self.getHeaderWithToken()
        
        let request = Alamofire.request(Constants.URLs.unLikeFood + "\(_id)", method: .post, parameters: nil,encoding: JSONEncoding.default, headers: header)
        
        request.responseJSON { response in
            if let result = response.result.value as? [String : AnyObject] {
                
                if let code = result["code"] as? Bool,code == true{
                    
                    if let message = result["message"] as? String {
                        completion(message)
                        
                    }
                } else {
                    if let results = result["message"] as? [String:Any],let mes = results["message"] {
                        failure(mes as! String)
                    }
                }
                
                
            } else {
                if response.result.error?._code == -1009{
                    failure("Vui lòng kiểm tra kêt nối mạng wifi hoặc 3G")
                } else {
                    //failure(response.result.error.debugDescription)
                    failure("Lỗi Server")
                }
            }
        }
    }
}
