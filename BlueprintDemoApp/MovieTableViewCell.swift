//
//  MovieTableViewCell.swift
//  BlueprintDemoApp
//
//  Created by Mindy Long on 2/20/21.
//
import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // We want to display the movie's poster image
    let poster = UIImageView()
    
    // Other properties of a movie
    let title = UILabel()
    let releaseDate = UILabel()
    let overview = UILabel()
    let rating = UILabel()
    
    // IMPORTANT: Every type of cell must have a cell identifier so the TableView can deque it
    static let cellId = "MovieCell"
    
    // initializes a cell with a style and identifier
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
    }
    
    // required protocol when subclassing some UI classes
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Build our cell's views!
    func setupViews() {
        
        addSubview(poster)
        addSubview(title)
        addSubview(releaseDate)
        addSubview(overview)
        addSubview(rating)
        
        // Let's put the poster in the leftmost section of the cell
        poster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            poster.widthAnchor.constraint(equalToConstant: 150),
            poster.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            poster.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        poster.backgroundColor = .blue
        
        // The title will go to the right of the poster. Let's make it only take up the top half of the cell.
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 30)
        ])
        title.backgroundColor = .red
        
        // The director should go directly, left-aligned beneath the title.
        overview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overview.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 5),
            overview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            overview.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 3),
            overview.heightAnchor.constraint(equalToConstant: 100)
        ])
        overview.backgroundColor = .yellow
        
        // The release date is at the bottom left of the cell, to the right of the poster.
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            releaseDate.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 5),
            releaseDate.widthAnchor.constraint(equalToConstant: 100),
            releaseDate.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 3),
            releaseDate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
        ])
        releaseDate.backgroundColor = .green
        
        // The rating is the at the bottom right of the cell, right after the release date.
        rating.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rating.leadingAnchor.constraint(equalTo: releaseDate.trailingAnchor, constant: 10),
            rating.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            rating.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 3),
            rating.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
        ])
        rating.backgroundColor = .purple
    }
    
}
