//
//  SerieRowView.swift
//  MarvelApp
//
//  Created by Javier Gomez on 14/6/25.
//
import SwiftUI

struct SeriesRowView: View {
    let series: SeriesModel
    
    var body: some View {
        HStack(spacing: 12) {
            // Thumbnail de la serie
            AsyncImage(url: URL(string: series.thumbnailURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 80)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 80)
                    .overlay(
                        Image(systemName: "book.closed")
                            .foregroundColor(.gray)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(series.title)
                    .font(.headline)
                    .lineLimit(2)
                
                if !series.description.isEmpty {
                    Text(series.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}




