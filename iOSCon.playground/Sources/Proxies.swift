import UIKit

public class TableViewDataSourceProxy: NSObject, UITableViewDataSource {
    var dataSource: TableViewDataSource
    
    public init(dataSource: TableViewDataSource) {
        self.dataSource = dataSource
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return dataSource.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.numberOfSectionsInTableView(tableView)
    }
}

public class CollectionViewDataSourceProxy: NSObject, UICollectionViewDataSource {
    var dataSource: CollectionViewDataSource
    
    public init(dataSource: CollectionViewDataSource) {
        self.dataSource = dataSource
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return dataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSectionsInCollectionView(collectionView)
    }
    
    public func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return dataSource.collectionView(collectionView, canMoveItemAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        dataSource.collectionView(collectionView, moveItemAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
    }
}

