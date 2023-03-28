//
//  DataPersistenceManager.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-28.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    static let shared = DataPersistenceManager()
    
    func downloadPoster(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        // instance of app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
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
}