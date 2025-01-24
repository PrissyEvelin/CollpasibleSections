//
//  ContentView.swift
//  TaskEvaluation
//
//  Created by Evelin on 24/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var cityData: [CitiesModel] = []
    @State private var expandedSections: Set<String> = []
    @State private var cityViewModel = citiesViewModel()
    @State private var isReversed: Bool = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            VStack {
                            // Reverse Order Button
                            Button(action: {
                                isReversed.toggle()
                            }) {
                                Text(isReversed ? "Restore Order" : "Reverse Order")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .background(colorScheme == .dark ? Color.black : Color.white)
                                    .cornerRadius(8)
                            }
                            .padding()
                
            List {
                ForEach(groupedCities.keys.sorted(), id: \.self) { section in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expandedSections.contains(section) },
                            set: { isExpanded in
                                if isExpanded {
                                    expandedSections.insert(section)
                                } else {
                                    expandedSections.remove(section)
                                }
                            }
                        ),
                        content: {
                            ForEach(groupedCities[section] ?? []) { city in
                                Text(city.city)
                                    .font(.body)
                                    .padding(.leading, 10)
                                    .foregroundColor(.primary)
                                    .background(Color(UIColor.systemBackground))
                            }
                        },
                        label: {
                            Text(section)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .background(Color(UIColor.systemBackground))
                        }
                    )
                }
            }
            }
            .navigationTitle("Cities")
            .onAppear {
                cityData = cityViewModel.loadJSONData()
            }
        }
    }
    

    // MARK :  Grouped and optionally reversed cities
        private var groupedCities: [String: [CitiesModel]] {
            let grouped = Dictionary(grouping: cityData, by: { $0.admin_name})
            if isReversed {
                return grouped.mapValues { $0.reversed() }
            }
            return grouped
        }

        // Section titles, optionally reversed
        private var sectionTitles: [String] {
            let titles = groupedCities.keys.sorted()
            return isReversed ? titles.reversed() : titles
        }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
