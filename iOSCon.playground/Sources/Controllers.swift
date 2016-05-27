import UIKit
import XCPlayground

public let defaultReuseIdentifier = "default"

public func controllerForTableViewDataSource(dataSource:TableViewDataSource) -> (UITableViewController,TableViewDataSourceProxy) {
    let proxy = TableViewDataSourceProxy(dataSource: dataSource)
    let controller = UITableViewController(style: .Plain)
    controller.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: defaultReuseIdentifier)
    controller.tableView.dataSource = proxy
    return (controller,proxy)
}

public func controllerForCollectionViewDataSource(dataSource:CollectionViewDataSource) -> (UICollectionViewController,CollectionViewDataSourceProxy) {
    let proxy = CollectionViewDataSourceProxy(dataSource: dataSource)
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 15
    layout.minimumLineSpacing = 25
    let inset: CGFloat = 20
    layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    let cellWidth:CGFloat = 160
    layout.itemSize = CGSizeMake(cellWidth, cellWidth + 30)    
    let controller = UICollectionViewController(collectionViewLayout: layout)
    controller.collectionView?.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: defaultReuseIdentifier)
    controller.collectionView?.backgroundColor = UIColor.whiteColor()
    controller.collectionView?.dataSource = proxy
    controller.collectionView?.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    return (controller,proxy)
}

public func showNavigationViewController(rootViewController: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: rootViewController)
    nav.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
    XCPlaygroundPage.currentPage.liveView = nav.view
    return nav
}

public func showNavigationController(forCollectionDataSource dataSource: CollectionViewDataSource) -> (UINavigationController,Any,Any) {
    let data = controllerForCollectionViewDataSource(dataSource)
    let controller = data.0
    let nav = showNavigationViewController(controller)
    let refreshButton = Button(systemItem: .Refresh) {
        controller.collectionView?.reloadData()
    }
    controller.navigationItem.title = "Framer Examples"
    controller.navigationItem.rightBarButtonItem = refreshButton.barButtonItem
    return (nav,data, refreshButton)
}

public func showNavigationController(forTableDataSource dataSource: TableViewDataSource) -> (UINavigationController,Any,Any) {
    let data = controllerForTableViewDataSource(dataSource)
    let controller = data.0
    let nav = showNavigationViewController(controller)
    let refreshButton = Button(systemItem: .Refresh) {
        controller.tableView?.reloadData()
    }
    controller.navigationItem.title = "Framer Examples"
    controller.navigationItem.rightBarButtonItem = refreshButton.barButtonItem
    return (nav,data, refreshButton)
}

class Button {
    var barButtonItem: UIBarButtonItem?
    let action: () -> Void
    init(systemItem: UIBarButtonSystemItem, action: () -> Void) {
        self.action = action
        self.barButtonItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: self, action: #selector(Button.action(_:)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func action(sender: AnyObject) {
        action()
    }
}
