# Data
- movies
- actors
- years

# TableViewDataSource
- mimics all functions of `UITableViewDataSource`
- pure Swift to be able to use the power of protocols
- default implementations instead of optional functions

# Helper functions to show the tableView
- Default identifier that we have registered with the UITableView
- Create the tableView and show it
- `TableViewDataSourceProxy` to pass every method from our own protocol to UIKit's version

# DataSource

    struct DataSource: TableViewDataSource {}
    extension DataSource {
        //Fixed data
    }


# JamesBond Data

    struct MovieDataSource: TableViewDataSource {
      var strings = JamesBond.movieNames
    }

     public extension MovieDataSource {
.      
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell

# Multiple DataSources

    struct ActorDataSource: TableViewDataSource {
      var strings = JamesBond.actorNames
    }
    public extension ActorDataSource {
    }

# StringContaining

    public protocol StringContaining {
      var data: [String] { get }
    }
    extension TableViewDataSource where Self: StringContaining {
    }

# DataContaining

    struct YearsDataSource: TableViewDataSource {
    }
    public protocol DataContaining {
      typealias ItemType
      var data: [ItemType] { get }
    }

# Extend DataContaining

    public extension DataContaining {
        var numberOfItems: Int
        func item(atIndexPath indexPath: NSIndexPath) -> ItemType?
    }

# Update TableViewDataSource

    public extension TableViewDataSource where Self: DataContaining

# CellProviding

    public protocol CellProviding {
      func configure(cell: UITableViewCell, forItem item: ItemType, inTableView: UITableView) -> UITableViewCell
    }
.

    public extension CellProviding {  
    }

# TableViewDataSource cellForRowAtIndexPath

    extension TableViewDataSource where Self: StringContaining, Self: CellProviding


# Extend Array

    extension Array: DataContaining {
        public typealias ItemType = Element
        public var data: [ItemType] {
            return self
        }
    }
    extension Array: DataSourceType, CellProviding, TableViewDataSource {}

# Move everything but TableViewDataSource extension to DataSourceable.swift

# Use Movie

    struct MovieDataSource: DataContaining, TableViewDataSource, CellProviding {
        typealias ItemType = Movie
        var data = JamesBond.movies
    }

# configure cell

    func configure(cell: UITableViewCell, forItem item: ItemType, inTableView: UITableView) -> UITableViewCell {
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.year.description
        return cell
    }

#SectionType

    public protocol SectionType: DataContaining {}

#SectionContaining

    public protocol SectionContaining {
        typealias Section: SectionType
        var sections: [Section] { get }
    }

#Extend SectionContaining

    public extension SectionContaining {
        var numberOfSections: Int
        func item(atIndexPath indexPath: NSIndexPath) -> Section.ItemType?
    }

# Extend extension of TableViewDataSource

    extension TableViewDataSource where Self: SectionContaining, Self: CellProviding, Self.Section.ItemType == Self.ItemType {
.

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int

#Conform Actor to SectionType

    extension Actor: SectionType {
        public typealias ItemType = Movie
        public var data: [Movie] {
            return movies
        }
    }

#Update MovieDataSource

    struct MovieDataSource: SectionContaining, TableViewDataSource, CellProviding {
        typealias Section = Actor
        typealias ItemType = Movie
        var sections = JamesBond.actors
    }

#Add headerTitle to SectionType

    public protocol SectionType: DataContaining {
        var headerTitle: String? { get }
    }

#Implement titleForHeaderInSection

    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
