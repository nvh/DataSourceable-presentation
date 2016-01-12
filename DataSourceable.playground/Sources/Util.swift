import UIKit
import XCPlayground

public let defaultCellIdentifier = "default"

public func showTableViewWithDataSource(dataSource:UITableViewDataSource) {
    let tableView = UITableView(frame:CGRect(x: 0, y: 0, width: 320, height: 1500), style: .Grouped)
    tableView.registerClass(DetailCell.self, forCellReuseIdentifier: defaultCellIdentifier)
    tableView.dataSource = dataSource
    XCPlaygroundPage.currentPage.liveView = tableView
}

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
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.tableView(tableView, titleForHeaderInSection: section)
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource.tableView(tableView, titleForFooterInSection: section)
    }
}


public class DetailCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //Hack to force the style for this cell
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

