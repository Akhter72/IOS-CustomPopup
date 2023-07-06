import UIKit

class QuickStart: UIView {
    // UI elements
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "App Quickstart"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let stepTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let stepDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let stepImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    let countLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "jhsbdj"
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    // Override initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // Setup the UI elements and constraints
    private func setupUI() {
        // Add UI elements to the view
        addSubview(headerLabel)
        addSubview(stepTitleLabel)
        addSubview(stepDescriptionLabel)
        addSubview(stepImageView)
//        addSubview(previousButton)
        addSubview(countLbl)
        addSubview(nextButton)
        
        // Set constraints
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        stepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stepDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stepImageView.translatesAutoresizingMaskIntoConstraints = false
        countLbl.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header Label
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Step Title Label
            stepTitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            stepTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stepTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Step Description Label
            stepDescriptionLabel.topAnchor.constraint(equalTo: stepTitleLabel.bottomAnchor, constant: 8),
            stepDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stepDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Step Image View
            stepImageView.topAnchor.constraint(equalTo: stepDescriptionLabel.bottomAnchor, constant: 16),
            stepImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stepImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stepImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            // Previous Button
            countLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            countLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//
            // Next Button
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
