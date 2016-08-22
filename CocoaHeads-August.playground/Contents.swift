import UIKit

public protocol DataContaining {
    associatedtype ItemType
    var data: [ItemType] { get }
}

public protocol MutableDataContaining: DataContaining {
    var data: [ItemType] { get set }
}

public extension DataContaining {
    var numberOfItems: Int {
        return data.count
    }
    
    func item(at index: Int) -> ItemType? {
        guard index < numberOfItems else {
            return nil
        }
        return data[index]
    }
}

extension TableViewDataSource where Self: DataContaining, Self: TableViewCellConfiguring, Self.ItemType == Self.TableCellType.ConfiguredType {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultReuseIdentifier, for: indexPath)
        if let item = item(at: indexPath.row), let tableCell = cell as? TableCellType {
            tableCell.configure(for: item)
        }
        return cell
    }
}

extension TableViewDataSource where Self: Removing {
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public mutating func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}


extension TableViewDataSource where Self: NotAllRemoving, Self: DataContaining {
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return numberOfItems > minimumNumberOfItems
    }
}

extension TableViewDataSource where Self: Moving {
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public mutating func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}


public protocol Configurable {
    associatedtype ConfiguredType
    func configure(for item: ConfiguredType)
}

public protocol TableViewCellConfiguring {
    associatedtype TableCellType: Configurable
}

public protocol Removing {
    mutating func remove(at index: Int)
}

public extension Removing where Self: MutableDataContaining {
    mutating func remove(at index: Int) {
        data.remove(at: index)
    }
}

public protocol NotAllRemoving: Removing {
    var minimumNumberOfItems: Int { get }
}

public protocol Moving {
    mutating func move(from sourceIndex: Int, to destinationIndex: Int)
}

public extension Moving where Self: MutableDataContaining {
    mutating func move(from sourceIndex: Int, to destinationIndex: Int) {
        let item = data.remove(at: sourceIndex)
        data.insert(item, at: destinationIndex)
    }
}


extension CollectionViewDataSource where Self: DataContaining, Self: CollectionViewCellConfiguring, Self.ItemType == Self.CollectionCellType.ConfiguredType {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultReuseIdentifier, for: indexPath)
        if let item = item(at: indexPath.item), let cell = cell as? CollectionCellType {
            cell.configure(for: item)
        }
        return cell
    }
}

public protocol CollectionViewCellConfiguring {
    associatedtype CollectionCellType: Configurable
}

extension CollectionViewCell: Configurable {
    public typealias ConfiguredType = FramerExample
    public func configure(for item: FramerExample) {
        titleLabel.text = item.title
        imageView.image = item.image
    }
}

extension CollectionViewDataSource where Self: Moving {
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public mutating func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        move(from: sourceIndexPath.item, to: destinationIndexPath.item)
    }
    
}

extension TableViewCell: Configurable {
    public typealias ConfiguredType = FramerExample
    public func configure(for item: FramerExample) {
        textLabel?.text = item.title
        detailTextLabel?.text = item.author
        imageView?.image = item.image
    }
}


extension ExampleDataSource: MutableDataContaining {}
extension ExampleDataSource: TableViewDataSource {
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row == 0
    }
}
extension ExampleDataSource: TableViewCellConfiguring {
    public typealias TableCellType = TableViewCell
}
extension ExampleDataSource: NotAllRemoving {
    public var minimumNumberOfItems: Int {
        return 13
    }
}

extension ExampleDataSource: Moving {}
extension ExampleDataSource: CollectionViewDataSource {}
extension ExampleDataSource: CollectionViewCellConfiguring {
    public typealias CollectionCellType = CollectionViewCell
}
let dataSource = ExampleDataSource()
//let t = showTableViewController(for: dataSource, editing: true)
let c = showCollectionViewController(for: dataSource)

