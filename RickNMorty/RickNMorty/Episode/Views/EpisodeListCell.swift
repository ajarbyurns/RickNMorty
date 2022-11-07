import UIKit

class EpisodeListCell: UITableViewCell {
    
    var nameLabel : UILabel
    var episodeLabel : UILabel
    var airDateLabel : UILabel
    
    var viewModel : EpisodeDetailViewModel?{
        didSet{
            nameLabel.text = viewModel?.episode.name
            episodeLabel.text = "season: \(viewModel?.seasonNum ?? 0)\nepisode: \(viewModel?.episodeNum ?? 0)"
            airDateLabel.text = viewModel?.episode.airDate
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nameLabel = UILabel()
        episodeLabel = UILabel()
        airDateLabel = UILabel()
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
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 1
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .left
        container.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        
        episodeLabel.font = UIFont.systemFont(ofSize: 14)
        episodeLabel.textColor = .black
        episodeLabel.numberOfLines = 2
        episodeLabel.adjustsFontSizeToFitWidth = true
        episodeLabel.textAlignment = .left
        container.addSubview(episodeLabel)
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20).isActive = true
        episodeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        episodeLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        episodeLabel.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor).isActive = true
        
        airDateLabel.font = UIFont.systemFont(ofSize: 14)
        airDateLabel.textColor = .black
        airDateLabel.numberOfLines = 1
        airDateLabel.adjustsFontSizeToFitWidth = true
        airDateLabel.textAlignment = .left
        container.addSubview(airDateLabel)
        airDateLabel.translatesAutoresizingMaskIntoConstraints = false
        airDateLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20).isActive = true
        airDateLabel.leadingAnchor.constraint(equalTo: episodeLabel.trailingAnchor, constant: 10).isActive = true
        airDateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        
        let airDateHeaderLabel = UILabel()
        airDateHeaderLabel.text = "Air Date:"
        airDateHeaderLabel.font = UIFont.systemFont(ofSize: 14)
        airDateHeaderLabel.textColor = .black
        airDateHeaderLabel.numberOfLines = 1
        airDateHeaderLabel.adjustsFontSizeToFitWidth = true
        airDateHeaderLabel.textAlignment = .left
        container.addSubview(airDateHeaderLabel)
        airDateHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        airDateHeaderLabel.bottomAnchor.constraint(equalTo: airDateLabel.topAnchor).isActive = true
        airDateHeaderLabel.leadingAnchor.constraint(equalTo: airDateLabel.leadingAnchor).isActive = true
        airDateHeaderLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        airDateHeaderLabel.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor).isActive = true

    }

}
