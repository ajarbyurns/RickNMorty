import UIKit

class LocationDetailViewController: UIViewController {
    
    var viewModel : LocationDetailViewModel
    
    init(_ viewModel: LocationDetailViewModel){
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
        
        self.navigationController?.navigationBar.topItem?.title = viewModel.location.name
        
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
        nameLabel.text = viewModel.location.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        let createdLabel = UILabel()
        createdLabel.text = "Created"
        createdLabel.font = UIFont.boldSystemFont(ofSize: 14)
        createdLabel.textColor = .black
        createdLabel.numberOfLines = 0
        createdLabel.textAlignment = .left
        contentView.addSubview(createdLabel)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        createdLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        createdLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        let dateLabel = UILabel()
        dateLabel.text = viewModel.createdDate
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .left
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
        
        let typeLabel = UILabel()
        typeLabel.text = "Type: \(viewModel.location.type.capitalized)"
        typeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        typeLabel.textColor = .black
        typeLabel.numberOfLines = 0
        typeLabel.textAlignment = .left
        contentView.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10).isActive = true
        
        let dimensionLabel = UILabel()
        dimensionLabel.text = "Dimension:\n\(viewModel.location.dimension.capitalized)"
        dimensionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        dimensionLabel.textColor = .black
        dimensionLabel.numberOfLines = 0
        dimensionLabel.textAlignment = .left
        contentView.addSubview(dimensionLabel)
        dimensionLabel.translatesAutoresizingMaskIntoConstraints = false
        dimensionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        dimensionLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10).isActive = true
        dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20).isActive = true
        
        let residentHeaderLabel = UILabel()
        residentHeaderLabel.text = "Residents:"
        residentHeaderLabel.font = UIFont.boldSystemFont(ofSize: 18)
        residentHeaderLabel.textColor = .black
        residentHeaderLabel.numberOfLines = 0
        residentHeaderLabel.textAlignment = .left
        contentView.addSubview(residentHeaderLabel)
        residentHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        residentHeaderLabel.topAnchor.constraint(equalTo: dimensionLabel.bottomAnchor, constant: 30).isActive = true
        residentHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        residentHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        let residentFrame = UIStackView()
        residentFrame.axis = .vertical
        residentFrame.alignment = .leading
        residentFrame.spacing = 0
        residentFrame.backgroundColor = .white
        contentView.addSubview(residentFrame)
        residentFrame.translatesAutoresizingMaskIntoConstraints = false
        residentFrame.topAnchor.constraint(equalTo: residentHeaderLabel.bottomAnchor, constant: 5).isActive = true
        residentFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        residentFrame.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10).isActive = true
        residentFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        
        for res in viewModel.location.residents {
            let label = createResidentLabel(res)
            residentFrame.addArrangedSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: residentFrame.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: residentFrame.trailingAnchor).isActive = true
        }
    }
    
    private func createResidentLabel(_ name : String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }
}
