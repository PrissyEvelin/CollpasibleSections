//
//  TaskEvaluationTests.swift
//  TaskEvaluationTests
//
//  Created by Evelin on 24/01/25.
//

import XCTest
@testable import TaskEvaluation

class TaskEvaluationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    // MARK:  Test: Decoding JSON data
       func testJSONDecoding() throws {
           let json = """
           [
               {
                   "city": "Sydney",
                   "lat": "-33.8678",
                   "lng": "151.2100",
                   "country": "Australia",
                   "iso2": "AU",
                   "admin_name": "New South Wales",
                   "capital": "admin",
                   "population": "4840600",
                   "population_proper": "4840600"
               },
               {
                   "city": "Melbourne",
                   "lat": "-37.8136",
                   "lng": "144.9631",
                   "country": "Australia",
                   "iso2": "AU",
                   "admin_name": "Victoria",
                   "capital": "admin",
                   "population": "4529500",
                   "population_proper": "4529500"
               }
           ]
           """
           
           let jsonData = json.data(using: .utf8)!
           let decodedCities = try JSONDecoder().decode([CitiesModel].self, from: jsonData)
           
           XCTAssertEqual(decodedCities.count, 2)
           XCTAssertEqual(decodedCities[0].city, "Sydney")
           XCTAssertEqual(decodedCities[1].country, "Australia")
       }

       // Test: Grouping cities by country
       func testGroupingCitiesByCountry() {
           let testCities = [
            CitiesModel(city: "Sydney", lat: "-33.8678", lng: "151.2100", country: "Australia", iso2: "AU", admin_name: "New South Wales", capital: "admin", population: "4840600", population_proper: "4840600"),
            CitiesModel(city: "Melbourne", lat: "-37.8136", lng: "144.9631", country: "Australia", iso2: "AU", admin_name: "Victoria", capital: "admin", population: "4529500", population_proper: "4529500"),
            CitiesModel(city: "New York", lat: "40.7128", lng: "-74.0060", country: "USA", iso2: "US", admin_name: "New York", capital: "admin", population: "8419600", population_proper: "8419600")
           ]
           
           let groupedCities = Dictionary(grouping: testCities, by: { $0.country })
           
           XCTAssertEqual(groupedCities["Australia"]?.count, 2)
           XCTAssertEqual(groupedCities["USA"]?.count, 1)
           XCTAssertEqual(groupedCities["USA"]?.first?.city, "New York")
       }

       // Test: Expand/Collapse sections
       func testExpandCollapseSections() {
           let testView_ = ContentView()
           var expandedSections = Set<String>()
           
           // Simulate expanding a section
           expandedSections.insert("Australia")
           XCTAssertTrue(expandedSections.contains("Australia"))
           
           // Simulate collapsing a section
           expandedSections.remove("Australia")
           XCTAssertFalse(expandedSections.contains("Australia"))
       }

       //  MARK: Test: Loading JSON data from the app bundle
       func testLoadingJSONDataFromBundle() {
           guard let url = Bundle.main.url(forResource: "au_cities", withExtension: "json"),
                 let data = try? Data(contentsOf: url),
                 let decodedCities = try? JSONDecoder().decode([CitiesModel].self, from: data) else {
               XCTFail("Failed to load or decode JSON")
               return
           }
           
           XCTAssertGreaterThan(decodedCities.count, 0)
           XCTAssertEqual(decodedCities.first?.city, "Sydney")
       }
    
    
    //  MARK: Test: Loading JSON data from the incorrect file
    func testLoadingJSONDataFromIncorrectFile() {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedCities = try? JSONDecoder().decode([CitiesModel].self, from: data) else {
            XCTFail("File not found")
            return
        }
        
    }
 
    
   

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
