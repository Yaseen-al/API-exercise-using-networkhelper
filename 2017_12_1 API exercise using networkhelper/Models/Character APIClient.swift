//
//  Character APIClient.swift
//  2017_12_1 API exercise using networkhelper
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct CharacterAPIClient {
    private init() {}
    static let manager = CharacterAPIClient()
    func getCharacter(from urlStr: String, completionHandler: @escaping ([Character]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let results = try JSONDecoder().decode(Results.self, from: data)
                completionHandler(results.results)
            }
            catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}
