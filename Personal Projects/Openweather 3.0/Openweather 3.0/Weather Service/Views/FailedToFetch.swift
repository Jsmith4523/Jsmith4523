//
//  FailedToFetch.swift
//  Studently
//
//  Created by Jaylen on 7/21/22.
//

import SwiftUI

struct FailedToFetch: View {
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle.fill")
            Text("There was an error loading in weather data! Please try again later")
                .fontWeight(.semibold)
        }
        .font(.caption)
        .foregroundColor(.white)
        .padding()
        .background(Color.red.opacity(0.75))
        .cornerRadius(10)
        .padding()
    }
}

struct FailedToFetch_Previews: PreviewProvider {
    static var previews: some View {
        FailedToFetch()
    }
}
