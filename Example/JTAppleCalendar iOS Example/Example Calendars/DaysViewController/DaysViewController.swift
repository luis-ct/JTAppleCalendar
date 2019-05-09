//
//  DaysViewController.swift
//  JTAppleCalendar
//
//  Created by Luis Cañadas Treceño on 08/05/2019.
//

import JTAppleCalendar

class DaysViewController: UIViewController {

    // MARK: - Private vars

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!

    private var numberOfRows = 7
    private let formatter = DateFormatter()
    private var testCalendar = Calendar.current
    private var generateInDates: InDateCellGeneration = .forAllMonths
    private var generateOutDates: OutDateCellGeneration = .off
    private var hasStrictBoundaries = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.register(UINib(nibName: "MonthlyScheduleViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MonthlyScheduleViewCell")

//        self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
//            self.setupViewsOfCalendar(from: visibleDates)
//        }

        setupScrollMode()
    }

    private func setupScrollMode() {
        calendarView.scrollingMode = .stopAtEachSection
    }

    private func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = testCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]

        // 0 indexed array
        let year = testCalendar.component(.year, from: startDate)
        monthLabel.text = monthName + " " + String(year)
    }

    // MARK: - Cell

    func configureVisibleCell(myCustomCell: MonthlyScheduleViewCell, cellState: CellState, date: Date) {
        let day = Calendar.current.component(.day, from: date)

        let weekday = Calendar.current.component(.weekday, from: date)

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: date)

        print("\(month) \(cellState.text)")
//        print("\(month) \(day)")

        if testCalendar.isDateInToday(date) {
            myCustomCell.day.backgroundColor = .red
            myCustomCell.month.backgroundColor = .red
        } else {
            myCustomCell.day.backgroundColor = .clear
            myCustomCell.month.backgroundColor = .clear
        }

        if testCalendar.isDateInWeekend(date) {
            myCustomCell.backgroundColor = .gray
        } else {
            myCustomCell.backgroundColor = .white
        }

        handleCellConfiguration(cell: myCustomCell, cellState: cellState)

        switch cellState.dateBelongsTo {
        case .thisMonth:
            myCustomCell.day.text = "\(day) \(cellState.day)"
            myCustomCell.month.text = "\(month)"
            myCustomCell.separator.isHidden = false
        default:
            myCustomCell.day.text = ""
            myCustomCell.month.text = ""
            myCustomCell.separator.isHidden = true
            myCustomCell.day.backgroundColor = .clear
            myCustomCell.month.backgroundColor = .clear
            myCustomCell.backgroundColor = .white
        }
    }

    private func handleCellConfiguration(cell: MonthlyScheduleViewCell?, cellState: CellState) {
//        handleCellSelection(view: cell, cellState: cellState)
//        handleCellTextColor(view: cell, cellState: cellState)
//        prePostVisibility?(cellState, cell as? CellView)
    }

}

// MARK : JTAppleCalendarDelegate
extension DaysViewController: JTAppleCalendarViewDataSource {

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {

        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = testCalendar.timeZone
        formatter.locale = testCalendar.locale

        let startDate = formatter.date(from: "2019 01 01")!
        let endDate = formatter.date(from: "2020 12 28")!

        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numberOfRows,
                                                 calendar: testCalendar,
                                                 generateInDates: generateInDates,
                                                 generateOutDates: generateOutDates,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: hasStrictBoundaries,
                                                 week: .five)
        return parameters
    }

}

extension DaysViewController: JTAppleCalendarViewDelegate {

    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        let myCustomCell = cell as! MonthlyScheduleViewCell
        configureVisibleCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }

    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "MonthlyScheduleViewCell", for: indexPath) as! MonthlyScheduleViewCell
        configureVisibleCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
        return myCustomCell
    }

//    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        handleCellConfiguration(cell: cell, cellState: cellState)
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
//        handleCellConfiguration(cell: cell, cellState: cellState)
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
//        self.setupViewsOfCalendar(from: visibleDates)
//    }

//    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
//        let date = range.start
//        let month = testCalendar.component(.month, from: date)
//
//        let header: JTAppleCollectionReusableView
//        if month % 2 > 0 {
//            header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "WhiteSectionHeaderView", for: indexPath)
//            (header as! WhiteSectionHeaderView).title.text = formatter.string(from: date)
//        } else {
//            header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "PinkSectionHeaderView", for: indexPath)
//            (header as! PinkSectionHeaderView).title.text = formatter.string(from: date)
//        }
//        return header
//    }

    func sizeOfDecorationView(indexPath: IndexPath) -> CGRect {
        let stride = calendarView.frame.width * CGFloat(indexPath.section)
        return CGRect(x: stride + 5, y: 5, width: calendarView.frame.width - 10, height: calendarView.frame.height - 10)
    }

//    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
//        return nil
//    }

}
