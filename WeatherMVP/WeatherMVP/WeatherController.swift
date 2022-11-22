//
//  ViewController.swift
//  WeatherMVP
//
//  Created by Игорь on 20.11.22.
//

import UIKit

class WeatherController: UIViewController {
    
    private var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "Minsk"
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    private var currentTemplabel: UILabel = {
        let currentTemplabel = UILabel()
        currentTemplabel.text = "-12 | пасмурно"
        currentTemplabel.textAlignment = .center
        currentTemplabel.translatesAutoresizingMaskIntoConstraints = false
        return currentTemplabel
    }()
    
    private let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemGray2.withAlphaComponent(0.2)
        container.layer.cornerRadius = 14
        return container
    }()
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray5
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    private var currentInfoLabel: UILabel = {
        let currentInfoLabel = UILabel()
        currentInfoLabel.text = "1231231231231231"
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
        
        view.backgroundColor = .darkGray
        
        setupCityLabelConstraints()
        setupCurrentTemplabelConstraints()
        setupContainerConstraints()
        setupCurrentInfoLabelConstraints()
        setupSeparatorViewConstraints()
        setupDayCollectionViewConstraints()
        setupWeekTableViewConstraints()
        weekTableView.backgroundColor = .systemPink
        
    }
    
    
    func setupCityLabelConstraints() {
        view.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60.72),
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
            container.topAnchor.constraint(equalTo: currentTemplabel.bottomAnchor, constant: 10),
            container.heightAnchor.constraint(equalToConstant: view.frame.width / 3.5)
        ])
    }
    
    func setupCurrentInfoLabelConstraints(){
        container.addSubview(currentInfoLabel)
        NSLayoutConstraint.activate([
            currentInfoLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            currentInfoLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            currentInfoLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            currentInfoLabel.heightAnchor.constraint(equalToConstant: 20)
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


extension WeatherController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = dayCollectionView.frame.height
        let height = dayCollectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dayCollectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.timeLabel.text = "12"
        cell.weatherImage.image = UIImage(systemName: "person")
        cell.tempLabel.text = "+5"
        
        cell.backgroundColor = .red
        
        return cell
    }
    
}


extension WeatherController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weekTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    
}
