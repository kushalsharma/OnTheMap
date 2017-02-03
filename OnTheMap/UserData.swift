//
//  UserData.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 03/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

struct UserData {
    struct User {
        struct Email {
            let address: String
            let verificationCodeSent: Bool
            let verified: Bool
        }
        struct EmailPreferences {
            let masterOk: Bool
            let okCourse: Bool
            let okUserResearch: Bool
        }
        struct Guard {
            struct PermissionsItem {
                struct PrincipalRef {
                    let key: String
                    let ref: String
                }
                let behavior: String
                let derivation: [String]
                let principalRef: PrincipalRef
            }
            let allowedBehaviors: [String]
            let canEdit: Bool
            let permissions: [PermissionsItem]
            let subjectKind: String
        }
        struct MembershipsItem {
            struct GroupRef {
                let key: String
                let ref: String
            }
            typealias CreationTime = Void // TODO Specify type here. We couldn't infer it from json
            typealias ExpirationTime = Void // TODO Specify type here. We couldn't infer it from json
            let creationTime: CreationTime?
            let current: Bool
            let expirationTime: ExpirationTime?
            let groupRef: GroupRef
        }
        typealias AffiliateProfilesItem = Void // TODO Specify type here. We couldn't infer it from json
        typealias BadgesItem = Void // TODO Specify type here. We couldn't infer it from json
        typealias Bio = Void // TODO Specify type here. We couldn't infer it from json
        typealias CoachingData = Void // TODO Specify type here. We couldn't infer it from json
        typealias CohortKeysItem = Void // TODO Specify type here. We couldn't infer it from json
        typealias EnrollmentsItem = Void // TODO Specify type here. We couldn't infer it from json
        typealias ExternalAccountsItem = Void // TODO Specify type here. We couldn't infer it from json
        typealias ExternalServicePassword = Void // TODO Specify type here. We couldn't infer it from json
        typealias FacebookId = Void // TODO Specify type here. We couldn't infer it from json
        typealias GoogleId = Void // TODO Specify type here. We couldn't infer it from json
        typealias Image = Void // TODO Specify type here. We couldn't infer it from json
        typealias JabberId = Void // TODO Specify type here. We couldn't infer it from json
        typealias Languages = Void // TODO Specify type here. We couldn't infer it from json
        typealias LinkedinUrl = Void // TODO Specify type here. We couldn't infer it from json
        typealias Location = Void // TODO Specify type here. We couldn't infer it from json
        typealias MailingAddress = Void // TODO Specify type here. We couldn't infer it from json
        typealias Occupation = Void // TODO Specify type here. We couldn't infer it from json
        typealias Resume = Void // TODO Specify type here. We couldn't infer it from json
        typealias Signature = Void // TODO Specify type here. We couldn't infer it from json
        typealias SitePreferences = Void // TODO Specify type here. We couldn't infer it from json
        typealias SocialAccountsItem = Void // TODO Specify type here. We couldn't infer it from json
        typealias StripeCustomerId = Void // TODO Specify type here. We couldn't infer it from json
        typealias TagsItem = Void // TODO Specify type here. We couldn't infer it from json
        typealias Timezone = Void // TODO Specify type here. We couldn't infer it from json
        typealias WebsiteUrl = Void // TODO Specify type here. We couldn't infer it from json
        typealias ZendeskId = Void // TODO Specify type here. We couldn't infer it from json
        let `guard`: Guard
        let affiliateProfiles: [AffiliateProfilesItem]
        let badges: [BadgesItem]
        let bio: Bio?
        let coachingData: CoachingData?
        let cohortKeys: [CohortKeysItem]
        let email: Email
        let emailPreferences: EmailPreferences
        let employerSharing: Bool
        let enrollments: [EnrollmentsItem]
        let externalAccounts: [ExternalAccountsItem]
        let externalServicePassword: ExternalServicePassword?
        let facebookId: FacebookId?
        let firstName: String
        let googleId: GoogleId?
        let hasPassword: Bool
        let image: Image?
        let imageUrl: String
        let jabberId: JabberId?
        let key: String
        let languages: Languages?
        let lastName: String
        let linkedinUrl: LinkedinUrl?
        let location: Location?
        let mailingAddress: MailingAddress?
        let memberships: [MembershipsItem]
        let nickname: String
        let occupation: Occupation?
        let principals: [String]
        let registered: Bool
        let resume: Resume?
        let signature: Signature?
        let sitePreferences: SitePreferences?
        let socialAccounts: [SocialAccountsItem]
        let stripeCustomerId: StripeCustomerId?
        let tags: [TagsItem]
        let timezone: Timezone?
        let websiteUrl: WebsiteUrl?
        let zendeskId: ZendeskId?
    }
    let user: User
}

enum JsonParsingError: Error {
    case unsupportedTypeError
}

extension Array {
    init(jsonValue: Any?, map: (Any) throws -> Element) throws {
        guard let items = jsonValue as? [Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self = try items.map(map)
    }
}

extension Bool {
    init(jsonValue: Any?) throws {
        if let number = jsonValue as? NSNumber {
            guard String(cString: number.objCType) == String(cString: NSNumber(value: true).objCType) else {
                throw JsonParsingError.unsupportedTypeError
            }
            self = number.boolValue
        } else if let number = jsonValue as? Bool {
            self = number
        } else {
            throw JsonParsingError.unsupportedTypeError
        }
    }
}

extension String {
    init(jsonValue: Any?) throws {
        guard let string = jsonValue as? String else {
            throw JsonParsingError.unsupportedTypeError
        }
        self = string
    }
}

extension UserData {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.user = try UserData.User(jsonValue: dict["user"])
    }
}

extension UserData.User {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.image = nil
        self.socialAccounts = []
        self.lastName = try String(jsonValue: dict["last_name"])
        self.email = try UserData.User.Email(jsonValue: dict["email"])
        self.registered = try Bool(jsonValue: dict["_registered"])
        self.sitePreferences = nil
        self.externalAccounts = []
        self.nickname = try String(jsonValue: dict["nickname"])
        self.googleId = nil
        self.resume = nil
        self.firstName = try String(jsonValue: dict["first_name"])
        self.cohortKeys = []
        self.bio = nil
        self.timezone = nil
        self.imageUrl = try String(jsonValue: dict["_image_url"])
        self.badges = []
        self.mailingAddress = nil
        self.principals = try Array(jsonValue: dict["_principals"]) { try String(jsonValue: $0) }
        self.affiliateProfiles = []
        self.signature = nil
        self.`guard` = try UserData.User.Guard(jsonValue: dict["guard"])
        self.jabberId = nil
        self.zendeskId = nil
        self.employerSharing = try Bool(jsonValue: dict["employer_sharing"])
        self.emailPreferences = try UserData.User.EmailPreferences(jsonValue: dict["email_preferences"])
        self.memberships = try Array(jsonValue: dict["_memberships"]) { try UserData.User.MembershipsItem(jsonValue: $0) }
        self.externalServicePassword = nil
        self.languages = nil
        self.location = nil
        self.stripeCustomerId = nil
        self.linkedinUrl = nil
        self.occupation = nil
        self.key = try String(jsonValue: dict["key"])
        self.hasPassword = try Bool(jsonValue: dict["_has_password"])
        self.facebookId = nil
        self.tags = []
        self.websiteUrl = nil
        self.enrollments = []
        self.coachingData = nil
    }
}

extension UserData.User.Email {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.verified = try Bool(jsonValue: dict["_verified"])
        self.verificationCodeSent = try Bool(jsonValue: dict["_verification_code_sent"])
        self.address = try String(jsonValue: dict["address"])
    }
}

extension UserData.User.EmailPreferences {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.okUserResearch = try Bool(jsonValue: dict["ok_user_research"])
        self.okCourse = try Bool(jsonValue: dict["ok_course"])
        self.masterOk = try Bool(jsonValue: dict["master_ok"])
    }
}

extension UserData.User.Guard {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.permissions = try Array(jsonValue: dict["permissions"]) { try UserData.User.Guard.PermissionsItem(jsonValue: $0) }
        self.canEdit = try Bool(jsonValue: dict["can_edit"])
        self.allowedBehaviors = try Array(jsonValue: dict["allowed_behaviors"]) { try String(jsonValue: $0) }
        self.subjectKind = try String(jsonValue: dict["subject_kind"])
    }
}

extension UserData.User.Guard.PermissionsItem {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.behavior = try String(jsonValue: dict["behavior"])
        self.principalRef = try UserData.User.Guard.PermissionsItem.PrincipalRef(jsonValue: dict["principal_ref"])
        self.derivation = try Array(jsonValue: dict["derivation"]) { try String(jsonValue: $0) }
    }
}

extension UserData.User.Guard.PermissionsItem.PrincipalRef {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.key = try String(jsonValue: dict["key"])
        self.ref = try String(jsonValue: dict["ref"])
    }
}

extension UserData.User.MembershipsItem {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.creationTime = nil
        self.expirationTime = nil
        self.current = try Bool(jsonValue: dict["current"])
        self.groupRef = try UserData.User.MembershipsItem.GroupRef(jsonValue: dict["group_ref"])
    }
}

extension UserData.User.MembershipsItem.GroupRef {
    init(jsonValue: Any?) throws {
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.key = try String(jsonValue: dict["key"])
        self.ref = try String(jsonValue: dict["ref"])
    }
}

func parseUser(jsonValue: Any?) throws -> UserData {
    return try UserData(jsonValue: jsonValue)
}
