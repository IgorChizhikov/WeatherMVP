//
//  TableViewCell.swift
//  WeatherMVP
//
//  Created by Игорь on 22.11.22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"

    private var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.textColor = .white
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dayLabel
    }()
    
    private var weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.contentMode = .scaleAspectFill
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        return weatherImage
    }()
    
    private var dayTempLabel: UILabel = {
        let dayTempLabel = UILabel()
        dayTempLabel.textColor = .white
        dayTempLabel.translatesAutoresizingMaskIntoConstraints = false
        dayTempLabel.textAlignment = .right
        
        return dayTempLabel
    }()
    
    private var nightTempLabel: UILabel = {
        let nightTempLabel = UILabel()
        nightTempLabel.textColor = .white
        nightTempLabel.translatesAutoresizingMaskIntoConstraints = false
        nightTempLabel.textAlignment = .right
        
        return nightTempLabel
    }()
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .white
        return separatorView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(weatherImage)
        contentView.addSubview(dayTempLabel)
        contentView.addSubview(nightTempLabel)
        
        dayLabel.text = "92"
        weatherImage.image = UIImage(systemName: "heart")
        weatherImage.tintColor = .white
        
        dayTempLabel.text = "-10"
        nightTempLabel.text = "18"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            separatorView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -1),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
            
        ])
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 4),
            dayLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height)
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 10),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: contentView.frame.height - 10),
            weatherImage.heightAnchor.constraint(equalToConstant: contentView.frame.height - 10)
        ])
        
        NSLayoutConstraint.activate([
            nightTempLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            nightTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nightTempLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            nightTempLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 4)
        ])
        
        
        NSLayoutConstraint.activate([
            dayTempLabel.trailingAnchor.constraint(equalTo: nightTempLabel.leadingAnchor, constant: 0),
            dayTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayTempLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            dayTempLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5)
        ])
        
        
        

    }
    
}
