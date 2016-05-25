import UIKit

public class TableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //Hack to force the style for this cell
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "Cell"
    
    public var imageView: UIImageView!
    public var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        titleLabel = UILabel(frame: CGRect(x: 0, y: frame.width + 12, width: frame.width, height: 20))
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
        imageView.layer.borderColor = UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).CGColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.darkGrayColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}