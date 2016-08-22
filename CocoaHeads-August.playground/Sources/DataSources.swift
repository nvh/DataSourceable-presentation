import UIKit

public protocol TableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool

    mutating func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    
    mutating func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

// Sections
public extension TableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// Editing
public extension TableViewDataSource {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    mutating func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

// Moving
public extension TableViewDataSource {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    mutating func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
}

public protocol CollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
    
    mutating func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

// Sections
public extension CollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// Moving
public extension CollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    mutating func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
}


//extension CollectionViewDataSource where Self: DataContaining, Self: CollectionViewCellConfiguring, Self.ItemType == Self.CollectionCellType.ConfiguredType {
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return numberOfItems
//    }
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultReuseIdentifier, for: indexPath)
//        if let item = item(at: indexPath.item), let cell = cell as? CollectionCellType {
//            cell.configure(for: item)
//        }
//        return cell
//    }
//}
//
//public protocol CollectionViewCellConfiguring {
//    associatedtype CollectionCellType: Configurable
//}
//
//extension CollectionViewCell: Configurable {
//    public typealias ConfiguredType = FramerExample
//    public func configure(for item: FramerExample) {
//        titleLabel.text = item.title
//        imageView.image = item.image
//    }
//}


//public extension CollectionViewDataSource where Self: Moving {
//    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    public mutating func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        move(from: sourceIndexPath.item, to: destinationIndexPath.item)
//    }
//}

