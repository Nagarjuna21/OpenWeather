//
//  NetworkConfig.swift
//  OpenWeather
//
//  Created by Nagarjuna Madamanchi on 03/11/2017.
//  Copyright © 2017 Nagarjuna. All rights reserved.
//

struct JsonResponseKeys {
    static let List = "list"
    static let Cities = "Cities"
    static let Id = "id"
    static let Name = "name"
    static let ImageName = "imageName"
    static let Description = "description"
    static let Icon = "icon"
    static let DateTime = "dt"
    static let Weather = "weather"
    struct Main {
        static let TempMin = "main.temp_min"
        static let TempMax = "main.temp_max"
    }
    
    static let DateTxt = "dt_txt"
}

struct APIKeys {
    static let BaseUrl = "http://api.openweathermap.org/"
    static let ImageURL = "http://openweathermap.org/img/w/"
}

struct Methods {
    static let ForecastDataVersion = "data/2.5/forecast"
}

struct Parameter {
    struct Key {
        static let CityId   = "q"
        static let AppId    = "APPID"
    }
    struct Value {
        static let CityValue = "London"
        static let AppKey = "5ecf8bf12667782c4993c301a958f767"
    }
}

struct HTTPMethods {
    static let get = "GET"
}

struct HTTPHeader {
    struct Key {
        static let contentType = "Content-Type"
    }
    struct Value {
        static let contentType = "application/json"
    }
}

struct JSONErrorKey {
    static let error = "Error"
}

struct JSONErrorValue {
    static let error = "Error"
    static let badRequest = "BadRequest"
    static let unauthorized = "Unauthorized"
    static let noData = "NoData"
    static let authorizationDenied = "Authorization has been denied for this request."
}
