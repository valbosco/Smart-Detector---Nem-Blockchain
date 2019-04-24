//
//  SettingsSection.swift
//  Smart Detector
//
//  Created by Nnamdi Ugwuoke on 3/26/19.
//  Copyright © 2019 Manipal University Dubai. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}
enum SettingsSection: Int, CaseIterable, CustomStringConvertible{
    case Social
    case Communications
    var description: String {
        switch self {
        case .Social:
            return "Social"
        case .Communications:
            return "Communications"
        }
    }
}
enum SocialOptions: Int, CaseIterable, SectionType {
    case editProfile
    case logout
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .editProfile: return "Edit Profile"
        case .logout: return "Log Out"
        }
    }
}

enum CommunicationOptions: Int, CaseIterable, SectionType {
    case notifications
    case email
    case reportCrashes
    
    var containsSwitch: Bool {
        switch self {
        case .notifications: return true
        case .email: return true
        case .reportCrashes: return true
        }
    }
    
    var description: String {
        switch self {
        case .notifications: return "Notifications"
        case .email: return "Email"
        case .reportCrashes: return "Report Crashes"
        }
    }
}
