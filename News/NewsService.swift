//
//  NewsService.swift
//  News
//
//  Created by Ацкий Станислав on 06.01.2021.
//

import Foundation
import CoreData

protocol INewsService {
    func getNews() -> [NewsItem]?
    func updateNews(sources: [RSSSource], completion: @escaping ([NewsItem]?) -> Void)
    func eraseCache()
}

final class NewsService: INewsService {
    
    private let provider: IRSSManager
    private var dataManager: IDataManager
    
    init(provider: IRSSManager, dataManager: IDataManager) {
        self.provider = provider
        self.dataManager = dataManager
    }
    
    private func saveNewsItem(_ item: RSSNewsResponse) {
        dataManager.persistentContainer.performBackgroundTask { context in
            _ = DBNewsItem(source: item.sourceName,
                           title: item.title,
                           description: item.description,
                           date: item.pubDate,
                           imageData: nil, //TODO: set image data (or URL)
                           in: context)
            try? context.save()
        }

    }
    
    //fetch news from dataBase
    func getNews() -> [NewsItem]? {
        retrieveNewsItems()
    }
    
    //load news from network, save in database and retrieve from database
    func updateNews(sources: [RSSSource], completion: @escaping ([NewsItem]?) -> Void) {
        NotificationCenter.default.post(Notification(name: .beginLoadData))
        
        provider.getNews(sources: sources) { [weak self] news in
            NotificationCenter.default.post(Notification(name: .endLoadData))
            
            news.forEach { self?.saveNewsItem($0) }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                DispatchQueue.main.async {
                    completion(self?.retrieveNewsItems())
                }
            }
        }
    }
    
    func eraseCache() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBNewsItem")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try dataManager.mainContext.execute(batchDeleteRequest)
        } catch {
            print("Detele all data in DBNewsItem error :", error)
        }
    }
        
    private func retrieveNewsItems() -> [NewsItem]? {
        let request: NSFetchRequest<DBNewsItem> = DBNewsItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let dbNewsItems = try? dataManager.mainContext.fetch(request)
        let news = dbNewsItems?.compactMap { NewsItem(dbNewsItem: $0) }
        return news
    }
    
}
