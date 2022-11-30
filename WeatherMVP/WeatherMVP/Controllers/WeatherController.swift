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
    
    private var currentWeather = Weather()
    private var dayWeather = [DayWeather]()
    private var forecast = [Forecast]()
    
    private var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        cityLabel.textColor = .white
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    private var currentTemplabel: UILabel = {
        let currentTemplabel = UILabel()
        currentTemplabel.textAlignment = .center
        currentTemplabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
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
        separatorView.backgroundColor = .systemGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    private var currentInfoLabel: UILabel = {
        let currentInfoLabel = UILabel()
        currentInfoLabel.numberOfLines = 0
        currentInfoLabel.lineBreakMode = .byWordWrapping
        currentInfoLabel.textColor = .white
        currentInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentInfoLabel
    }()
    
    private  let dayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let dayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dayCollectionView.setCollectionViewLayout(layout, animated: true)
        dayCollectionView.isScrollEnabled = false
        
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
        if #available(iOS 15.0, *) {
            weekTableView.sectionHeaderTopPadding = 0.0
        }
        weekTableView.isScrollEnabled = false
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
        currentInfoLabel.font = UIFont.systemFont(ofSize: view.frame.width / 35, weight: .regular)
        addCurrentWeatherInfo()
        
    }
    
    func addCurrentWeatherInfo(){
        cityLabel.text = currentWeather.city
        
        if let text = currentWeather.temperature, let text2 = currentWeather.weatherDescription {
            currentTemplabel.text = "\(text)"
            currentInfoLabel.text = "\(text2)"
        }
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
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
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
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: currentTemplabel.bottomAnchor, constant: view.frame.width / 10),
            container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 6 )
        ])
    }
    
    func setupCurrentInfoLabelConstraints(){
        container.addSubview(currentInfoLabel)
        NSLayoutConstraint.activate([
            currentInfoLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            currentInfoLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1 / 1.4),
            currentInfoLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            currentInfoLabel.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1 / 3.8)
        ])
    }
    
    func setupSeparatorViewConstraints(){
        container.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            separatorView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            separatorView.topAnchor.constraint(equalTo: currentInfoLabel.bottomAnchor, constant: 10),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupDayCollectionViewConstraints() {
        container.addSubview(dayCollectionView)
        NSLayoutConstraint.activate([
            dayCollectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            dayCollectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            dayCollectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 5),
            dayCollectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5)
        ])
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
    }
    
    func setupWeekTableViewConstraints() {
        view.addSubview(weekTableView)
        NSLayoutConstraint.activate([
            weekTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weekTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            weekTableView.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 10),
            weekTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        weekTableView.delegate = self
        weekTableView.dataSource = self
        weekTableView.separatorStyle = .none
    }
    
    func convertDayData(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: inputDate)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

extension WeatherController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(currentWeather.weatherPerDay.count)
        return currentWeather.weatherPerDay.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = dayCollectionView.frame.width / 2 / 3
        let height = dayCollectionView.frame.height
        
        if indexPath.item == 3 {
            return CGSize(width: ((dayCollectionView.frame.width - width) / 1.7), height: dayCollectionView.frame.height)
        }
        return CGSize(width: width, height: height)
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dayCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.tempLabel.font = UIFont.systemFont(ofSize: cell.weatherImage.frame.width / 1.5)
        cell.timeLabel.font = UIFont.systemFont(ofSize: cell.weatherImage.frame.width / 1.5)
        
        if indexPath.item == 3 {
            cell.tempLabel.text = "Заход солнца"
            let image = UIImage(systemName: "sunset.fill")
            cell.tempLabel.font = UIFont.systemFont(ofSize: cell.weatherImage.frame.width / 1.2)
            cell.weatherImage.image = image
            if #available(iOS 15.0, *) {
                let config = UIImage.SymbolConfiguration(paletteColors: [.white, .yellow])
                cell.weatherImage.image = image!.applyingSymbolConfiguration(config)
            } else {
                cell.weatherImage.tintColor = .yellow
            }

        } else {
            if let text = dayWeather[indexPath.row].temperature {
                cell.tempLabel.text = text + "°"
            }
            cell.weatherImage.image = UIImage(systemName: "cloud.fill")
            cell.weatherImage.tintColor = .white
        }
        
        if indexPath.item == 0 {
            cell.timeLabel.text = "Сейчас"
        } else {
            cell.timeLabel.text = dayWeather[indexPath.row].timestamp
        }

        
        return cell
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension WeatherController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(currentWeather.forecast.count)
        return currentWeather.forecast.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weekTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if indexPath.item == 0 {
            cell.dayLabel.text = "Сегодня"
        } else {
            let newDate = Date().stringToDate(forecast[indexPath.row].date!)
            cell.dayLabel.text = Date().shortDayName(newDate)
        }
    
        if let text = forecast[indexPath.row].maxTemperature, let text2 = forecast[indexPath.row].minTemperature {
            cell.minTempLabel.text = "\(text)°"
            cell.maxTempLabel.text = "\(text2)°"
        }
        
        if indexPath.item == 8 {
            cell.separatorView.isHidden = true
        } else {
            cell.separatorView.isHidden = false
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height / 11))
        
        let y = (headerView.frame.height - headerView.frame.height / 2.5) / 2
        let image = UIImageView()
        image.frame = CGRect.init(x: 15, y: y, width: headerView.frame.height / 2.5, height: headerView.frame.height / 2.5)
        image.image = UIImage(systemName: "calendar")
        image.tintColor = .systemGray
        
        let label = UILabel()
        label.frame = CGRect.init(x: (20 + headerView.frame.height / 2.5), y: 0, width: headerView.frame.width-10-headerView.frame.height, height: headerView.frame.height)
        label.text = "10-DAY FORECAST"
        label.font = UIFont.systemFont(ofSize: headerView.frame.height / 3.5, weight: .regular)
        label.textColor = .systemGray
        
        let separator = UIView()
        separator.frame = CGRect.init(x: 15, y: headerView.frame.height - 1, width: headerView.frame.width-30, height: 1)
        separator.backgroundColor = .systemGray
        
        headerView.addSubview(image)
        headerView.addSubview(label)
        headerView.addSubview(separator)
        
        return headerView
    }
    
}


// MARK: - WeatherPresenterDelegate -

extension WeatherController: WeatherPresenterDelegate {
    func presentCurrentWeather(weather: Weather) {
        self.currentWeather = weather
    }
    
    func presentWeatherPerDay(weather: [DayWeather]) {
        dayWeather.removeAll()
        self.dayWeather.append(contentsOf: weather)
        
        DispatchQueue.main.async {
            self.dayCollectionView.reloadData()
        }
    }
    
    func presentForecast(weather: [Forecast]) {
        forecast.removeAll()
        self.forecast.append(contentsOf: weather)
        
        DispatchQueue.main.async {
            self.weekTableView.reloadData()
        }
    }

    
}

