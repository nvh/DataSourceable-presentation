import Foundation

public struct Movie {
    public var title: String
    public var year: Int
    var person: String
    
    var director: String
    
    init(_ title:String, _ year: Int, _ person: String, _ director: String) {
        self.title = title
        self.year = year
        self.person = person
        self.director = director
    }
}

public struct Actor {
    public var name: String
    public var movies: [Movie]
}

public struct JamesBond {
    
    public struct ActorName {
        static let SeanConnery = "Sean Connery"
        static let GeorgeLazenby = "George Lazenby"
        static let RogerMoore = "Roger Moore"
        static let TimothyDalton = "Timothy Dalton"
        static let PierceBrosnan = "Pierce Brosnan"
        static let DanielCraig = "Daniel Craig"
    }
    
    public static let actors: [Actor] = {
        var result: [Actor] = []
        for name in actorList {
            let actor = Actor(name: name, movies: movies.filter{name == $0.person})
            result.append(actor)
        }
        return result
    }()
    
    static let actorList: [String] = [ActorName.SeanConnery,ActorName.GeorgeLazenby,ActorName.RogerMoore,ActorName.TimothyDalton,ActorName.PierceBrosnan,ActorName.DanielCraig].reverse()
    
    public static let movies: [Movie] = [
        Movie("Dr. No",1962,ActorName.SeanConnery,"Terence Young"),
        Movie("From Russia with Love",1963,ActorName.SeanConnery,"Terence Young"),
        Movie("Goldfinger",1964,ActorName.SeanConnery,"Guy Hamilton"),
        Movie("Thunderball",1965,ActorName.SeanConnery,"Terence Young"),
        Movie("You Only Live Twice",1967,ActorName.SeanConnery,"Lewis Gilbert"),
        Movie("On Her Majesty's Secret Service",1969,ActorName.GeorgeLazenby,"Peter R. Hunt"),
        Movie("Diamonds Are Forever",1971,ActorName.SeanConnery,"Guy Hamilton"),
        Movie("Live and Let Die",1973,ActorName.RogerMoore,"Guy Hamilton"),
        Movie("The Man with the Golden Gun",1974,ActorName.RogerMoore,"Guy Hamilton"),
        Movie("The Spy Who Loved Me",1977,ActorName.RogerMoore,"Lewis Gilbert"),
        Movie("Moonraker",1979,ActorName.RogerMoore,"Lewis Gilbert"),
        Movie("For Your Eyes Only",1981,ActorName.RogerMoore,"John Glen"),
        Movie("Octopussy",1983,ActorName.RogerMoore,"John Glen"),
        Movie("A View to a Kill",1985,ActorName.RogerMoore,"John Glen"),
        Movie("The Living Daylights",1987,ActorName.TimothyDalton,"John Glen"),
        Movie("Licence to Kill",1989,ActorName.TimothyDalton,"John Glen"),
        Movie("GoldenEye",1995,ActorName.PierceBrosnan,"Martin Campbell"),
        Movie("Tomorrow Never Dies",1997,ActorName.PierceBrosnan,"Roger Spottiswoode"),
        Movie("The World Is Not Enough",1999,ActorName.PierceBrosnan,"Michael Apted"),
        Movie("Die Another Day",2002,ActorName.PierceBrosnan,"Lee Tamahori"),
        Movie("Casino Royale",2006,ActorName.DanielCraig,"Martin Campbell"),
        Movie("Quantum of Solace",2008,ActorName.DanielCraig,"Marc Forster"),
        Movie("Skyfall",2012,ActorName.DanielCraig,"Sam Mendes"),
        Movie("Spectre",2015,ActorName.DanielCraig,"Sam Mendes")
        ].reverse()
    
    public static let movieNames = movies.map{$0.title}
    public static let movieYears = movies.map{$0.year}
    public static let actorNames = actors.map{$0.name}
    
    static var moviesIndexedByActor: [String:[Movie]] = {
        var result: [String:[Movie]] = [:]
        for movie in movies {
            var actors = result[movie.person] ?? []
            actors.append(movie)
            result[movie.person] = actors
        }
        return result
    }()
    
    static let movieNamesByActor: [[String]] = {
        return actors.map{$0.movies.map{$0.title}}
    }()
}

extension Movie: CustomStringConvertible {
    public var description: String {
        return title
    }
}

public protocol SectionType: DataContaining {}

public struct Director: SectionType {
    public var name: String
    public var movies: [Movie]
    
    public var data: [Movie] {
        return movies
    }
    public var headerTitle: String? {
        return name
    }
}

public struct StarWars {
    public struct ActorName {
        static let HaydenChristensen = "Anakin"
        static let MarkHamill = "Luke"
        static let DaisyRidley = "Rey"
    }
    
    public static let directors: [Director] = {
        var result: [Director] = []
        for name in directorList {
            let director = Director(name: name, movies: movies.filter{name == $0.director})
            result.append(director)
        }
        return result
    }()
    
    static let directorList: [String] = ["George Lucas","Irvin Kershner","Richard Marquand","J.J. Abrams","Rian Johnson","Colin Trevorrow"]
    
    public static let movies: [Movie] = [
        Movie("The Phantom Menace",1999,ActorName.HaydenChristensen,"George Lucas"),
        Movie("Attack of the Clones",2002,ActorName.HaydenChristensen,"George Lucas"),
        Movie("Revenge of the Sith",2005,ActorName.HaydenChristensen,"George Lucas"),
        Movie("A New Hope",1977,ActorName.MarkHamill,"George Lucas"),
        Movie("The Empire Strikes Back",1980,ActorName.MarkHamill,"Irvin Kershner"),
        Movie("Return of the Jedi",1983,ActorName.MarkHamill,"Richard Marquand"),
        Movie("The Force Awakens",2015,ActorName.DaisyRidley,"J.J. Abrams"),
        Movie("Star Wars: Episode VIII",2017,ActorName.DaisyRidley,"Rian Johnson"),
        Movie("Star Wars: Episode IX",2019,ActorName.DaisyRidley,"Colin Trevorrow")
    ]
}