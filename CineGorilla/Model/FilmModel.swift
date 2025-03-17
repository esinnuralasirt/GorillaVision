import Foundation
import UIKit

class MovieItem: Codable {
    let name: String
    let genre: String
    let image: String
    let qrCode: String
    let year: Int
    let time: String
    
    var isFavorite: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "favorite_\(name)")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "favorite_\(name)")
        }
    }
    
    var isPushed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "push_\(name)")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "push_\(name)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, genre, image, qrCode, year, time
    }
    
    init(name: String, genre: String, image: String, qrCode: String, year: Int, time: String) {
        self.name = name
        self.genre = genre
        self.image = image
        self.qrCode = qrCode
        self.year = year
        self.time = time
    }
}

class FilmModel {
    static let shared = FilmModel()
    
    let films: [MovieItem] = [
        MovieItem(name: "Dune: Part Two", genre: "Sci-Fi, Adventure", image: "img1", qrCode: "qrcode-1", year: 2024, time: "155 minutes"),
        MovieItem(name: "The Substance", genre: "Drama, Horror", image: "img2", qrCode: "qrcode-2", year: 2024, time: "110 minutes"),
        MovieItem(name: "Anora", genre: "Drama", image: "img3", qrCode: "qrcode-3", year: 2024, time: "120 minutes"),
        MovieItem(name: "Deadpool & Wolverine", genre: "Action, Adventure", image: "img4", qrCode: "qrcode-4", year: 2024, time: "130 minutes"),
        MovieItem(name: "Furiosa: A Mad Max Saga", genre: "Action, Adventure", image: "img5", qrCode: "qrcode-5", year: 2024, time: "140 minutes"),
        MovieItem(name: "The Wild Robot", genre: "Action, Adventure", image: "img6", qrCode: "qrcode-6", year: 2024, time: "95 minutes"),
        MovieItem(name: "Alien: Romulus", genre: "Horror, Sci-Fi", image: "img7", qrCode: "qrcode-7", year: 2024, time: "115 minutes"),
        MovieItem(name: "Saltburn", genre: "Psychological Thriller", image: "img8", qrCode: "qrcode-8", year: 2024, time: "130 minutes"),
        MovieItem(name: "The Konotop Witch", genre: "Supernatural Thriller", image: "img9", qrCode: "qrcode-9", year: 2024, time: "105 minutes"),
        MovieItem(name: "We, Our Pets, and War", genre: "Documentary", image: "img10", qrCode: "qrcode-10", year: 2024, time: "90 minutes")
    ]
    
    private init() {}
} 