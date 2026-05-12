//
//  MainDetailButtonView.swift
//  DevJournal
//
//  Created by Tyler Oneil on 5/11/26.
//

import SwiftUI

struct MainDetailButtonView: View {
    
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .padding()
        }
        .buttonStyle(.plain)  // Remove default styling
        .background(Color(.controlBackgroundColor))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    MainDetailButtonView(title: "CardButton", icon: "pencil", action: {})
}
