
import UIKit

final class MovieViewController: UIViewController {

    //MARK: - Properties
    private var movieList = [MovieSearched.Movie]()
    
    private var movieURLString = "https://www.omdbapi.com/?apikey=cc5baf54&s=star"
    
    private let mainStackView = UIStackView()
    
    private let movieTableView = UITableView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setupConstraints()
        setupUI()
        networkGetData()
        registerMovieTableViewCell()
    }
    
    //MARK: - Network (სავარაუდოდ იქ არ წერია სადაც უნდა იყოს?)
    private func networkGetData() {
        NetworkService.shared.getMovieData(urlString: movieURLString) { (result: Result<[MovieSearched.Movie], Error>) in
            switch result {
            case .success(let data):
                self.movieList = data
                self.movieTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Add SubViews, Constraints, UI
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(movieTableView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupMovieTableViewConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupMovieTableViewUI()
    }
    
    private func registerMovieTableViewCell() {
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
    }
    
    //MARK: - Setup UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
    }
    
    private func setupMovieTableViewUI() {
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }

    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupMovieTableViewConstraints() {
        NSLayoutConstraint.activate([
            movieTableView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            movieTableView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        cell.textLabel?.text = movieList[indexPath.row].Title
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: URL(string: self.movieList[indexPath.row].Poster)!)
            
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: data)
            }
        }
        return cell
    }

}
