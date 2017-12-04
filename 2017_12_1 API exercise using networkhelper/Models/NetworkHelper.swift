//
//  NetworkHelper.swift
//  2017_12_1 API exercise using networkhelper
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    // is the key object responsible for sending and receiving HTTP requests .default: Creates a default configuration object that uses the disk-persisted global cache, credential and cookie storage objects.
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        //give it a task to perform
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    //notice that we can give a feedaback on the no data by using the errorHandler
                    errorHandler(AppError.noDataReceived)
                    return
                }
                //check for the error 200
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    errorHandler(AppError.badStatusCode)
                    return
                }
                if let error = error {
                    let error = error as NSError
                    //check for no internet connection
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet{
                        errorHandler(AppError.noInternetConnection)
                    }else{
                        errorHandler(AppError.other(rawError: error))
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
