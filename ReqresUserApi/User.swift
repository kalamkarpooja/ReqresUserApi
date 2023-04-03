//
//  User.swift
//  ReqresUserApi
//
//  Created by Mac on 02/04/23.
//

import Foundation
struct User : Decodable{
    var id : Int?
    var email : String?
    var first_name : String?
    var last_name : String?
    var  avatar : String?
}
