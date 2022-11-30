//
//  TableViewCell.swift
//  WeatherMVP
//
//  Created by Игорь on 22.11.22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"

    var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.textColor = .white
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.numberOfLines = 0
        
        return dayLabel
    }()
    
    var weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.contentMode = .scaleAspectFit
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        return weatherImage
    }()
    
    var minTempLabel: UILabel = {
        let dayTempLabel = UILabel()
        dayTempLabel.textColor = .systemGray2
        dayTempLabel.translatesAutoresizingMaskIntoConstraints = false
        dayTempLabel.textAlignment = .right
        dayTempLabel.numberOfLines = 0
        
        return dayTempLabel
    }()
    
    var maxTempLabel: UILabel = {
        let nightTempLabel = UILabel()
        nightTempLabel.textColor = .white
        nightTempLabel.translatesAutoresizingMaskIntoConstraints = false
        nightTempLabel.textAlignment = .right
        nightTempLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        return nightTempLabel
    }()
    
    let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .systemGray
        return separatorView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(weatherImage)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(maxTempLabel)
        
        weatherImage.image = UIImage(systemName: "cloud.fill")
        weatherImage.tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            separatorView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            separatorView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -1),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
            
        ])
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            dayLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
            dayLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 3),
            dayLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height)
            
        ])
        dayLabel.font =  UIFont.systemFont(ofSize: contentView.frame.height / 3, weight: .regular)
        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 15),
            weatherImage.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: contentView.frame.height / 2.2),
            weatherImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2.2)
        ])
        
        NSLayoutConstraint.activate([
            maxTempLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            maxTempLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            maxTempLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            maxTempLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 4)
        ])
        maxTempLabel.font =  UIFont.systemFont(ofSize: contentView.frame.height / 3, weight: .regular)
        
        NSLayoutConstraint.activate([
            minTempLabel.trailingAnchor.constraint(equalTo: maxTempLabel.leadingAnchor, constant: 0),
            minTempLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            minTempLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            minTempLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5)
        ])
        minTempLabel.font =  UIFont.systemFont(ofSize: contentView.frame.height / 3, weight: .regular)
        
        

    }
    
}
