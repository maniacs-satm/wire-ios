// 
// Wire
// Copyright (C) 2016 Wire Swiss GmbH
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
// 


import Foundation

class SettingsPropertySelectValueCellDescriptor: SettingsPropertyCellDescriptorType {
    static let cellType: SettingsTableCell.Type = SettingsValueCell.self
    let value: SettingsPropertyValue
    let title: String
    let identifier: String?
    
    typealias SelectActionType = (SettingsPropertySelectValueCellDescriptor) -> ()
    let selectAction: SelectActionType?
    let backgroundColor: UIColor?
    var visible: Bool = true

    weak var group: SettingsGroupCellDescriptorType?
    var settingsProperty: SettingsProperty
    
    init(settingsProperty: SettingsProperty, value: SettingsPropertyValue, title: String, identifier: String? = .None, selectAction: SelectActionType? = .None, backgroundColor: UIColor? = .None) {
        self.settingsProperty = settingsProperty
        self.value = value
        self.title = title
        self.identifier = identifier
        self.selectAction = selectAction
        self.backgroundColor = backgroundColor
    }
    
    func featureCell(cell: SettingsCellType) {
        cell.titleText = self.title
        cell.cellColor = self.backgroundColor
        if let valueCell = cell as? SettingsValueCell {
            valueCell.accessoryType = self.settingsProperty.propertyValue == self.value ? .Checkmark : .None
        }
    }
    
    func select(value: SettingsPropertyValue?) {
        
        self.settingsProperty << self.value
        if let selectAction = self.selectAction {
            selectAction(self)
        }
    }
}
