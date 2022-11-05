import UIKit

class LocationListCell: UITableViewCell {
    
    var nameLabel : UILabel
    var typeLabel : UILabel
    var dimensionlabel : UILabel
    
    var viewModel : LocationDetailViewModel?{
        didSet{
            nameLabel.text = viewModel?.location.name
            typeLabel.text = viewModel?.location.type
            dimensionlabel.text = viewModel?.location.dimension
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nameLabel = UILabel()
        typeLabel = UILabel()
        dimensionlabel = UILabel()
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
        container.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
    }

}
