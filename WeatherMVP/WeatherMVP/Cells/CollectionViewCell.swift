//
//  CollectionViewCell.swift
//  WeatherMVP
//
//  Created by Игорь on 22.11.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        timeLabel.textColor = .white
        
        
        return timeLabel
    }()
    
    let weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.contentMode = .scaleAspectFit
        weatherImage.tintColor = .white

        return weatherImage
    }()
    
    let tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tempLabel.textColor = .white
        
        return tempLabel
    }()
    
    
    override init(frame: CGRect){
        super .init(frame: frame)
        
        addViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewConstraints(){
        
        contentView.addSubview(weatherImage)
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 3.8),
            weatherImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 3.8)
        ])
        
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            timeLabel.bottomAnchor.constraint(equalTo: weatherImage.topAnchor, constant: 0)
        ])
        
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            tempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 0 )
        ])

    }
    
    
}
