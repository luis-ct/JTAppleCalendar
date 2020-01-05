//
//  JTAppleDateConfigGeneratorTests.swift
//  UITests
//
//  Created by Luis Cañadas Treceño on 09/05/2019.
//

import XCTest
@testable import JTAppleCalendar

class FiveJTAppleDateConfigGeneratorTests: XCTestCase {
    var sut: JTAppleDateConfigGenerator!
    var calendar: Calendar!
    var formatter: DateFormatter!
    var week: Week!

    let yearDays = 365
    let weekendDays = 104

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = JTAppleDateConfigGenerator()

        self.calendar = Calendar.current
        self.formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = calendar.timeZone
        formatter.locale = calendar.locale

        self.week = .five
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testYearWithOffInDatesAndOffOutDates() {
        // Arange
        let startDate = formatter.date(from: "2019 01 01") ?? Date()
        let endDate = formatter.date(from: "2019 12 31") ?? Date()

        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: calendar,
                                                 generateInDates: .off,
                                                 generateOutDates: .off,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: true,
                                                 week: week)

        let totalSections = 12
        let totalDays = 261
        let totalMonths = 12

        // Action
        let monthInfo = sut.setupMonthInfoDataForStartAndEndDate(parameters)

        // Assert
        XCTAssertEqual(monthInfo.totalSections, totalSections)
        XCTAssertEqual(monthInfo.totalDays, totalDays)
        XCTAssertEqual(monthInfo.months.count, totalMonths)
    }

    func testYearWithAllMonthsInDatesAndOffOutDates() {
        // Arange
        let startDate = formatter.date(from: "2019 01 01") ?? Date()
        let endDate = formatter.date(from: "2019 12 31") ?? Date()

        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: calendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .off,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: true,
                                                 week: week)

        let totalSections = 12
        let totalDays = 280
        let totalMonths = 12

        // Action
        let monthInfo = sut.setupMonthInfoDataForStartAndEndDate(parameters)

        // Assert
        XCTAssertEqual(monthInfo.totalSections, totalSections)
        XCTAssertEqual(monthInfo.totalDays, totalDays)
        XCTAssertEqual(monthInfo.months.count, totalMonths)
    }

    func testMonthWithOffInDatesAndOffOutDates() {
        // Arange
        let startDate = formatter.date(from: "2019 05 01") ?? Date()
        let endDate = formatter.date(from: "2019 05 31") ?? Date()

        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: calendar,
                                                 generateInDates: .off,
                                                 generateOutDates: .off,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: true,
                                                 week: week)

        let totalSections = 1
        let totalDays = 23
        let totalMonths = 1

        // Action
        let monthInfo = sut.setupMonthInfoDataForStartAndEndDate(parameters)

        // Assert
        XCTAssertEqual(monthInfo.totalSections, totalSections)
        XCTAssertEqual(monthInfo.totalDays, totalDays)
        XCTAssertEqual(monthInfo.months.count, totalMonths)

        let month = Month(startDayIndex: 0,
                          startCellIndex: 0,
                          sections: [23],
                          inDates: 0,
                          outDates: 0,
                          sectionIndexMaps: [0: 0],
                          rows: 5,
                          name: .may,
                          numberOfDaysInMonth: 23)

        XCTAssertEqual(monthInfo.months[0], month)
    }

    func testMonthWithAllMonthsInDatesAndOffOutDates() {
        // Arange
        let startDate = formatter.date(from: "2019 05 01") ?? Date()
        let endDate = formatter.date(from: "2019 05 31") ?? Date()

        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: calendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .off,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: true,
                                                 week: week)

        let totalSections = 1
        let totalDays = 25
        let totalMonths = 1

        // Action
        let monthInfo = sut.setupMonthInfoDataForStartAndEndDate(parameters)

        // Assert
        XCTAssertEqual(monthInfo.totalSections, totalSections)
        XCTAssertEqual(monthInfo.totalDays, totalDays)
        XCTAssertEqual(monthInfo.months.count, totalMonths)

        let month = Month(startDayIndex: 0,
                          startCellIndex: 0,
                          sections: [25],
                          inDates: 2,
                          outDates: 0,
                          sectionIndexMaps: [0: 0],
                          rows: 5,
                          name: .may,
                          numberOfDaysInMonth: 23)

        XCTAssertEqual(monthInfo.months[0], month)
    }

    func testdecMonthWithAllMonthsInDatesAndOffOutDates() {
        // Arange
        let startDate = formatter.date(from: "2019 12 01") ?? Date()
        let endDate = formatter.date(from: "2019 12 31") ?? Date()

        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: calendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .off,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: true,
                                                 week: week)

        let totalSections = 1
        let totalDays = 22
        let totalMonths = 1

        // Action
        let monthInfo = sut.setupMonthInfoDataForStartAndEndDate(parameters)

        // Assert
        XCTAssertEqual(monthInfo.totalSections, totalSections)
        XCTAssertEqual(monthInfo.totalDays, totalDays)
        XCTAssertEqual(monthInfo.months.count, totalMonths)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
