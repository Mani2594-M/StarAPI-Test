//
//  Launch.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import Foundation

struct Launch: Codable, Identifiable {
    let id = UUID()
    let missionName: String?
    let launchDate: String?
    let rocket: Rocket?
    let launchSite: LaunchSite?
    let links: Images?
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchDate = "launch_date_utc"
        case rocket
        case launchSite = "launch_site"
        case links
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        missionName = try values.decode(String.self, forKey: .missionName)
        launchDate = try values.decode(String.self, forKey: .launchDate)
        rocket = try values.decode(Rocket.self, forKey: .rocket)
        launchSite = try values.decode(LaunchSite.self, forKey: .launchSite)
        links = try values.decode(Images.self, forKey: .links)
    }
    
    init(missionName: String, launchDate: String, rocket: Rocket?, launchSite: LaunchSite?, links: Images?, details: String, launchYear: String) {
        self.missionName = missionName
        self.launchDate = launchDate
        self.rocket = rocket
        self.launchSite = launchSite
        self.links = links
    }
    
    
    static func testLaunch1() -> Launch {
        return Launch(missionName: "Test Mission 1", launchDate: "Test Date 1", rocket: Rocket(rocket_id: "ID 1", rocket_name: "Test Name 1", rocket_type: "Type 1"), launchSite: LaunchSite(site_name: "Test Site 1"), links: Images(mission_patch: "Test Patch 1", youtube_id: "Youtube 1"), details: "Details 1", launchYear: "2022")
    }
    
    static func testLaunch2() -> Launch {
        return Launch(missionName: "Test Mission 2", launchDate: "Test Date 2", rocket: Rocket(rocket_id: "ID 2", rocket_name: "Test Name 2", rocket_type: "Type 2"), launchSite: LaunchSite(site_name: "Test Site 2"), links: Images(mission_patch: "Test Patch 2", youtube_id: "Youtube 2"), details: "Details 2", launchYear: "2023")
    }
}
