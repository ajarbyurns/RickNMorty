import Foundation

protocol CharacterFilterViewModelDelegate : AnyObject {
    func filtersUpdated()
}

class CharacterFilterViewModel : NSObject {
    
    let rows : [[String]] = [["Alive", "Dead", "Unknown"], ["Alien", "Animal", "Mythological Creature", "Human"], ["Male", "Female", "Genderless", "Unknown"]]
    let sections = ["Status", "Species", "Gender"]
    
    let header = "Filter"
    let buttonText = "Apply"
    
    let headerId = "FilterSectionHeader"
    
    var selected : [String?] = []
    var states : [[Bool]] = []
    
    weak var delegate : CharacterFilterViewModelDelegate? = nil
    
    override init(){
        super.init()
        for i in sections.indices {
            selected.append(nil)
            states.append([])
            for _ in rows[i].indices {
                states[i].append(false)
            }
        }
    }
    
    func selectAt(_ section : Int, _ row : Int){
        selected[section] = rows[section][row]
        for i in states[section].indices {
            states[section][i] = false
            states[section][row] = true
            delegate?.filtersUpdated()
        }
    }
    
    func deSelectAt(_ section : Int, _ row : Int){
        selected[section] = nil
        states[section][row] = false
        delegate?.filtersUpdated()
    }
    
}
