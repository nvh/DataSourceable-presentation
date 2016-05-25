import UIKit


public protocol DataContaining {
    associatedtype ItemType
    var data: [ItemType] { get set }
}

public protocol MutableDataContaining {
    associatedtype ItemType
    var data: [ItemType] { get set }
}

extension DataContaining {
    var numberOfItems: Int {
        return data.count
    }
    
    func item(atIndex index: Int) -> ItemType? {
        guard index < numberOfItems else { return nil }
        return data[index]
    }
}


extension TableViewDataSource where Self: DataContaining, Self: TableCellConfiguring, Self.ItemType == Self.TableCellType.ItemType {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(defaultReuseIdentifier, forIndexPath: indexPath)
        if let item = item(atIndex: indexPath.row), cell = cell as? TableCellType {
            cell.configure(forItem: item)
        }
        return cell
    }

}
extension CollectionViewDataSource where Self: DataContaining, Self: CollectionCellConfiguring, Self.ItemType == Self.CollectionCellType.ItemType {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(defaultReuseIdentifier, forIndexPath: indexPath)
        if let item = item(atIndex: indexPath.item), cell = cell as? CollectionCellType {
            cell.configure(forItem: item)
        }
        return cell
    }
    
}

public extension CollectionViewDataSource where Self: Movable {
    public func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    public mutating func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        move(sourceIndexPath.item, toIndex: destinationIndexPath.item)
    }
}

public protocol Configurable {
    associatedtype ItemType
    func configure(forItem item: ItemType)
}

extension TableViewCell: Configurable {
    public typealias ItemType = FramerExample
    public func configure(forItem item: ItemType) {
        textLabel?.text = item.title
        detailTextLabel?.text = item.author
        imageView?.image = item.image
    }
}

extension CollectionViewCell: Configurable {
    public typealias ItemType = FramerExample
    public func configure(forItem item: ItemType) {
        titleLabel?.text = item.title
        imageView?.image = item.image
    }
}
public protocol TableCellConfiguring {
    associatedtype TableCellType: Configurable
}

public protocol CollectionCellConfiguring {
    associatedtype CollectionCellType: Configurable
}

public protocol Movable {
    mutating func move(fromIndex: Int, toIndex: Int)
}



extension Movable where Self: DataContaining {
    mutating public func move(fromIndex: Int, toIndex: Int) {
        let item = data.removeAtIndex(fromIndex)
        data.insert(item, atIndex: toIndex)
    }
}


// ExampleDataSource
extension ExampleDataSource: DataContaining {}

extension ExampleDataSource: TableCellConfiguring {
    public typealias TableCellType = TableViewCell
}
extension ExampleDataSource: TableViewDataSource {}


extension ExampleDataSource: CollectionCellConfiguring {
    public typealias CollectionCellType = CollectionViewCell
}
extension ExampleDataSource: CollectionViewDataSource {}

extension ExampleDataSource: MutableDataContaining {}
extension ExampleDataSource: Movable {}


let dataSource = ExampleDataSource()
let c = showNavigationController(forCollectionDataSource: dataSource)
