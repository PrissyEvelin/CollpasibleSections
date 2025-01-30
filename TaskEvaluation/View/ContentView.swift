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
                ForEach(sortedSections, id: \.self) { section in
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
                            ForEach(sortedCities(for: section)) { city in
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
    

    // Group cities by admin_name//
    private var groupedCities: [String: [CitiesModel]] {
            Dictionary(grouping: cityData, by: { $0.admin_name })
        }
        

    // Sort and Reverse Sections
        private var sortedSections: [String] {
            let sections = groupedCities.keys.sorted()
            return isReversed ? sections.reversed() : sections
        }
        
        // Sort and Reverse Cities in Each Section
        private func sortedCities(for section: String) -> [CitiesModel] {
            let cities = groupedCities[section] ?? []
            return isReversed ? cities.reversed() : cities
        }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
