import UIKit

public protocol SectionType: DataContaining {
    var headerTitle: String? { get }
}

public extension SectionType {
    var headerTitle: String? {
        return nil
    }
}

public protocol SectionContaining {
    typealias Section: SectionType
    var sections: [Section] { get }
}

public extension SectionContaining {
    func item(atIndexPath indexPath: NSIndexPath) -> Section.ItemType? {
        return sections[indexPath.section].item(atIndex: indexPath.row)
    }
}

extension Actor: SectionType {
    public typealias ItemType = Movie
    public var data: [Movie] {
        return movies
    }
    
    public var headerTitle: String? {
        return name
    }
    
}


extension Director: SectionType {}

struct MovieDataSource: SectionContaining, TableViewDataSource, CellProviding {
    typealias ItemType = Movie
    typealias Section = Actor
    let sections = JamesBond.actors
    
    func configure(cell: UITableViewCell, forItem item: Movie, inTableView tableView: UITableView) -> UITableViewCell {
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.year.description
        return cell
    }
}

public extension TableViewDataSource where Self: SectionContaining, Self: CellProviding, Self.Section.ItemType == Self.ItemType {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(defaultCellIdentifier, forIndexPath: indexPath)
        if let currentItem = item(atIndexPath: indexPath) {
            cell = configure(cell, forItem: currentItem, inTableView: tableView)
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

