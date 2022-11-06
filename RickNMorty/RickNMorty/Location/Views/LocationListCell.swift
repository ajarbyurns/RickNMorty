import UIKit

class LocationListCell: UITableViewCell {
    
    var nameLabel : UILabel
    var typeLabel : UILabel
    var dimensionLabel : UILabel
    
    var viewModel : LocationDetailViewModel?{
        didSet{
            nameLabel.text = viewModel?.location.name
            typeLabel.text = viewModel?.location.type
            dimensionLabel.text = "Dimension:\n\(viewModel?.location.dimension.capitalized ?? "")"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nameLabel = UILabel()
        typeLabel = UILabel()
        dimensionLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not In Storyboard")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupViews(){
        backgroundColor = .white
        //frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: 90)
        
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.borderWidth = 3
        container.layer.borderColor = UIColor.black.cgColor
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let leftFrame = UIView()
        leftFrame.backgroundColor = .white
        container.addSubview(leftFrame)
        leftFrame.translatesAutoresizingMaskIntoConstraints = false
        leftFrame.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        leftFrame.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        leftFrame.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        leftFrame.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        leftFrame.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: leftFrame.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leftFrame.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: leftFrame.trailingAnchor).isActive = true
        
        typeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        typeLabel.textColor = .black
        typeLabel.numberOfLines = 0
        typeLabel.textAlignment = .left
        leftFrame.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.bottomAnchor.constraint(equalTo: leftFrame.bottomAnchor).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: leftFrame.leadingAnchor).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: leftFrame.trailingAnchor).isActive = true
        typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        dimensionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        dimensionLabel.textColor = .black
        dimensionLabel.numberOfLines = 0
        dimensionLabel.textAlignment = .left
        container.addSubview(dimensionLabel)
        dimensionLabel.translatesAutoresizingMaskIntoConstraints = false
        dimensionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        dimensionLabel.leadingAnchor.constraint(equalTo: leftFrame.trailingAnchor).isActive = true
        dimensionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        dimensionLabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
    }

}
