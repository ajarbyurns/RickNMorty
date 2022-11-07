import UIKit

class EpisodeDetailViewController: UIViewController {
    
    var viewModel : EpisodeDetailViewModel
    
    init(_ viewModel: EpisodeDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not in Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        super.viewWillDisappear(animated)
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.topItem?.title = viewModel.episode.name
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        let contentView = UIView()
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.text = viewModel.episode.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        let dateLabel = UILabel()
        dateLabel.text = viewModel.createdDate
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .right
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        let createdLabel = UILabel()
        createdLabel.text = "Created"
        createdLabel.font = UIFont.boldSystemFont(ofSize: 14)
        createdLabel.textColor = .black
        createdLabel.numberOfLines = 0
        createdLabel.textAlignment = .left
        contentView.addSubview(createdLabel)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        createdLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        createdLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        let airDateLabel = UILabel()
        airDateLabel.text = "Air Date: \(viewModel.episode.airDate)"
        airDateLabel.font = UIFont.boldSystemFont(ofSize: 18)
        airDateLabel.textColor = .black
        airDateLabel.numberOfLines = 0
        airDateLabel.textAlignment = .left
        contentView.addSubview(airDateLabel)
        airDateLabel.translatesAutoresizingMaskIntoConstraints = false
        airDateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        let episodeLabel = UILabel()
        episodeLabel.text = "Season: \(viewModel.seasonNum ?? 0)\nEpisode: \(viewModel.episodeNum ?? 0)"
        episodeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        episodeLabel.textColor = .black
        episodeLabel.numberOfLines = 0
        episodeLabel.textAlignment = .left
        contentView.addSubview(episodeLabel)
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        episodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        episodeLabel.topAnchor.constraint(equalTo: airDateLabel.bottomAnchor, constant: 0).isActive = true
        
        let charactersHeaderLabel = UILabel()
        charactersHeaderLabel.text = "Characters:"
        charactersHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        charactersHeaderLabel.textColor = .black
        charactersHeaderLabel.numberOfLines = 0
        charactersHeaderLabel.textAlignment = .left
        contentView.addSubview(charactersHeaderLabel)
        charactersHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        charactersHeaderLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 30).isActive = true
        charactersHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        charactersHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        let charactersFrame = UIStackView()
        charactersFrame.axis = .vertical
        charactersFrame.alignment = .leading
        charactersFrame.spacing = 0
        charactersFrame.backgroundColor = .white
        contentView.addSubview(charactersFrame)
        charactersFrame.translatesAutoresizingMaskIntoConstraints = false
        charactersFrame.topAnchor.constraint(equalTo: charactersHeaderLabel.bottomAnchor, constant: 5).isActive = true
        charactersFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        charactersFrame.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10).isActive = true
        charactersFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        
        for res in viewModel.episode.characters {
            let label = createCharacterLabel(res)
            charactersFrame.addArrangedSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: charactersFrame.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: charactersFrame.trailingAnchor).isActive = true
        }
    }
    
    private func createCharacterLabel(_ name : String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }
}
