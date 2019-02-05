//
//  AssetFetcherQueue.swift
//  CurriculumVitae
//
//  Created by Michael Voong on 28/01/2019.
//  Copyright © 2019 Meidi Limited. All rights reserved.
//

import UIKit

class URLCoalescingMonitor<T> {
    
    typealias CompletionHandler = (T) -> Void
    
    private var handlers = [URL: [CompletionHandler]]()
    
    func isMonitoring(url: URL) -> Bool {
        return self.handlers[url] != nil
    }
    
    func monitor(url: URL, completion: @escaping CompletionHandler) {
        if var handler = self.handlers[url] {
            handler.append(completion)
            self.handlers[url] = handler
        } else {
            self.handlers[url] = [completion]
        }
    }
    
    func complete(url: URL, object: T) {
        for handler in self.handlers[url] ?? [] {
            handler(object)
        }
        self.handlers[url] = nil
    }
}
