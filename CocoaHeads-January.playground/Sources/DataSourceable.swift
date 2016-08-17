import UIKit

public protocol DataContaining {
    typealias ItemType
    var data: [ItemType] { get }
}

public extension DataContaining {
    var numberOfItems: Int {
        return data.count
    }
    
    func item(atIndex index: Int) -> ItemType? {
        guard index < numberOfItems else {
            return nil
        }
        return data[index]
    }
}

public protocol CellProviding {
    typealias ItemType
    func configure(cell: UITableViewCell, forItem item: ItemType, inTableView tableView: UITableView) -> UITableViewCell
}

public extension CellProviding {
    func configure(cell: UITableViewCell, forItem item: ItemType, inTableView tableView: UITableView) -> UITableViewCell {
        cell.textLabel?.text = String(item)
        return cell
    }
    
}
