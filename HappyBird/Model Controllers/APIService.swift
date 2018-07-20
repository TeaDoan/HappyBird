//
//  APIService.swift
//  HappyBird
//
//  Created by Thao Doan on 7/11/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

enum Result <T> {
    case Success (T)
    case Error (String)
}

class APIService : NSObject {
    
    struct Contants {
        static let oneQuoteADayBaseURL = URL(string:"http://quotes.rest/qod.json")
        static let randomFunQuoteURL = URL(string:"http://quotes.stormconsultancy.co.uk/popular.json")
        static let randomQuoteBaseURL = URL(string:"https://random-quote-generator.herokuapp.com/api/quotes/")
        static let jokesBaseURL = URL(string:"http://api.icndb.com/jokes/$jokenumber")
        static let oneJokeADayBaseURL = URL(string: "https://icanhazdadjoke.com/")
        static let searchRanDomJokeBaseURL = URL(string: "https://icanhazdadjoke.com/search")
    }
    static var shared = APIService()
    
    func fetchQuote (completion: @escaping ([OneQuoteADay]?) -> Void){
        guard let url = Contants.oneQuoteADayBaseURL else {
            print("Error with baseURL")
            completion(nil)
            return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error downloading quotes with Datatask : \(error)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            let jsonDecoder = JSONDecoder()
            
            do {
                let dictict = try jsonDecoder.decode(ToplevelData.self, from: data)
                let quote = dictict.contents.quotes
                completion(quote)
                
            } catch let error {
                print("Error decoding quotes from data task: \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    func fetchRandomFunQuote(completion: @escaping([RandomQuotes]?) -> Void){
        guard let url = Contants.randomFunQuoteURL else {
            print("Error with baseURL")
            completion(nil)
            return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error downloading quotes with Datatask : \(error)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            let jsonDecoder = JSONDecoder()
            do {
                let topLevel = try jsonDecoder.decode([RandomQuotes].self, from: data)
                let quote = topLevel.compactMap{$0}
                completion(quote)
                return
                
            } catch let error {
                print("Error decoding quotes from data task: \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    func fetchRandomQuotes(completion: @escaping([RandomQuotes]?) -> Void){
        guard let url = Contants.randomQuoteBaseURL else {
            print("Error with baseURL")
            completion(nil)
            return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error downloading quotes with Datatask : \(error)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            let jsonDecoder = JSONDecoder()
            do {
                let topLevel = try jsonDecoder.decode([RandomQuotes].self, from: data)
                let quote = topLevel.compactMap{$0}
                completion(quote)
                return
                
            } catch let error {
                print("Error decoding quotes from data task: \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    
    func fetchJokes(completion: @escaping ([Value]?) -> Void) {
        guard let url = Contants.jokesBaseURL else {return}
        URLSession.shared.dataTask(with: url) { (data , _, error) in
            if let error = error {
                print("Error downloading quotes with Datatask : \(error)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil);return}
            let jsonDecoder  = JSONDecoder()
            do {
                let toplevelData = try jsonDecoder.decode(JokeTopLevelJson.self, from: data)
                let jokeArray = toplevelData.value.compactMap{$0}
                completion(jokeArray)
                
            } catch let error {
                print("Error decoding quotes from data task: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            }.resume()
        
    }
    
    func fetchRanDomJoke(completion: @escaping (OneJokeADay?) -> Void) {
        guard let url = Contants.oneJokeADayBaseURL else {return}
        var getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("tifdoan2210@gmail.com", forHTTPHeaderField:"User-Agent")
        getRequest.setValue("application/json", forHTTPHeaderField:"Accept")
        
        URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if let error = error {
                print("Error sending request \(error.localizedDescription)")
            }
            guard let data = data else {completion(nil);return}
            let jsonDecoder = JSONDecoder()
            do {
                let jokeDict = try jsonDecoder.decode(OneJokeADay.self, from: data)
                completion(jokeDict)
            } catch let error {
                print("Error fetching random joke \(error.localizedDescription) ")
            }
            }.resume()
        
    }
    
    func searchJoke (searchTerm : String, completion: @escaping ([SearchJoke]?) -> Void) {
        guard let url = Contants.searchRanDomJokeBaseURL else {return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryTearm = URLQueryItem(name:"term",value: searchTerm)
        let queryArray = [queryTearm]
        components?.queryItems = queryArray
        guard let fullUrl = components?.url else {completion(nil); return}
        var getRequest = URLRequest(url: fullUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("tifdoan2210@gmail.com", forHTTPHeaderField:"User-Agent")
        getRequest.setValue("application/json", forHTTPHeaderField:"Accept")
        URLSession.shared.dataTask(with: getRequest) { (data, _, error) in
            if let error = error {
                print("Error sending request \(error.localizedDescription)")
            }
            guard let data = data else {completion(nil);return}
            let jsonDecoder = JSONDecoder()
            do {
                let jokeDict = try jsonDecoder.decode(Results.self, from: data)
                let joke = jokeDict.results.compactMap{$0}
                completion(joke)
            } catch let error {
                print("Error fetching joke \(error.localizedDescription) ")
            }
            }.resume()
        }
    
}

