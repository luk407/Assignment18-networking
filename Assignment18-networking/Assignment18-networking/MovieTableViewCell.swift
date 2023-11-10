
import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private let mainStackView = UIStackView()
    
    var moviePosterImageView = UIImageView()
    
    let movieNameTextView = UITextView()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubViews()
        setupConstraints()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
        movieNameTextView.text = nil
    }
    
    //MARK: - Methods
    private func addSubViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(moviePosterImageView)
        mainStackView.addArrangedSubview(movieNameTextView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupMoviePosterImageViewUI()
        setupMovieNameTextViewUI()
    }
    
    //MARK: - UI
    private func setupMainStackViewUI() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.axis = .horizontal
        mainStackView.spacing = 5
        mainStackView.alignment = .center
    }
    
    private func setupMoviePosterImageViewUI() {
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMovieNameTextViewUI() {
        movieNameTextView.translatesAutoresizingMaskIntoConstraints = false
        movieNameTextView.font = UIFont.boldSystemFont(ofSize: 10)
        movieNameTextView.textAlignment = .left
        movieNameTextView.textColor = .black
        movieNameTextView.textContainer.lineBreakMode = NSLineBreakMode.byCharWrapping
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
}

