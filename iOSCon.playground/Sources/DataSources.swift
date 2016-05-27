import UIKit

public protocol TableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
}

public extension TableViewDataSource {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

public protocol CollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool
    
    mutating func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
}

public extension CollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    mutating func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    }
}


//extension CollectionViewDataSource where Self: DataContaining, Self: CollectionCellConfiguring, Self.ItemType == Self.CollectionCellType.ItemType {
//    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return numberOfItems
//    }
//    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(defaultReuseIdentifier, forIndexPath: indexPath)
//        if let item = item(atIndex: indexPath.item), cell = cell as? CollectionCellType {
//            cell.configure(forItem: item)
//        }
//        return cell
//    }
//    
//}

//public protocol CollectionCellConfiguring {
//    associatedtype CollectionCellType: Configurable
//}

//extension CollectionViewCell: Configurable {
//    public typealias ItemType = FramerExample
//    public func configure(forItem item: ItemType) {
//        titleLabel?.text = item.title
//        imageView?.image = item.image
//    }
//}
