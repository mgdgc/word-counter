//
//  OptionsManager.swift
//  wordcount
//
//  Created by Peter Choi on 01/01/2019.
//  Copyright © 2019 RiDsoft. All rights reserved.
//

import Foundation

class OptionsManager {
    
    public static let appGroupName = "group.WordCounter"
    // This seperator is an Korean character anyway.
    public static let seperator: Character = "ㅣ"
    
    public func getBoolean(option: OptionObject) -> Bool {
        let availables: [OptionType] = [.InExcludeSymbols]
        return availables.contains(option.option) ? option.value.lowercased() == "true" : false
    }
    
    public func getStrings(option: OptionObject) -> [String]? {
        let availables: [OptionType] = [.DisplayOptions, .SymbolsToInclude, .SymbolsToExclude]
        if availables.contains(option.option) {
            let splits = option.value.split(separator: OptionsManager.seperator)
            var values: [String] = Array()
            for s in splits {
                values.append(String(s))
            }
            return values
        } else {
            return nil
        }
    }
    
    public func setOptions(options: [OptionObject]) -> Bool {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return false }
        
        for option in options {
            ud.set(option.value, forKey: option.option.rawValue)
        }
        
        ud.synchronize()
        
        return true
    }
    
    public func getOptions() -> Options? {
        guard let ud = UserDefaults(suiteName: DataManager.appGroupName) else { return nil }
        
        let options = Options()
        
        // Option for Space Type
        options.spaceType = SpaceType.getSpaceTypeByString(type: ud.string(forKey: OptionType.SpaceType.rawValue) ?? SpaceType.both.rawValue)
        
        // Option for Display Options
        var dpOptions: [DisplayOption] = Array()
        let dpOp = OptionObject(option: .DisplayOptions, value: ud.string(forKey: OptionType.DisplayOptions.rawValue) ?? DisplayOption.words.rawValue + "|" + DisplayOption.characters.rawValue)
        if let dpOps = getStrings(option: dpOp) {
            for dp in dpOps {
                dpOptions.append(DisplayOption.getDisplayOptionByString(type: dp))
            }
        } else {
            dpOptions = [DisplayOption.words, DisplayOption.characters]
        }
        options.displayOptions = dpOptions
        
        // Option for Whether WC uses Symbol Count or not
        let symbol = OptionObject(option: .InExcludeSymbols, value: ud.string(forKey: OptionType.InExcludeSymbols.rawValue) ?? "false")
        options.symbolOption = getBoolean(option: symbol)
        
        // Option for the symbols that will be counted
        var includes: [String] = Array()
        let includeOption = OptionObject(option: .SymbolsToInclude, value: ud.string(forKey: OptionType.SymbolsToInclude.rawValue) ?? "")
        for i in getStrings(option: includeOption) ?? [] {
            includes.append(i)
        }
        
        options.includedSymbols = includes
        
        // Option for the symbols that will be not counted
        var excludes: [String] = Array()
        let excludeOption = OptionObject(option: .SymbolsToExclude, value: ud.string(forKey: OptionType.SymbolsToExclude.rawValue) ?? "")
        for i in getStrings(option: excludeOption) ?? [] {
            excludes.append(i)
        }
        
        options.excludedSymbols = excludes
        
        return options
    }
    
    
}
