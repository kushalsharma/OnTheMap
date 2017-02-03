//
//  UserData.swift
//  OnTheMap
//
//  Created by Kushal Sharma on 03/02/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

struct User {
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
