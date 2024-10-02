//
//  History.swift
//  Imagify
//
//  Created by bca on 10/31/23.
//

import Foundation


class History: ObservableObject{
    @Published var historyList: [DataToImageDetail] = []
    
    func push(item: DataToImageDetail){
        self.historyList.insert(item, at: 0)
        
        if self.historyList.count > 10{
            self.historyList.removeLast()
        }
    }
}
