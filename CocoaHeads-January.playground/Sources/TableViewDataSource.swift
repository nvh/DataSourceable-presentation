import UIKit

public protocol TableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?
}

public extension TableViewDataSource {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
}

