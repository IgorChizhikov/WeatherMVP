//
//  ViewController.swift
//  WeatherMVP
//
//  Created by Игорь on 20.11.22.
//

import UIKit

class WeatherController: UIViewController {
    
    private var presenter = WeatherPresenter()
    
    private var wallpapers = UIImageView()
    
    private var currentWeather = [Weather]()
    private var weatherPerDay = [WeatherPerDay]()
    private var forecast = [Forecast]()
    
    private var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "Minsk"
        cityLabel.font = UIFont(name: "Helvetica", size: 36)
        cityLabel.textColor = .white
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    private var currentTemplabel: UILabel = {
        let currentTemplabel = UILabel()
        currentTemplabel.text = "-12 | пасмурно"
        currentTemplabel.textAlignment = .center
        currentTemplabel.font = UIFont(name: "Helvetica", size: 18)
        currentTemplabel.textColor = .systemGray3
        currentTemplabel.translatesAutoresizingMaskIntoConstraints = false
        return currentTemplabel
    }()
    
    private let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(red: 65.0/255.0, green: 76.0/255.0, blue: 95.0/255.0, alpha: 1.0).withAlphaComponent(0.6)
        container.layer.cornerRadius = 14
        return container
    }()
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray2
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    private var currentInfoLabel: UILabel = {
        let currentInfoLabel = UILabel()
        currentInfoLabel.numberOfLines = 0
        currentInfoLabel.lineBreakMode = .byWordWrapping
        currentInfoLabel.text = "Облачная погода до конца дня. Порывы ветра до 25 км/ч."
        currentInfoLabel.textColor = .white
        currentInfoLabel.font = UIFont(name: "Helvetica", size: 15)
        currentInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentInfoLabel
    }()
    
    private  let dayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let dayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dayCollectionView.setCollectionViewLayout(layout, animated: true)
        
        dayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dayCollectionView.backgroundColor = .clear
        dayCollectionView.showsHorizontalScrollIndicator = false
        dayCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)

        return dayCollectionView
    }()
    
    private let weekTableView: UITableView = {
        let weekTableView = UITableView()
        weekTableView.translatesAutoresizingMaskIntoConstraints = false
        weekTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        weekTableView.estimatedRowHeight = 110
        weekTableView.rowHeight = UITableView.automaticDimension
        weekTableView.layer.cornerRadius = 14
        weekTableView.tableFooterView = UIView()
        weekTableView.separatorStyle = .none
        return weekTableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setVeiwDelegate(delegate: self)
        presenter.getWeatherData()
        
        addWallpapers()
        setupCityLabelConstraints()
        setupCurrentTemplabelConstraints()
        setupContainerConstraints()
        setupCurrentInfoLabelConstraints()
        setupSeparatorViewConstraints()
        setupDayCollectionViewConstraints()
        setupWeekTableViewConstraints()
        weekTableView.backgroundColor = UIColor(red: 65.0/255.0, green: 76.0/255.0, blue: 95.0/255.0, alpha: 1.0).withAlphaComponent(0.6)
        
    }
    
    func addWallpapers(){
        view.addSubview(wallpapers)
        wallpapers.frame = view.bounds
        wallpapers.image = UIImage(named: "wallpapers")
    }
    
    func setupCityLabelConstraints() {
        view.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            cityLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupCurrentTemplabelConstraints() {
        view.addSubview(currentTemplabel)
        NSLayoutConstraint.activate([
            currentTemplabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currentTemplabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currentTemplabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            currentTemplabel.heightAnchor.constraint(equalToConstant: 19)
        ])
    }
    
    func setupContainerConstraints() {
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            container.topAnchor.constraint(equalTo: currentTemplabel.bottomAnchor, constant: 50),
            container.heightAnchor.constraint(equalToConstant: view.frame.width / 2.3)
        ])
    }
    
    func setupCurrentInfoLabelConstraints(){
        container.addSubview(currentInfoLabel)
        NSLayoutConstraint.activate([
            currentInfoLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            currentInfoLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50),
            currentInfoLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            currentInfoLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupSeparatorViewConstraints(){
        container.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            separatorView.topAnchor.constraint(equalTo: currentInfoLabel.bottomAnchor, constant: 10),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupDayCollectionViewConstraints() {
        container.addSubview(dayCollectionView)
        NSLayoutConstraint.activate([
            dayCollectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            dayCollectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            dayCollectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            dayCollectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
    }
    
    func setupWeekTableViewConstraints() {
        view.addSubview(weekTableView)
        NSLayoutConstraint.activate([
            weekTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            weekTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            weekTableView.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 10),
            weekTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        weekTableView.delegate = self
        weekTableView.dataSource = self
        weekTableView.separatorStyle = .none
    }


}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

extension WeatherController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = dayCollectionView.frame.height / 1.4
        let height = dayCollectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dayCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.timeLabel.text = "12"
        cell.weatherImage.image = UIImage(systemName: "cloud.fill")
        cell.tempLabel.text = "+5"

        
        return cell
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension WeatherController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weekTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.weatherImage.image = UIImage(systemName: "cloud.fill")
        
        return cell
    }
    
    
    
}


// MARK: - WeatherPresenterDelegate -
extension WeatherController: WeatherPresenterDelegate {
    func presentCurrentWeather(weather: [Weather]) {
        self.currentWeather = weather
    }
    
    func presentWeatherPerDay(weather: [WeatherPerDay]) {
        self.weatherPerDay = weather
    }
    
    func presentForecast(weather: [Forecast]) {
        self.forecast = weather
    }
    
//    func presentCurrentWeather(weather: Weather) {
//        self.currentWeather = weather
//    }
//
//    func presentWeatherPerDay(weather: WeatherPerDay) {
//        self.weatherPerDay = weather
//    }
//
//    func presentForecast(weather: Forecast) {
//        self.forecast = weather
//    }
    
    
}
