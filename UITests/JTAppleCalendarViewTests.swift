//
//  JTAppleCalendarViewTests.swift
//  UITests
//
//  Created by Luis Cañadas Treceño on 27/05/2019.
//

import XCTest
@testable import JTAppleCalendar

class JTAppleCalendarViewTests: XCTestCase {

    var sut: JTAppleCalendarView!
    let formatter = DateFormatter()

    private var calendarDataSource: JTAppleCalendarViewDataSource!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        formatter.dateFormat = "yyyy MM dd"

        self.sut = JTAppleCalendarView(frame: CGRect.zero)
        sut.calendarDelegate = nil

        self.calendarDataSource = JTAppleCalendarViewDataSourceMock()
        sut.calendarDataSource = calendarDataSource
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPathsFromMay27() {
        let date = formatter.date(from: "2019 05 27")!

        let paths = sut.pathsFromDates([date])

        let indexPath = IndexPath(row: 20, section: 0)
        XCTAssertEqual(paths.first ?? IndexPath(row: 999, section: 999), indexPath)
    }

    func testPathsFromFirstDay() {
        let date = formatter.date(from: "2019 05 01")!

        let paths = sut.pathsFromDates([date])

        let indexPath = IndexPath(row: 2, section: 0)
        XCTAssertEqual(paths.first ?? IndexPath(row: 999, section: 999), indexPath)
    }

    func testPathsFromLastDay() {
        let date = formatter.date(from: "2019 05 31")!

        let paths = sut.pathsFromDates([date])

        let indexPath = IndexPath(row: 24, section: 0)
        XCTAssertEqual(paths.first ?? IndexPath(row: 999, section: 999), indexPath)
    }

    func testPathsFromJune() {
        let indexPath0 = IndexPath(row: 0, section: 1)
        let date0 = formatter.date(from: "2019 06 03")!
        let indexPath1 = IndexPath(row: 9, section: 1)
        let date1 = formatter.date(from: "2019 06 14")!
        let indexPath2 = IndexPath(row: 14, section: 1)
        let date2 = formatter.date(from: "2019 06 21")!
        let indexPath3 = IndexPath(row: 15, section: 1)
        let date3 = formatter.date(from: "2019 06 24")!
        let indexPath4 = IndexPath(row: 19, section: 1)
        let date4 = formatter.date(from: "2019 06 28")!

        let paths = sut.pathsFromDates([date0, date1, date2, date3, date4])

        XCTAssertEqual(paths[0], indexPath0)
        XCTAssertEqual(paths[1], indexPath1)
        XCTAssertEqual(paths[2], indexPath2)
        XCTAssertEqual(paths[3], indexPath3)
        XCTAssertEqual(paths[4], indexPath4)
    }
}

private class JTAppleCalendarViewDataSourceMock: JTAppleCalendarViewDataSource {

    private var numberOfRows = 7
    private let formatter = DateFormatter()
    private var testCalendar = Calendar.current
    private var generateInDates: InDateCellGeneration = .forAllMonths
    private var generateOutDates: OutDateCellGeneration = .off
    private var hasStrictBoundaries = true

    private var firstDatOfWeek :DaysOfWeek = .monday
    private var week: Week = .five

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {

        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = testCalendar.timeZone
        formatter.locale = testCalendar.locale

        let startDate = formatter.date(from: "2019 05 01")!
        let endDate = formatter.date(from: "2019 06 30")!

        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numberOfRows,
                                                 calendar: testCalendar,
                                                 generateInDates: generateInDates,
                                                 generateOutDates: generateOutDates,
                                                 firstDayOfWeek: firstDatOfWeek,
                                                 hasStrictBoundaries: hasStrictBoundaries,
                                                 week: week)
        return parameters
    }

}
