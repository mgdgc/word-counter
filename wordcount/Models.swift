//
//  Models.swift
//  wordcount
//
//  Created by Peter Choi on 02/01/2019.
//  Copyright © 2019 RiDsoft. All rights reserved.
//

import Foundation

enum SpaceType: String {
    case both
    case onlySpace
    case onlyEnter
    case neither
    
    public static func getSpaceTypeByString(type: String) -> SpaceType {
        switch type {
        case SpaceType.both.rawValue:
            return .both
        case SpaceType.onlySpace.rawValue:
            return .onlySpace
        case SpaceType.onlyEnter.rawValue:
            return .onlyEnter
        case SpaceType.neither.rawValue:
            return .neither
        default:
            return .both
        }
    }
}

enum DisplayOption: String {
    case bytes
    case characters
    case words
    case symbols
    case spaces
    
    public static func getDisplayOptionByString(type: String) -> DisplayOption {
        switch type {
        case DisplayOption.bytes.rawValue:
            return .bytes
        case DisplayOption.characters.rawValue:
            return .characters
        case DisplayOption.words.rawValue:
            return .words
        case DisplayOption.symbols.rawValue:
            return .symbols
        case DisplayOption.spaces.rawValue:
            return .spaces
        default:
            return .words
        }
    }
}

class Document {
    var id: Int
    var content: String?
    
    init (id: Int, content: String?) {
        self.id = id
        self.content = content
    }
    
    convenience init(id: Int?, content: String?) {
        var id = id
        if (id == nil) {
            id = Int(Date().timeIntervalSince1970 * 1000)
        }
        self.init(id: id!, content: content)
    }
}

enum OptionType: String {
    case SpaceType
    case DisplayOptions
    case InExcludeSymbols
    case SymbolsToInclude
    case SymbolsToExclude
}

class OptionObject {
    var option: OptionType
    var value: String
    init(option: OptionType, value: String) {
        self.option = option
        self.value = value
    }
}

class Options {
    var spaceType: SpaceType
    var displayOptions: [DisplayOption]
    var symbolOption: Bool
    var includedSymbols: [String]
    var excludedSymbols: [String]
    init(spaceType: SpaceType = .both, displayOptions: [DisplayOption] = [.words, .characters], symbolOption: Bool = false, includedSymbols: [String] = [], excludedSymbols: [String] = []) {
        self.spaceType = spaceType
        self.displayOptions = displayOptions
        self.symbolOption = symbolOption
        self.includedSymbols = includedSymbols
        self.excludedSymbols = excludedSymbols
    }
}
