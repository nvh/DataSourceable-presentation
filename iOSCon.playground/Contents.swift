import UIKit

public protocol DataContaining {
    associatedtype ItemType
    var data: [ItemType] { get }
}

public protocol MutableDataContaining: DataContaining {
    var data: [ItemType] { get set }
}

extension DataContaining {
    var numberItems: Int {
        return data.count
    }
    
    func item(atIndex index: Int) -> ItemType? {
        guard index < numberItems else { return nil }
        return data[index]
    }
}
/// http://pomo.tv
extension TableViewDataSource where Self: DataContaining, Self: TableViewCellConfiguring, Self.ItemType == Self.TableCellType.ItemType {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberItems
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
        return numberItems
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(defaultReuseIdentifier, forIndexPath: indexPath)
        if let item = item(atIndex: indexPath.item), cell = cell as? CollectionCellType {
            cell.configure(forItem: item)
        }
        return cell
    }
}

extension CollectionViewDataSource where Self: Movable {
    public func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    public mutating func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        move(from: sourceIndexPath.item, to: destinationIndexPath.item)
    }
    
    
}

public protocol CollectionCellConfiguring {
    associatedtype CollectionCellType: Configurable
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

public protocol TableViewCellConfiguring {
    associatedtype TableCellType: Configurable
}


public protocol Movable {
    mutating func move(from fromIndex: Int, to toIndex: Int)
}

extension Movable where Self: MutableDataContaining {
    mutating public func move(from fromIndex: Int, to toIndex: Int) {
        let item = data.removeAtIndex(fromIndex)
        data.insert(item, atIndex: toIndex)
    }
}


extension CollectionViewCell: Configurable {
    public typealias ItemType = FramerExample
    public func configure(forItem item: ItemType) {
        titleLabel.text = item.title
        imageView.image = item.image
    }
}
// --- ExampleDataSource ---
extension ExampleDataSource: TableViewDataSource, DataContaining {}
extension ExampleDataSource: TableViewCellConfiguring {
    public typealias TableCellType = TableViewCell
}
extension ExampleDataSource: CollectionViewDataSource {}
extension ExampleDataSource: CollectionCellConfiguring {
    public typealias CollectionCellType = CollectionViewCell
    
}

extension ExampleDataSource: MutableDataContaining {}

extension ExampleDataSource: Movable {}


let dataSource = ExampleDataSource()
let c = showNavigationController(forCollectionDataSource: dataSource)
