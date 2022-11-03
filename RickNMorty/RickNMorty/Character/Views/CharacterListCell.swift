
import UIKit

class CharacterListCell: UICollectionViewCell {
    
    var loading : UIActivityIndicatorView
    var imageView: UIImageView
    var nameLabel : UILabel
    var speciesLabel : UILabel
    var content : UIView
    var character : Character?
    
    override init(frame : CGRect){
        self.loading = UIActivityIndicatorView(style: .large)
        self.imageView = UIImageView()
        self.nameLabel = UILabel()
        self.speciesLabel = UILabel()
        self.content = UIView()
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews(){
        backgroundColor = lightBG
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        loading.color = .black
        addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.widthAnchor.constraint(equalToConstant: 40).isActive = true
        loading.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loading.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loading.hidesWhenStopped = false
        loading.startAnimating()
        
        content.backgroundColor = .clear
        addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        content.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        let labelView = UIView()
        labelView.backgroundColor = .clear
        content.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.widthAnchor.constraint(equalTo: content.widthAnchor).isActive = true
        labelView.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        labelView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -10).isActive = true
        
        speciesLabel.font = UIFont.systemFont(ofSize: 12)
        speciesLabel.textColor = .darkGray
        speciesLabel.numberOfLines = 0
        speciesLabel.textAlignment = .center
        labelView.addSubview(speciesLabel)
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        speciesLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10).isActive = true
        speciesLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -10).isActive = true
        speciesLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -10).isActive = true
        
        content.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: content.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: labelView.topAnchor).isActive = true
                
    }
     
    required init?(coder: NSCoder) {
        fatalError("Not In Storyboard")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loading.startAnimating()
    }
    
    func setCharacter(chara : Character){
        
        character = chara
        nameLabel.text = chara.name
        speciesLabel.text = chara.species
        
        switch chara.species {
        case "Alien":
            backgroundColor = .systemGreen
        case "Animal":
            backgroundColor = .systemRed
        case "Mythological Creature":
            backgroundColor = .systemCyan
        default:
            backgroundColor = lightBG
        }
    }
    
}
