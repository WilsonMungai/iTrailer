//
//  DataPersistenceManager.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-28.
//

import Foundation
import UIKit
import CoreData

// core data
class DataPersistenceManager {
    
    static let shared = DataPersistenceManager()
    
    func downloadPoster(model: Poster, completion: @escaping (Result<Void, Error>) -> Void) {
        // instance of app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // persistentContainer
        let context = appDelegate.persistentContainer.viewContext
        
        // data to be stored in database
        // create an item to be stored in the database, and notify the context
        let item = PosterItem(context: context)
        
        // field items to be saved in database
        item.id = Int64(model.id)
        item.originalTitle = model.originalTitle
        item.title = model.title
        item.posterPath = model.posterPath
        item.releaseDate = model.releaseDate
        item.voteAverage = model.voteAverage
        item.overview = model.overview
        item.mediaType = model.mediaType
        item.popularity = model.popularity
        item.voteCount = Int64(model.voteCount)
        item.name = model.name
        item.originalName = model.name
        item.firstAirDate = model.firstAirDate
        
        do {
            // attempts to save the data
            try context.save()
            // completion expects a void, so just pass empty paranthesis
            completion(.success(()))
        } catch {
            // print error
            print(error)
        }
    }
    
    func fetchSavedData(completion: @escaping (Result<[PosterItem], Error>) -> Void) {
        // instance of app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        // type of data being fetched
        let request: NSFetchRequest<PosterItem>
        // fetch request
        request = PosterItem.fetchRequest()
        
        do {
            // ask database to fetch the items
            let movies = try context.fetch(request)
            completion(.success(movies))
        } catch {
            print(error)
        }
    }
    
    func deleteData(model: PosterItem, completion: @escaping (Result<Void, Error>)-> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print(error)
        }
        
    }
}
