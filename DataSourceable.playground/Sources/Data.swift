import Foundation

public struct JamesBond {
    public struct Movie {
        public var title: String
        public var year: Int
        var actor: ActorName
        public var actorName: String {
            return actor.rawValue
        }
        
        var director: String
        
        init(_ title:String, _ year: Int, _ actor: ActorName, _ director: String) {
            self.title = title
            self.year = year
            self.actor = actor
            self.director = director
        }
    }
    
    public enum ActorName: String {
        case SeanConnery = "Sean Connery"
        case GeorgeLazenby = "George Lazenby"
        case RogerMoore = "Roger Moore"
        case TimothyDalton = "Timothy Dalton"
        case PierceBrosnan = "Pierce Brosnan"
        case DanielCraig = "Daniel Craig"
    }
    
    public struct Actor {
        var actorName: ActorName
        public var movies: [Movie]
        public var name: String {
            return actorName.rawValue
        }
    }
    
    public static let actors: [Actor] = {
        var result: [Actor] = []
        for name in actorList {
            let actor = Actor(actorName: name, movies: movies.filter{name == $0.actor})
            result.append(actor)
        }
        return result
    }()
    
    static let actorList: [ActorName] = [.SeanConnery,.GeorgeLazenby,.RogerMoore,.TimothyDalton,.PierceBrosnan,.DanielCraig].reverse()

    public static let movies: [Movie] = [
        Movie("Dr. No",1962,.SeanConnery,"Terence Young"),
        Movie("From Russia with Love",1963,.SeanConnery,"Terence Young"),
        Movie("Goldfinger",1964,.SeanConnery,"Guy Hamilton"),
        Movie("Thunderball",1965,.SeanConnery,"Terence Young"),
        Movie("You Only Live Twice",1967,.SeanConnery,"Lewis Gilbert"),
        Movie("On Her Majesty's Secret Service",1969,.GeorgeLazenby,"Peter R. Hunt"),
        Movie("Diamonds Are Forever",1971,.SeanConnery,"Guy Hamilton"),
        Movie("Live and Let Die",1973,.RogerMoore,"Guy Hamilton"),
        Movie("The Man with the Golden Gun",1974,.RogerMoore,"Guy Hamilton"),
        Movie("The Spy Who Loved Me",1977,.RogerMoore,"Lewis Gilbert"),
        Movie("Moonraker",1979,.RogerMoore,"Lewis Gilbert"),
        Movie("For Your Eyes Only",1981,.RogerMoore,"John Glen"),
        Movie("Octopussy",1983,.RogerMoore,"John Glen"),
        Movie("A View to a Kill",1985,.RogerMoore,"John Glen"),
        Movie("The Living Daylights",1987,.TimothyDalton,"John Glen"),
        Movie("Licence to Kill",1989,.TimothyDalton,"John Glen"),
        Movie("GoldenEye",1995,.PierceBrosnan,"Martin Campbell"),
        Movie("Tomorrow Never Dies",1997,.PierceBrosnan,"Roger Spottiswoode"),
        Movie("The World Is Not Enough",1999,.PierceBrosnan,"Michael Apted"),
        Movie("Die Another Day",2002,.PierceBrosnan,"Lee Tamahori"),
        Movie("Casino Royale",2006,.DanielCraig,"Martin Campbell"),
        Movie("Quantum of Solace",2008,.DanielCraig,"Marc Forster"),
        Movie("Skyfall",2012,.DanielCraig,"Sam Mendes"),
        Movie("Spectre",2015,.DanielCraig,"Sam Mendes")
    ].reverse()

    public static let movieNames = movies.map{$0.title}
    public static let movieYears = movies.map{$0.year}
    public static let actorNames = actors.map{$0.name}

    static var moviesIndexedByActor: [ActorName:[Movie]] = {
        var result: [ActorName:[Movie]] = [:]
        for movie in movies {
            var actors = result[movie.actor] ?? []
            actors.append(movie)
            result[movie.actor] = actors
        }
        return result
    }()

    static let movieNamesByActor: [[String]] = {
        return actors.map{$0.movies.map{$0.title}}
    }()

    private static func actorName(atIndex index: Int) -> String {
        return actorList[index].rawValue
    }
}

extension JamesBond.Movie: CustomStringConvertible {
    public var description: String {
        return title
    }
}