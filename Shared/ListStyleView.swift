//
//  ContentView.swift
//  Shared
//
//  Created by dominator on 05/07/20.
//

import SwiftUI

struct ListStyleView: View {
    
    @State var selectedIndex = 3
    
    var list: some View{
        List{
            ForEach(0..<10) { row in
                Text("Row \(row)")
            }
        }
    }
    
    var styledList: some View{
        Group{
            switch selectedIndex{
            #if os(iOS)
            // InsetGroupedListStyle is only available in iOS
            case 0:
                list
                    .listStyle(InsetGroupedListStyle())
            #endif
            case 1:
                list
                    .listStyle(InsetListStyle())
            case 2:
                list
                    .listStyle(SidebarListStyle())
            case 3:
                list
            default:
                EmptyView()
            }
        }
    }
    
    var stylePicker: some View{
        Picker(selection: $selectedIndex, label: Text("List Style"), content: {
            #if os(iOS)
            Text("Inset group").tag(0)
            #endif
            Text("Inset").tag(1)
            Text("Sidebar style").tag(2)
            Text("Default").tag(3)
        })
        .labelsHidden()
    }
    
    #if os(macOS)
    var macOS: some View{
        NavigationView{
            styledList
                .navigationTitle("List Styles")
            Text("Select style from the picker to change list style")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        //adding toolbar inside the navigationview produces unwanted crashes try out your self if you want.
        .toolbar {
            stylePicker
        }
    }
    #endif
    
    #if os(iOS)
    var iOS: some View{
        NavigationView{
            styledList
                .navigationTitle("List Styles")
                .toolbar {
                    stylePicker
                        //Default style of picker in iOS is WheelPickerStyle
                        .pickerStyle(SegmentedPickerStyle())
                }
            GroupBox(label: Text("Select Style"), content: {
                stylePicker
            })
            .frame(maxWidth: 200)
            .navigationBarHidden(true)
        }
    }
    #endif
    
    var body: some View{
        #if os(iOS)
        return iOS
        #elseif os(macOS)
        return macOS
        #endif
    }
}

struct ListStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleView()
    }
}
