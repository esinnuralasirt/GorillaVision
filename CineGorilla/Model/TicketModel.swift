import Foundation

class TicketModel: Codable {
    let movie: MovieItem
    let date: String
    let places: Int
    let points: Int
    
    private enum CodingKeys: String, CodingKey {
        case movie, date, places, points
    }
    
    var movieTime: String {
        return movie.time
    }
    
    var qrCode: String {
        return movie.qrCode
    }
    
    init(movie: MovieItem, date: String, places: Int, points: Int) {
        self.movie = movie
        self.date = date
        self.places = places
        self.points = points
    }
    
    static func saveTicket(_ ticket: TicketModel) {
        var tickets = getTickets()
        tickets.append(ticket)
        if let encoded = try? JSONEncoder().encode(tickets) {
            UserDefaults.standard.set(encoded, forKey: "savedTickets")
        }
    }
    
    static func getTickets() -> [TicketModel] {
        if let data = UserDefaults.standard.data(forKey: "savedTickets"),
           let tickets = try? JSONDecoder().decode([TicketModel].self, from: data) {
            return tickets
        }
        return []
    }
} 