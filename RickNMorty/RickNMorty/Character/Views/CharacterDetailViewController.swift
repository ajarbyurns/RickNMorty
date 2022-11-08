import UIKit

class CharacterDetailViewController: UIViewController {
    
    var viewModel : CharacterDetailViewModel
    var imageView : UIImageView
    var loading : UIActivityIndicatorView
    
    init(_ viewModel: CharacterDetailViewModel){
        self.viewModel = viewModel
        imageView = UIImageView()
        loading = UIActivityIndicatorView(style: .large)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not in Storyboard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.loadImage()
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        super.viewWillDisappear(animated)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = lightBG
        
        self.navigationController?.navigationBar.topItem?.title = viewModel.character.name
        
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
        
        let imageFrame = UIView()
        imageFrame.backgroundColor = lightBG
        imageFrame.layer.cornerRadius = 20
        imageFrame.layer.masksToBounds = true
        contentView.addSubview(imageFrame)
        imageFrame.translatesAutoresizingMaskIntoConstraints = false
        imageFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imageFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        imageFrame.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        imageFrame.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        loading.color = .black
        imageFrame.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.widthAnchor.constraint(equalToConstant: 40).isActive = true
        loading.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loading.centerYAnchor.constraint(equalTo: imageFrame.centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: imageFrame.centerXAnchor).isActive = true
        loading.startAnimating()
        
        imageView.contentMode = .scaleAspectFill
        imageFrame.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: imageFrame.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageFrame.heightAnchor).isActive = true
        
        let profileFrame = UIView()
        profileFrame.backgroundColor = .white
        contentView.addSubview(profileFrame)
        profileFrame.translatesAutoresizingMaskIntoConstraints = false
        profileFrame.topAnchor.constraint(equalTo: imageFrame.topAnchor, constant: 5).isActive = true
        profileFrame.leadingAnchor.constraint(equalTo: imageFrame.trailingAnchor, constant: 10).isActive = true
        profileFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        profileFrame.bottomAnchor.constraint(equalTo: imageFrame.bottomAnchor, constant: -5).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.text = viewModel.character.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        profileFrame.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: profileFrame.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileFrame.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: profileFrame.trailingAnchor).isActive = true
        
        let statusFrame = UIStackView()
        statusFrame.axis = .horizontal
        statusFrame.alignment = .center
        statusFrame.spacing = 5
        statusFrame.backgroundColor = .white
        profileFrame.addSubview(statusFrame)
        statusFrame.translatesAutoresizingMaskIntoConstraints = false
        statusFrame.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        statusFrame.leadingAnchor.constraint(equalTo: profileFrame.leadingAnchor).isActive = true
        statusFrame.trailingAnchor.constraint(lessThanOrEqualTo: profileFrame.trailingAnchor).isActive = true
        
        let statusLabel = UILabel()
        statusLabel.text = "Status: \(viewModel.character.status.rawValue.capitalized)"
        statusLabel.font = UIFont.systemFont(ofSize: 18)
        statusLabel.textColor = .black
        statusLabel.numberOfLines = 1
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.textAlignment = .left
        statusFrame.addArrangedSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let statusImage = UIImageView()
        switch viewModel.character.status {
        case .Alive:
            statusImage.image = UIImage(named: "Alive")
        case .Dead:
            statusImage.image = UIImage(named: "Dead")
        case .unknown:
            statusImage.image = UIImage(named: "Unknown")
        }
        statusFrame.addArrangedSubview(statusImage)
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        statusImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        statusImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let genderFrame = UIStackView()
        genderFrame.axis = .horizontal
        genderFrame.alignment = .center
        genderFrame.spacing = 5
        genderFrame.backgroundColor = .white
        profileFrame.addSubview(genderFrame)
        genderFrame.translatesAutoresizingMaskIntoConstraints = false
        genderFrame.topAnchor.constraint(equalTo: statusFrame.bottomAnchor, constant: 20).isActive = true
        genderFrame.leadingAnchor.constraint(equalTo: profileFrame.leadingAnchor).isActive = true
        genderFrame.trailingAnchor.constraint(lessThanOrEqualTo: profileFrame.trailingAnchor).isActive = true
        
        let genderLabel = UILabel()
        genderLabel.text = "Gender: \(viewModel.character.gender.rawValue.capitalized)"
        genderLabel.font = UIFont.systemFont(ofSize: 18)
        genderLabel.textColor = .black
        genderLabel.numberOfLines = 1
        genderLabel.adjustsFontSizeToFitWidth = true
        genderLabel.textAlignment = .left
        genderFrame.addArrangedSubview(genderLabel)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let genderImage = UIImageView()
        switch viewModel.character.gender {
        case .Male:
            genderImage.image = UIImage(named: "Male")
        case .Female:
            genderImage.image = UIImage(named: "Female")
        case .Genderless:
            genderImage.image = UIImage(named: "Genderless")
        case .unknown:
            genderImage.image = UIImage(named: "Unknown")
        }
        genderFrame.addArrangedSubview(genderImage)
        genderImage.translatesAutoresizingMaskIntoConstraints = false
        genderImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        genderImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let speciesLabel = UILabel()
        speciesLabel.text = "Species: \(viewModel.character.species)"
        speciesLabel.font = UIFont.systemFont(ofSize: 18)
        speciesLabel.textColor = .black
        speciesLabel.numberOfLines = 0
        speciesLabel.textAlignment = .left
        profileFrame.addSubview(speciesLabel)
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.topAnchor.constraint(equalTo: genderFrame.bottomAnchor, constant: 20).isActive = true
        speciesLabel.leadingAnchor.constraint(equalTo: profileFrame.leadingAnchor).isActive = true
        speciesLabel.trailingAnchor.constraint(equalTo: profileFrame.trailingAnchor).isActive = true
        
        let dateLabel = UILabel()
        dateLabel.text = viewModel.createdDate
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .left
        profileFrame.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.bottomAnchor.constraint(equalTo: profileFrame.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: profileFrame.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: profileFrame.trailingAnchor).isActive = true
        
        let createdLabel = UILabel()
        createdLabel.text = "Created"
        createdLabel.font = UIFont.boldSystemFont(ofSize: 14)
        createdLabel.textColor = .black
        createdLabel.numberOfLines = 0
        createdLabel.textAlignment = .left
        profileFrame.addSubview(createdLabel)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        createdLabel.leadingAnchor.constraint(equalTo: profileFrame.leadingAnchor).isActive = true
        createdLabel.trailingAnchor.constraint(equalTo: profileFrame.trailingAnchor).isActive = true
        
        let originHeaderLabel = UILabel()
        originHeaderLabel.text = "Origin"
        originHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        originHeaderLabel.textColor = .black
        originHeaderLabel.numberOfLines = 0
        originHeaderLabel.textAlignment = .left
        contentView.addSubview(originHeaderLabel)
        originHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        originHeaderLabel.topAnchor.constraint(equalTo: imageFrame.bottomAnchor, constant: 30).isActive = true
        originHeaderLabel.leadingAnchor.constraint(equalTo: imageFrame.leadingAnchor).isActive = true
        originHeaderLabel.widthAnchor.constraint(equalTo: imageFrame.widthAnchor).isActive = true
        
        let originLabel = UILabel()
        originLabel.text = viewModel.character.origin.name
        originLabel.font = UIFont.systemFont(ofSize: 16)
        originLabel.textColor = .black
        originLabel.numberOfLines = 0
        originLabel.textAlignment = .left
        contentView.addSubview(originLabel)
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        originLabel.topAnchor.constraint(equalTo: originHeaderLabel.bottomAnchor, constant: 5).isActive = true
        originLabel.leadingAnchor.constraint(equalTo: imageFrame.leadingAnchor).isActive = true
        originLabel.widthAnchor.constraint(equalTo: imageFrame.widthAnchor).isActive = true
        
        let locationHeaderLabel = UILabel()
        locationHeaderLabel.text = "Location"
        locationHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        locationHeaderLabel.textColor = .black
        locationHeaderLabel.numberOfLines = 0
        locationHeaderLabel.textAlignment = .left
        contentView.addSubview(locationHeaderLabel)
        locationHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        locationHeaderLabel.topAnchor.constraint(equalTo: imageFrame.bottomAnchor, constant: 30).isActive = true
        locationHeaderLabel.leadingAnchor.constraint(equalTo: profileFrame.leadingAnchor).isActive = true
        locationHeaderLabel.widthAnchor.constraint(equalTo: profileFrame.widthAnchor).isActive = true
        
        let locationLabel = UILabel()
        locationLabel.text = viewModel.character.location.name
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.textColor = .black
        locationLabel.numberOfLines = 0
        locationLabel.textAlignment = .left
        contentView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: locationHeaderLabel.bottomAnchor, constant: 5).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: profileFrame.leadingAnchor).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: profileFrame.widthAnchor).isActive = true
        
        let episodeHeaderLabel = UILabel()
        episodeHeaderLabel.text = "Episode"
        episodeHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        episodeHeaderLabel.textColor = .black
        episodeHeaderLabel.numberOfLines = 0
        episodeHeaderLabel.textAlignment = .left
        contentView.addSubview(episodeHeaderLabel)
        episodeHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeHeaderLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 30).isActive = true
        episodeHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        episodeHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        let episodeFrame = UIStackView()
        episodeFrame.axis = .vertical
        episodeFrame.alignment = .leading
        episodeFrame.spacing = 0
        episodeFrame.backgroundColor = .white
        contentView.addSubview(episodeFrame)
        episodeFrame.translatesAutoresizingMaskIntoConstraints = false
        episodeFrame.topAnchor.constraint(equalTo: episodeHeaderLabel.bottomAnchor, constant: 5).isActive = true
        episodeFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        episodeFrame.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10).isActive = true
        episodeFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        
        for epi in viewModel.character.episode {
            let label = createEpisodeLabel(epi)
            episodeFrame.addArrangedSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: episodeFrame.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: episodeFrame.trailingAnchor).isActive = true
        }
    }
    
    private func createEpisodeLabel(_ name : String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }

}

extension CharacterDetailViewController : CharacterDetailDelegate {
    
    func imageLoaded(_ imageData: Data) {
        imageView.image = UIImage(data: imageData)
        loading.stopAnimating()
    }
    
    func foundError(_ error: ApiError) {
        switch error {
        case .URL:
            print("URL Error")
        case .Connection:
            print("Connection Error")
        case .Json:
            print("JSON Error")
        }
    }
    
}
