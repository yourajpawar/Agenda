//
//  AgendaData.swift
//  Agenda
//
//  Created by Pawar, Youraj on 11/17/16.
//  Copyright © 2016 Pawar, Youraj. All rights reserved.
//

import Foundation


struct Agenda: AgendaProtocol, Equatable, Hashable {
    
    
    
     var title: String
    
     var subTitle: String
    
     var location: String
    
    var timeAgenda: String
    
    var typeAgenda: AGENDATYPE
    
    var duration: String
    
    var  agendaID: Int
    
    static var randomAgendaDictionary:[String:[Agenda]] = [:]
    
    var typeAgendaValue : String {
        
        return typeAgenda.rawValue
    }
    
    var builtInAgendas : Set<Agenda> {
        
        return  Agenda.agendaArray()
    }
    
    
    var hashValue: Int {
        
        return agendaID
    }
    // let imageUrl : URL
    
    //description function is in ThingsProtocol
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: Agenda, rhs: Agenda) -> Bool {
        
        return lhs.agendaID == rhs.agendaID
    }
    
//    static func random()->Agenda {
//        
//        let randomInt = Int(arc4random_uniform(9))
//        var array = Array(namesCategory.keys)
//        let name = array[randomInt]
//        var array2 = Array(namesCategory.values)
//        let category = array2[randomInt]
//        
//        return Agenda()
//        
//        
//    }
    
    static func createStubbedDataFrom(_ selectedDate:Date) -> [String:[Agenda]] {
        
        var agendaData:[String:[Agenda]] = [:]
        
        var todayDate = selectedDate
        
        let title = moment(date: selectedDate as NSDate).format(dateFormat: "MMMM d, yyyy")
        
        //Vallue is Array of agendas sorted by time
        agendaData[title] = getRandomAgendas()
        
        //pre days
        for _ in 0...5 {
            
            
            let preDate = Agenda.previousDayDateFrom(currentDate: todayDate)
            let title = moment(date: preDate as NSDate).format(dateFormat: "MMMM d, yyyy")
            agendaData[title] = getRandomAgendas()
            todayDate = preDate
            
        }
        
        todayDate = selectedDate
        
        //next days
        for _ in 0...5 {
            
            
            let nextDate = Agenda.nextDayDateFrom(currentDate: todayDate)
            let title = moment(date: nextDate as NSDate).format(dateFormat: "MMMM d, yyyy")
            agendaData[title] = getRandomAgendas()
            todayDate = nextDate
            
        }
        
        todayDate = selectedDate
        
        Agenda.randomAgendaDictionary = agendaData
        
        return agendaData
    }
    
    static func getRandomAgendas()->[Agenda] {
        
        let randomInt = Int(arc4random_uniform(7) + 3) // Create minimum 3 elements
        
        var randomAgendas:[Agenda] = [Agenda]()
        
        let setAgenda = agendaArray()
        
        var count = 0
        
        for agenda in setAgenda {
            
            count = count + 1
            randomAgendas.append(agenda)
            
            if count == randomInt {
                break
            }
        }
        
        //Sort by time 
        randomAgendas = randomAgendas.sorted(by: { agenda1, agenda2 in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let date1 = dateFormatter.date(from: agenda1.timeAgenda)
            let date2 = dateFormatter.date(from: agenda2.timeAgenda)
            
            return date1! < date2!
        })

        
        return randomAgendas
        
    }
    
    static func agendaArray()->Set<Agenda> {
        
        var agendaSet = Set<Agenda>()
        
        let agenda1 = Agenda(title:"Daily Scrum", subTitle:"Project C", location:"Conf:1234",timeAgenda:"8:00 AM", typeAgenda: AGENDATYPE.INDOOR, duration:"1h",agendaID: 1)
        let agenda2 = Agenda(title:"Designer Meetup", subTitle:"Project C", location:"Conf:4567",timeAgenda:"10:00 AM", typeAgenda: AGENDATYPE.INDOOR, duration:"1h",agendaID: 2)
        let agenda3 = Agenda(title:"Businees Prototype", subTitle:"Project D", location:"Conf:3456",timeAgenda:"2:00 PM", typeAgenda: AGENDATYPE.INDOOR, duration:"2h",agendaID: 3)
        let agenda4 = Agenda(title:"Devs Meetup", subTitle:"Project D", location:"Conf:1234",timeAgenda:"4:00 PM", typeAgenda: AGENDATYPE.INDOOR, duration:"1h",agendaID: 4)
        let agenda5 = Agenda(title:"Kids Pickup", subTitle:"KUMON", location:"SFO",timeAgenda:"6:00 PM", typeAgenda: AGENDATYPE.OUTDOOR, duration:"1h",agendaID: 5)
        let agenda6 = Agenda(title:"Joe Swimming", subTitle:"Class 10", location:"SFO",timeAgenda:"9:00 AM", typeAgenda: AGENDATYPE.OUTDOOR, duration:"1h", agendaID: 6)
        let agenda7 = Agenda(title:"Birthday Party", subTitle:"Joe Birthday", location:"TownHall",timeAgenda:"5:00 PM", typeAgenda: AGENDATYPE.OUTDOOR, duration:"1h", agendaID: 7)
        let agenda8 = Agenda(title:"Dinner @ Michelle House", subTitle:"Thanksgiving", location:"SFO",timeAgenda:"7:00 PM", typeAgenda: AGENDATYPE.OUTDOOR, duration:"1h", agendaID: 8)
        let agenda9 = Agenda(title:"Drinks @ Bob House", subTitle:"Thanksgiving", location:"SFO",timeAgenda:"9:00 PM", typeAgenda: AGENDATYPE.OUTDOOR, duration:"1h", agendaID: 9)
        let agenda10 = Agenda(title:"Bob Meetup", subTitle:"Security Cryptography", location:"Conf:7879",timeAgenda:"1:00 PM", typeAgenda: AGENDATYPE.INDOOR, duration:"1h", agendaID: 10)
        let agenda11 = Agenda(title:"Marie Curie Birthday", subTitle:"Nobel Prize", location:"Museum",timeAgenda:"3:00 PM", typeAgenda: AGENDATYPE.OUTDOOR, duration:"1h", agendaID: 11)
        let agenda12 = Agenda(title:"Shanon Lecture", subTitle:"IOT", location:"Conf:4321",timeAgenda:"12:00 PM", typeAgenda: AGENDATYPE.INDOOR, duration:"1h", agendaID: 12)
        
        agendaSet.insert(agenda1)
        agendaSet.insert(agenda2)
        agendaSet.insert(agenda3)
        agendaSet.insert(agenda4)
        agendaSet.insert(agenda5)
        agendaSet.insert(agenda6)
        agendaSet.insert(agenda7)
        agendaSet.insert(agenda8)
        agendaSet.insert(agenda9)
        agendaSet.insert(agenda10)
        agendaSet.insert(agenda11)
        agendaSet.insert(agenda12)
        
        return agendaSet
        
    }
    
    static func previousDayDateFrom(currentDate: Date)->Date {
        
        let calendar = Calendar.current
        let previousDay = calendar.date(byAdding: .day, value: -1, to:currentDate)
        
        return previousDay!
    }
    
    static func nextDayDateFrom(currentDate:Date)-> Date {
        
        let calendar = Calendar.current
        let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate)

        
        return nextDay!
    }

    
}
