//
//  RequestModel.swift
//  NguyenMinhHoangEx02
//
//  Created by Hoang on 11/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import Foundation
import ObjectMapper

class RequestModel{
    static let baseURL = "https://mockapi.superoffice.vn/api/baitap2/"
    func getData<T: Mappable>(fromUrl urlString: String = baseURL, withEndPoint endPoint: String, completionBlock: @escaping (Bool, T?)-> Void ) {
        let ultimateURLString = urlString + endPoint
        guard let url = URL(string: ultimateURLString) else {
            completionBlock(false, nil)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    if let dataObject = T.init(JSON: json) {
                        completionBlock(true, dataObject)
                    } else {
                        completionBlock(false, nil)
                    }
                } catch {
                    completionBlock(false, nil)
                }
            }
        }).resume()
    }
}
