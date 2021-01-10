//
//  ContentView.swift
//  Shared
//
//  Created by Pez on 09/01/2021.
//

import SwiftUI
import CoreData

struct LambdaMenuItem: Hashable {
    let name: String
    let color: Color
    let icon: String
    let method: String
    let url: String
    let data: String
}

struct ContentView: View {
    
    // TODO Make this dynamic
    let data = [
        LambdaMenuItem(
            name: "Get Weather",
            color: .blue,
            icon: "cloud.sun",
            method: "POST",
            url: "https://europe-west2-rwejlgaard.cloudfunctions.net/general-purpose",
            data: ""
        ),
        LambdaMenuItem(
            name: "GCP Current Balance",
            color: .purple,
            icon: "dollarsign.square",
            method: "GET",
            url: "https://pez.sh",
            data: ""
        ),
        LambdaMenuItem(
            name: "Lockdown",
            color: .red,
            icon: "lock",
            method: "GET",
            url: "https://pez.sh",
            data: ""
        )
    ]

    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

    @State private var isDisplayed = false
    @State private var msg = ""
    
    var body: some View {
        
        
        List(data, id: \.self) { item in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 80, alignment: .center)
                    .foregroundColor(item.color)
                HStack() {
                    Image(systemName: item.icon)
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 10, idealWidth: 60, maxWidth: 70, minHeight: 10, idealHeight: 50, maxHeight: 60, alignment: .center)
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: 3, height: 50)
                        .foregroundColor(.white)
                        .opacity(0.5)
                        .padding(.horizontal, 20)
                    Spacer()
                    Text(item.name)
                        .foregroundColor(.white)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.0001)
                        .lineLimit(1)
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 70, maxHeight: 70, alignment: .center)
                }
                .padding(.horizontal, 30)
            }
            .onTapGesture {
                msg = executeLambda(method: item.method, url: item.url, data: item.data)
                isDisplayed = true
            }
        }
        .alert(isPresented: $isDisplayed) {
            Alert(title: Text(msg), dismissButton: .default(Text("OK")))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView().preferredColorScheme(.light).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
