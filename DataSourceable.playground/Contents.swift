import UIKit

public protocol SectionType: DataContaining {
    var headerTitle: String? { get }
}


public protocol SectionContaining {
    typealias Section: SectionType
    var sections: [Section] { get }
}

public extension SectionContaining {
    var numberOfSections: Int {
        return sections.count
    }
    func item(atIndexPath indexPath: NSIndexPath) -> Section.ItemType? {
        return sections[indexPath.section].item(atIndex: indexPath.row)
    }
}

extension JamesBond.Actor: SectionType {
    public typealias ItemType = JamesBond.Movie
    public var data: [ItemType] {
        return movies
    }
    public var headerTitle: String? {
        return name
    }
}


struct MovieDataSource: DataContaining, TableViewDataSource, CellProviding, SectionContaining {
    typealias ItemType = JamesBond.Movie
    var data = JamesBond.movies
    var sections = JamesBond.actors
    
    func configure(cell: UITableViewCell, forItem item: JamesBond.Movie, inTableView tableView: UITableView) -> UITableViewCell {
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.year.description
        return cell
    }
}

public extension TableViewDataSource where Self: SectionContaining, Self: CellProviding, Self.Section.ItemType == Self.ItemType {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(defaultCellIdentifier, forIndexPath: indexPath)
        if let item = item(atIndexPath: indexPath) {
            configure(cell, forItem: item, inTableView: tableView)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
}

let dataSource = MovieDataSource()
let dataSourceProxy = TableViewDataSourceProxy(dataSource: dataSource)
showTableViewWithDataSource(dataSourceProxy)
