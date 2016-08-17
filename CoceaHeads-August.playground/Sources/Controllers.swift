import UIKit
import PlaygroundSupport

public let defaultReuseIdentifier = "default"

public func tableViewController(for dataSource:TableViewDataSource) -> (UITableViewController,TableViewDataSourceProxy) {
    let proxy = TableViewDataSourceProxy(dataSource: dataSource)
    let controller = UITableViewController(style: .plain)
    controller.tableView.register(TableViewCell.self, forCellReuseIdentifier: defaultReuseIdentifier)
    controller.tableView.dataSource = proxy
    return (controller,proxy)
}

public func collectionViewController(for dataSource:CollectionViewDataSource) -> (UICollectionViewController,CollectionViewDataSourceProxy) {
    let proxy = CollectionViewDataSourceProxy(dataSource: dataSource)
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 15
    layout.minimumLineSpacing = 25
    let inset: CGFloat = 20
    layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    let cellWidth:CGFloat = 160
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 30)
    let controller = UICollectionViewController(collectionViewLayout: layout)
    controller.collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: defaultReuseIdentifier)
    controller.collectionView?.backgroundColor = UIColor.white
    controller.collectionView?.dataSource = proxy
    controller.collectionView?.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    return (controller,proxy)
}

public func showNavigationViewController(with rootViewController: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: rootViewController)
    nav.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
    PlaygroundPage.current.liveView = nav
    return nav
}

public func showCollectionViewController(for dataSource: CollectionViewDataSource) -> (UINavigationController,Any,Any) {
    let data = collectionViewController(for: dataSource)
    let controller = data.0
    let nav = showNavigationViewController(with: controller)
    let refreshButton = Button(systemItem: .refresh) {
        controller.collectionView?.reloadData()
    }
    controller.navigationItem.title = "Framer Examples"
    controller.navigationItem.rightBarButtonItem = refreshButton.barButtonItem
    return (nav,data, refreshButton)
}

public func showTableViewController(for dataSource: TableViewDataSource, editing: Bool = true) -> (UINavigationController,(UITableViewController,TableViewDataSourceProxy),Any) {
    let data = tableViewController(for: dataSource)
    let controller = data.0
    if editing {
        controller.setEditing(editing, animated: true)
    }
    let nav = showNavigationViewController(with: controller)
    let refreshButton = Button(systemItem: .refresh) {
        controller.tableView?.reloadData()
    }
    controller.navigationItem.title = "Framer Examples"
    controller.navigationItem.rightBarButtonItem = refreshButton.barButtonItem
    return (nav,data, refreshButton)
}

class Button {
    var barButtonItem: UIBarButtonItem?
    let action: () -> Void
    init(systemItem: UIBarButtonSystemItem, action: @escaping () -> Void) {
        self.action = action
        self.barButtonItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: self, action: #selector(Button.action(sender:)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func action(sender: AnyObject) {
        action()
    }
}
