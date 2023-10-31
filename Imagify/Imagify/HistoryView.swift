//
//  HistoryView.swift
//  Imagify
//
//  Created by bca on 10/30/23.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var historyContent: History
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 30)
    ]
    
    
    var body: some View {
        ScrollView {
            Text("History")
                    .navigationBarTitleDisplayMode(.inline)
                    .font(.system(size: 45))
                    .fontWeight(.medium)
            LazyVGrid(columns: columns){
                ForEach(historyContent.historyList){cell in
                    
                    HStack {
                        Spacer().frame(width: 5)
                        Image(uiImage: cell.image)
                            .resizable()
                            .frame(width:80, height: 80)
                            .aspectRatio(contentMode: .fit)
                        VStack {
                            Text(cell.cityCountry)
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.medium)
                            Text(cell.textArray)
                                .foregroundColor(.white)
                                .font(.caption)
                                .fontWeight(.light)
                        }
                    }
                    .border(.gray)
                    
                }
            }
        }
    }
}

