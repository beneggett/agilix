[![Gem Version](https://badge.fury.io/rb/agilix.svg)](https://badge.fury.io/rb/agilix)
[![Build Status](https://travis-ci.com/beneggett/agilix.svg?branch=master)](https://travis-ci.com/beneggett/agilix)
[![Coverage Status](https://coveralls.io/repos/github/beneggett/agilix/badge.svg?branch=master)](https://coveralls.io/github/beneggett/agilix?branch=master)
# Agilix Buzz

Fully Implements the Agilix Buzz API in Ruby


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agilix'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install agilix

Be sure to define your Agilix Buzz credentials by setting up environment variables in your application appropriately. Refer to the .env.sample file for details.
```
AGILIX_BUZZ_USERNAME = 'my-username'
AGILIX_BUZZ_PASSWORD = 'my-password'
```

Optionally, if your Buzz instance runs on your own url, you can define it as well:

```
AGILIX_BUZZ_URL = 'https://api.mycustomdomain.com'
```

## Usage

There are many primary APIs that are wrapped. Below you will see basic examples of how to use them. For more information about what optional query parameters are available, please consult the [Agilix Buzz API Docs](https://api.agilixbuzz.com/)

### Auth

You need to authenticate to use the api. Set the credentials in Environment variables as seen above. If you've done that, you can set and refernce the api object by:
```
api = Agilix::Buzz::Api.new
```

Otherwise, you can pass `:username`, `:password`, and `:domain` into the initializer
```
api = Agilix::Buzz::Api.new username: 'my-username', password: 'my-password', domain: 'my-domain'
```
The authentication API gives you back a token that can be used within a 15 minute window. This library will manage the need to fetch a new token or `extend_session` by setting the token & token expiration in the initialized api object.

### Passing arguments

All APIs have defined required arguments and optional arguments, and an argument cleaner will prevent the calls from being made if conditions are not met. Additionally it will strip out any unsupported api params that are not defined in the required or optional fields.

Below are instructions for basic invocation of the api methods. For additional information about each API method, please consult the Agilix documentation, linked in each method's name.

### Domains

#### [CreateDomains](https://api.agilixbuzz.com/docs/#!/Command/CreateDomains)
```
api.create_domains [{name: "BuzzTest1", userspace: 'buzz-test-fc-1', parentid: '57025'}]
```
#### [DeleteDomain](https://api.agilixbuzz.com/docs/#!/Command/DeleteDomain)
```
api.delete_domain domainid: '57027'
```
#### [GetDomain2](https://api.agilixbuzz.com/docs/#!/Command/GetDomain2)
This is aliased to `get_domain`
```
api.get_domain domainid: '57025'
```
#### [GetDomainContent](https://api.agilixbuzz.com/docs/#!/Command/GetDomainContent)
```
api.get_domain_content domainid: '57025'
```
#### [GetDomainEnrollmentMetrics](https://api.agilixbuzz.com/docs/#!/Command/GetDomainEnrollmentMetrics)
```
api.get_domain_enrollment_metrics domainid: '57025'
```
#### [GetDomainParentList](https://api.agilixbuzz.com/docs/#!/Command/GetDomainParentList)
```
api.get_domain_parent_list domainid: '57025'
```
#### [GetDomainSettings](https://api.agilixbuzz.com/docs/#!/Command/GetDomainSettings)
```
api.get_domain_settings domainid: '57025', path: "AgilixBuzzSettings.xml"
```
#### [GetDomainStats](https://api.agilixbuzz.com/docs/#!/Command/GetDomainStats)
```
api.get_domain_stats domainid: '57025', options: "users|courses"
```
#### [ListDomains](https://api.agilixbuzz.com/docs/#!/Command/ListDomains)
```
api.list_domains domainid: '57025'
```
#### [RestoreDomain](https://api.agilixbuzz.com/docs/#!/Command/RestoreDomain)
```
api.restore_domain domainid: '57027'
```
#### [UpdateDomains](https://api.agilixbuzz.com/docs/#!/Command/UpdateDomains)
```
api.update_domains [{ domainid: "57027", name: "BuzzTestUpdated1", userspace: 'buzz-test-fc-1', parentid: '57025'}]
```

### Reports

`get_runnable_report_list` and `run_report` are probably the only ones you would use.

#### [GetReportInfo](https://api.agilixbuzz.com/docs/#!/Command/GetReportInfo)
```
api.get_report_info reportid: 127
```
#### [GetReportList](https://api.agilixbuzz.com/docs/#!/Command/GetReportList)
```
api.get_report_list domainid: 1
```
#### [GetRunnableReportList](https://api.agilixbuzz.com/docs/#!/Command/GetRunnableReportList)
```
api.get_runnable_report_list domainid: 57025
```
#### [RunReport](https://api.agilixbuzz.com/docs/#!/Command/RunReport)
```
api.run_report reportid: 127, entityid: 57025, format: 'json'
```

## Users

#### [CreateUsers2](https://api.agilixbuzz.com/docs/#!/Command/CreateUsers2)
This is aliased to `create_users`
```
api.create_users( [{
  domainid: '57025',
  username: "BuzzUserTest1",
  email: 'buzzusertest1@agilix.com',
  password: 'testpassword1234',
  firstname: 'Buzz',
  lastname: "Man",
  passwordquestion: "Who's your best friend?",
  passwordanswer: "Me"
  }] )
```

#### [DeleteUsers](https://api.agilixbuzz.com/docs/#!/Command/DeleteUsers)
```
api.delete_users [userid: '57181']
```

#### [GetActiveUserCount](https://api.agilixbuzz.com/docs/#!/Command/GetActiveUserCount)
```
api.get_active_user_count domainid: '57025'
api.get_active_user_count domainid: '5', includedescendantdomains: true, bymonth:true, startdate: '2018-01-01', enddate: '2019-03-01'
```

#### [GetDomainActivity](https://api.agilixbuzz.com/docs/#!/Command/GetDomainActivity)
```
api.get_domain_activity domainid: '57025'
```

#### [GetProfilePicture](https://api.agilixbuzz.com/docs/#!/Command/GetProfilePicture)
Returns base 64 encoded picture
```
api.get_profile_picture entityid: 57026
```
The api will return 404 not found if they don't have one, unless you supply it with a default profile pic, then it will return that
```
api.get_profile_picture entityid: 57025, default: "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm"
```

#### [GetUser2](https://api.agilixbuzz.com/docs/#!/Command/GetUser2)
This is aliased to `get_user`
```
api.get_user userid: 57026
```

#### [GetUserActivity](https://api.agilixbuzz.com/docs/#!/Command/GetUserActivity)
```
api.get_user_activity userid: 57026
```

#### [GetUserActivityStream](https://api.agilixbuzz.com/docs/#!/Command/GetUserActivityStream)
```
api.get_user_activity_stream userid: 57026
```

#### [ListUsers](https://api.agilixbuzz.com/docs/#!/Command/ListUsers)
```
api.list_users domainid: 57025
```

#### [RestoreUser](https://api.agilixbuzz.com/docs/#!/Command/RestoreUser)
```
api.restore_user userid: 57026
```

#### [UpdateUsers](https://api.agilixbuzz.com/docs/#!/Command/UpdateUsers)
```
api.update_users  [{ userid: '57026', username: "BuzzUserTestUpdated1", email: 'buzzusertest1@agilix.com',firstname: 'Buzz', lastname: "ManUpdated"}]
```

---

# Second Priority

## Authentication

- [ ] [ExtendSession](https://api.agilixbuzz.com/docs/#!/Command/ExtendSession)
- [ ] [GetKey](https://api.agilixbuzz.com/docs/#!/Command/GetKey)
- [ ] [ForcePasswordChange](https://api.agilixbuzz.com/docs/#!/Command/ForcePasswordChange)
- [ ] [GetPasswordLoginAttemptHistory](https://api.agilixbuzz.com/docs/#!/Command/GetPasswordLoginAttemptHistory)
- [ ] [GetPasswordPolicy](https://api.agilixbuzz.com/docs/#!/Command/GetPasswordPolicy)
- [ ] [GetPasswordQuestion](https://api.agilixbuzz.com/docs/#!/Command/GetPasswordQuestion)
- [ ] [Login2](https://api.agilixbuzz.com/docs/#!/Command/Login2)
- [ ] [Logout](https://api.agilixbuzz.com/docs/#!/Command/Logout)
- [ ] [Proxy](https://api.agilixbuzz.com/docs/#!/Command/Proxy)
- [ ] [PutKey](https://api.agilixbuzz.com/docs/#!/Command/PutKey)
- [ ] [ResetLockout](https://api.agilixbuzz.com/docs/#!/Command/ResetLockout)
- [ ] [ResetPassword](https://api.agilixbuzz.com/docs/#!/Command/ResetPassword)
- [ ] [Unproxy](https://api.agilixbuzz.com/docs/#!/Command/Unproxy)
- [ ] [UpdatePassword](https://api.agilixbuzz.com/docs/#!/Command/UpdatePassword)
- [ ] [UpdatePasswordQuestionAnswer](https://api.agilixbuzz.com/docs/#!/Command/UpdatePasswordQuestionAnswer)

## Courses

- [ ] [CopyCourses](https://api.agilixbuzz.com/docs/#!/Command/CopyCourses)
- [ ] [CreateCourses](https://api.agilixbuzz.com/docs/#!/Command/CreateCourses)
- [ ] [CreateDemoCourse](https://api.agilixbuzz.com/docs/#!/Command/CreateDemoCourse)
- [ ] [DeactivateCourse](https://api.agilixbuzz.com/docs/#!/Command/DeactivateCourse)
- [ ] [DeleteCourses](https://api.agilixbuzz.com/docs/#!/Command/DeleteCourses)
- [ ] [GetCourse2](https://api.agilixbuzz.com/docs/#!/Command/GetCourse2)
- [ ] [GetCourseHistory](https://api.agilixbuzz.com/docs/#!/Command/GetCourseHistory)
- [ ] [ListCourses](https://api.agilixbuzz.com/docs/#!/Command/ListCourses)
- [ ] [MergeCourses](https://api.agilixbuzz.com/docs/#!/Command/MergeCourses)
- [ ] [RestoreCourse](https://api.agilixbuzz.com/docs/#!/Command/RestoreCourse)
- [ ] [UpdateCourses](https://api.agilixbuzz.com/docs/#!/Command/UpdateCourses)

## Enrollments

- [ ] [CreateEnrollments](https://api.agilixbuzz.com/docs/#!/Command/CreateEnrollments)
- [ ] [DeleteEnrollments](https://api.agilixbuzz.com/docs/#!/Command/DeleteEnrollments)
- [ ] [GetEnrollment3](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollment3)
- [ ] [GetEnrollmentActivity](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollmentActivity)
- [ ] [GetEnrollmentGradebook2](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollmentGradebook2)
- [ ] [GetEnrollmentGroupList](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollmentGroupList)
- [ ] [GetEnrollmentMetricsReport](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollmentMetricsReport)
- [ ] [ListEnrollments](https://api.agilixbuzz.com/docs/#!/Command/ListEnrollments)
- [ ] [ListEnrollmentsByTeacher](https://api.agilixbuzz.com/docs/#!/Command/ListEnrollmentsByTeacher)
- [ ] [ListEntityEnrollments](https://api.agilixbuzz.com/docs/#!/Command/ListEntityEnrollments)
- [ ] [ListUserEnrollments](https://api.agilixbuzz.com/docs/#!/Command/ListUserEnrollments)
- [ ] [PutSelfAssessment](https://api.agilixbuzz.com/docs/#!/Command/PutSelfAssessment)
- [ ] [RestoreEnrollment](https://api.agilixbuzz.com/docs/#!/Command/RestoreEnrollment)
- [ ] [UpdateEnrollments](https://api.agilixbuzz.com/docs/#!/Command/UpdateEnrollments)

## Rights

- [ ] [CreateRole](https://api.agilixbuzz.com/docs/#!/Command/CreateRole)
- [ ] [DeleteRole](https://api.agilixbuzz.com/docs/#!/Command/DeleteRole)
- [ ] [DeleteSubscriptions](https://api.agilixbuzz.com/docs/#!/Command/DeleteSubscriptions)
- [ ] [GetActorRights](https://api.agilixbuzz.com/docs/#!/Command/GetActorRights)
- [ ] [GetEffectiveRights](https://api.agilixbuzz.com/docs/#!/Command/GetEffectiveRights)
- [ ] [GetEffectiveSubscriptionList](https://api.agilixbuzz.com/docs/#!/Command/GetEffectiveSubscriptionList)
- [ ] [GetEntityRights](https://api.agilixbuzz.com/docs/#!/Command/GetEntityRights)
- [ ] [GetEntitySubscriptionList](https://api.agilixbuzz.com/docs/#!/Command/GetEntitySubscriptionList)
- [ ] [GetPersonas](https://api.agilixbuzz.com/docs/#!/Command/GetPersonas)
- [ ] [GetRights](https://api.agilixbuzz.com/docs/#!/Command/GetRights)
- [ ] [GetRightsList](https://api.agilixbuzz.com/docs/#!/Command/GetRightsList)
- [ ] [GetRole](https://api.agilixbuzz.com/docs/#!/Command/GetRole)
- [ ] [GetSubscriptionList](https://api.agilixbuzz.com/docs/#!/Command/GetSubscriptionList)
- [ ] [ListRoles](https://api.agilixbuzz.com/docs/#!/Command/ListRoles)
- [ ] [RestoreRole](https://api.agilixbuzz.com/docs/#!/Command/RestoreRole)
- [ ] [UpdateRights](https://api.agilixbuzz.com/docs/#!/Command/UpdateRights)
- [ ] [UpdateRole](https://api.agilixbuzz.com/docs/#!/Command/UpdateRole)
- [ ] [UpdateSubscriptions](https://api.agilixbuzz.com/docs/#!/Command/UpdateSubscriptions)

---

# Third Priority

## Assessments

- [ ] [DeleteQuestions](https://api.agilixbuzz.com/docs/#!/Command/DeleteQuestions)
- [ ] [GetAttempt](https://api.agilixbuzz.com/docs/#!/Command/GetAttempt)
- [ ] [GetAttemptReview](https://api.agilixbuzz.com/docs/#!/Command/GetAttemptReview)
- [ ] [GetExam](https://api.agilixbuzz.com/docs/#!/Command/GetExam)
- [ ] [GetNextQuestion](https://api.agilixbuzz.com/docs/#!/Command/GetNextQuestion)
- [ ] [GetQuestion](https://api.agilixbuzz.com/docs/#!/Command/GetQuestion)
- [ ] [GetQuestionScores](https://api.agilixbuzz.com/docs/#!/Command/GetQuestionScores)
- [ ] [GetQuestionStats](https://api.agilixbuzz.com/docs/#!/Command/GetQuestionStats)
- [ ] [GetSubmissionState](https://api.agilixbuzz.com/docs/#!/Command/GetSubmissionState)
- [ ] [ListQuestions](https://api.agilixbuzz.com/docs/#!/Command/ListQuestions)
- [ ] [ListRestorableQuestions](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableQuestions)
- [ ] [PrepareOfflineAttempt](https://api.agilixbuzz.com/docs/#!/Command/PrepareOfflineAttempt)
- [ ] [PutQuestions](https://api.agilixbuzz.com/docs/#!/Command/PutQuestions)
- [ ] [RestoreQuestions](https://api.agilixbuzz.com/docs/#!/Command/RestoreQuestions)
- [ ] [SaveAttemptAnswers](https://api.agilixbuzz.com/docs/#!/Command/SaveAttemptAnswers)
- [ ] [SubmitAttemptAnswers](https://api.agilixbuzz.com/docs/#!/Command/SubmitAttemptAnswers)
- [ ] [SubmitOfflineAttempt](https://api.agilixbuzz.com/docs/#!/Command/SubmitOfflineAttempt)

## General

- [ ] [Echo](https://api.agilixbuzz.com/docs/#!/Command/Echo)
- [ ] [GetCommandList](https://api.agilixbuzz.com/docs/#!/Command/GetCommandList)
- [ ] [GetEntityType](https://api.agilixbuzz.com/docs/#!/Command/GetEntityType)
- [ ] [GetStatus](https://api.agilixbuzz.com/docs/#!/Command/GetStatus)
- [ ] [GetUploadLimits](https://api.agilixbuzz.com/docs/#!/Command/GetUploadLimits)
- [ ] [SendMail](https://api.agilixbuzz.com/docs/#!/Command/SendMail)

## Manifests and Items

- [ ] [AssignItem](https://api.agilixbuzz.com/docs/#!/Command/AssignItem)
- [ ] [CopyItems](https://api.agilixbuzz.com/docs/#!/Command/CopyItems)
- [ ] [DeleteItems](https://api.agilixbuzz.com/docs/#!/Command/DeleteItems)
- [ ] [FindPersonalizedEntities](https://api.agilixbuzz.com/docs/#!/Command/FindPersonalizedEntities)
- [ ] [GetCourseContent](https://api.agilixbuzz.com/docs/#!/Command/GetCourseContent)
- [ ] [GetItem](https://api.agilixbuzz.com/docs/#!/Command/GetItem)
- [ ] [GetItemInfo](https://api.agilixbuzz.com/docs/#!/Command/GetItemInfo)
- [ ] [GetItemLinks](https://api.agilixbuzz.com/docs/#!/Command/GetItemLinks)
- [ ] [GetItemList](https://api.agilixbuzz.com/docs/#!/Command/GetItemList)
- [ ] [GetManifest](https://api.agilixbuzz.com/docs/#!/Command/GetManifest)
- [ ] [GetManifestData](https://api.agilixbuzz.com/docs/#!/Command/GetManifestData)
- [ ] [GetManifestInfo](https://api.agilixbuzz.com/docs/#!/Command/GetManifestInfo)
- [ ] [GetManifestItem](https://api.agilixbuzz.com/docs/#!/Command/GetManifestItem)
- [ ] [ListAssignableItems](https://api.agilixbuzz.com/docs/#!/Command/ListAssignableItems)
- [ ] [ListRestorableItems](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableItems)
- [ ] [NavigateItem](https://api.agilixbuzz.com/docs/#!/Command/NavigateItem)
- [ ] [PutItems](https://api.agilixbuzz.com/docs/#!/Command/PutItems)
- [ ] [RestoreItems](https://api.agilixbuzz.com/docs/#!/Command/RestoreItems)
- [ ] [Search2](https://api.agilixbuzz.com/docs/#!/Command/Search2)
- [ ] [UnassignItem](https://api.agilixbuzz.com/docs/#!/Command/UnassignItem)
- [ ] [UpdateManifestData](https://api.agilixbuzz.com/docs/#!/Command/UpdateManifestData)

## Ratings

- [ ] [GetItemRating](https://api.agilixbuzz.com/docs/#!/Command/GetItemRating)
- [ ] [GetItemRatingSummary](https://api.agilixbuzz.com/docs/#!/Command/GetItemRatingSummary)
- [ ] [PutItemRating](https://api.agilixbuzz.com/docs/#!/Command/PutItemRating)

## Resources

- [ ] [CopyResources](https://api.agilixbuzz.com/docs/#!/Command/CopyResources)
- [ ] [DeleteDocuments](https://api.agilixbuzz.com/docs/#!/Command/DeleteDocuments)
- [ ] [DeleteResources](https://api.agilixbuzz.com/docs/#!/Command/DeleteResources)
- [ ] [GetDocument](https://api.agilixbuzz.com/docs/#!/Command/GetDocument)
- [ ] [GetDocumentInfo](https://api.agilixbuzz.com/docs/#!/Command/GetDocumentInfo)
- [ ] [GetEntityResourceId](https://api.agilixbuzz.com/docs/#!/Command/GetEntityResourceId)
- [ ] [GetResource](https://api.agilixbuzz.com/docs/#!/Command/GetResource)
- [ ] [GetResourceInfo2](https://api.agilixbuzz.com/docs/#!/Command/GetResourceInfo2)
- [ ] [GetResourceList2](https://api.agilixbuzz.com/docs/#!/Command/GetResourceList2)
- [ ] [ListRestorableDocuments](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableDocuments)
- [ ] [ListRestorableResources](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableResources)
- [ ] [PutResource](https://api.agilixbuzz.com/docs/#!/Command/PutResource)
- [ ] [PutResourceFolders](https://api.agilixbuzz.com/docs/#!/Command/PutResourceFolders)
- [ ] [RestoreDocuments](https://api.agilixbuzz.com/docs/#!/Command/RestoreDocuments)
- [ ] [RestoreResources](https://api.agilixbuzz.com/docs/#!/Command/RestoreResources)

---

# Not Prioritized

## Announcements

- [ ] [DeleteAnnouncements](https://api.agilixbuzz.com/docs/#!/Command/DeleteAnnouncements)
- [ ] [GetAnnouncement](https://api.agilixbuzz.com/docs/#!/Command/GetAnnouncement)
- [ ] [GetAnnouncementInfo](https://api.agilixbuzz.com/docs/#!/Command/GetAnnouncementInfo)
- [ ] [GetAnnouncementList](https://api.agilixbuzz.com/docs/#!/Command/GetAnnouncementList)
- [ ] [GetUserAnnouncementList](https://api.agilixbuzz.com/docs/#!/Command/GetUserAnnouncementList)
- [ ] [ListRestorableAnnouncements](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableAnnouncements)
- [ ] [PutAnnouncement](https://api.agilixbuzz.com/docs/#!/Command/PutAnnouncement)
- [ ] [RestoreAnnouncements](https://api.agilixbuzz.com/docs/#!/Command/RestoreAnnouncements)
- [ ] [UpdateAnnouncementViewed](https://api.agilixbuzz.com/docs/#!/Command/UpdateAnnouncementViewed)

## Badges

- [ ] [CreateBadge](https://api.agilixbuzz.com/docs/#!/Command/CreateBadge)
- [ ] [DeleteBadge](https://api.agilixbuzz.com/docs/#!/Command/DeleteBadge)
- [ ] [GetBadge](https://api.agilixbuzz.com/docs/#!/Command/GetBadge)
- [ ] [GetBadgeAssertion](https://api.agilixbuzz.com/docs/#!/Command/GetBadgeAssertion)
- [ ] [GetBadgeList](https://api.agilixbuzz.com/docs/#!/Command/GetBadgeList)

## Blogs

- [ ] [DeleteBlogs](https://api.agilixbuzz.com/docs/#!/Command/DeleteBlogs)
- [ ] [GetBlog](https://api.agilixbuzz.com/docs/#!/Command/GetBlog)
- [ ] [GetBlogList](https://api.agilixbuzz.com/docs/#!/Command/GetBlogList)
- [ ] [GetBlogSummary](https://api.agilixbuzz.com/docs/#!/Command/GetBlogSummary)
- [ ] [GetRecentPosts](https://api.agilixbuzz.com/docs/#!/Command/GetRecentPosts)
- [ ] [PutBlog](https://api.agilixbuzz.com/docs/#!/Command/PutBlog)
- [ ] [UpdateBlogViewed](https://api.agilixbuzz.com/docs/#!/Command/UpdateBlogViewed)

## Command Tokens

- [ ] [CreateCommandTokens](https://api.agilixbuzz.com/docs/#!/Command/CreateCommandTokens)
- [ ] [GetCommandToken](https://api.agilixbuzz.com/docs/#!/Command/GetCommandToken)
- [ ] [GetCommandTokenInfo](https://api.agilixbuzz.com/docs/#!/Command/GetCommandTokenInfo)
- [ ] [DeleteCommandTokens](https://api.agilixbuzz.com/docs/#!/Command/DeleteCommandTokens)
- [ ] [UpdateCommandTokens](https://api.agilixbuzz.com/docs/#!/Command/UpdateCommandTokens)
- [ ] [ListCommandTokens](https://api.agilixbuzz.com/docs/#!/Command/ListCommandTokens)
- [ ] [RedeemCommandToken](https://api.agilixbuzz.com/docs/#!/Command/RedeemCommandToken)

## Conversion

- [ ] [ExportData](https://api.agilixbuzz.com/docs/#!/Command/ExportData)
- [ ] [GetConvertedData](https://api.agilixbuzz.com/docs/#!/Command/GetConvertedData)
- [ ] [ImportData](https://api.agilixbuzz.com/docs/#!/Command/ImportData)

## Discussion Boards

- [ ] [DeleteMessage](https://api.agilixbuzz.com/docs/#!/Command/DeleteMessage)
- [ ] [DeleteMessagePart](https://api.agilixbuzz.com/docs/#!/Command/DeleteMessagePart)
- [ ] [GetMessage](https://api.agilixbuzz.com/docs/#!/Command/GetMessage)
- [ ] [GetMessageList](https://api.agilixbuzz.com/docs/#!/Command/GetMessageList)
- [ ] [ListRestorableMessages](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableMessages)
- [ ] [PutMessage](https://api.agilixbuzz.com/docs/#!/Command/PutMessage)
- [ ] [PutMessagePart](https://api.agilixbuzz.com/docs/#!/Command/PutMessagePart)
- [ ] [RestoreMessages](https://api.agilixbuzz.com/docs/#!/Command/RestoreMessages)
- [ ] [SubmitMessage](https://api.agilixbuzz.com/docs/#!/Command/SubmitMessage)
- [ ] [UpdateMessageViewed](https://api.agilixbuzz.com/docs/#!/Command/UpdateMessageViewed)

## Groups

- [ ] [AddGroupMembers](https://api.agilixbuzz.com/docs/#!/Command/AddGroupMembers)
- [ ] [CreateGroups](https://api.agilixbuzz.com/docs/#!/Command/CreateGroups)
- [ ] [DeleteGroups](https://api.agilixbuzz.com/docs/#!/Command/DeleteGroups)
- [ ] [GetGroup](https://api.agilixbuzz.com/docs/#!/Command/GetGroup)
- [ ] [GetGroupEnrollmentList](https://api.agilixbuzz.com/docs/#!/Command/GetGroupEnrollmentList)
- [ ] [GetGroupList](https://api.agilixbuzz.com/docs/#!/Command/GetGroupList)
- [ ] [RemoveGroupMembers](https://api.agilixbuzz.com/docs/#!/Command/RemoveGroupMembers)
- [ ] [UpdateGroups](https://api.agilixbuzz.com/docs/#!/Command/UpdateGroups)

## Gradebook

- [ ] [CalculateEnrollmentScenario](https://api.agilixbuzz.com/docs/#!/Command/CalculateEnrollmentScenario)
- [ ] [GetCalendar](https://api.agilixbuzz.com/docs/#!/Command/GetCalendar)
- [ ] [GetCalendarItems](https://api.agilixbuzz.com/docs/#!/Command/GetCalendarItems)
- [ ] [GetCalendarToken](https://api.agilixbuzz.com/docs/#!/Command/GetCalendarToken)
- [ ] [GetCertificates](https://api.agilixbuzz.com/docs/#!/Command/GetCertificates)
- [ ] [GetDueSoonList](https://api.agilixbuzz.com/docs/#!/Command/GetDueSoonList)
- [ ] [GetEntityGradebook2](https://api.agilixbuzz.com/docs/#!/Command/GetEntityGradebook2)
- [ ] [GetEntityGradebook3](https://api.agilixbuzz.com/docs/#!/Command/GetEntityGradebook3)
- [ ] [GetEntityGradebookSummary](https://api.agilixbuzz.com/docs/#!/Command/GetEntityGradebookSummary)
- [ ] [GetEntityWork2](https://api.agilixbuzz.com/docs/#!/Command/GetEntityWork2)
- [ ] [GetGrade](https://api.agilixbuzz.com/docs/#!/Command/GetGrade)
- [ ] [GetGradebookList](https://api.agilixbuzz.com/docs/#!/Command/GetGradebookList)
- [ ] [GetGradebookSummary](https://api.agilixbuzz.com/docs/#!/Command/GetGradebookSummary)
- [ ] [GetGradebookWeights](https://api.agilixbuzz.com/docs/#!/Command/GetGradebookWeights)
- [ ] [GetGradeHistory](https://api.agilixbuzz.com/docs/#!/Command/GetGradeHistory)
- [ ] [GetItemAnalysis2](https://api.agilixbuzz.com/docs/#!/Command/GetItemAnalysis2)
- [ ] [GetItemReport](https://api.agilixbuzz.com/docs/#!/Command/GetItemReport)
- [ ] [GetRubricMastery](https://api.agilixbuzz.com/docs/#!/Command/GetRubricMastery)
- [ ] [GetRubricStats](https://api.agilixbuzz.com/docs/#!/Command/GetRubricStats)
- [ ] [GetUserGradebook2](https://api.agilixbuzz.com/docs/#!/Command/GetUserGradebook2)

## Objectives

- [ ] [CreateObjectiveSets](https://api.agilixbuzz.com/docs/#!/Command/CreateObjectiveSets)
- [ ] [DeleteObjectiveMaps](https://api.agilixbuzz.com/docs/#!/Command/DeleteObjectiveMaps)
- [ ] [DeleteObjectives](https://api.agilixbuzz.com/docs/#!/Command/DeleteObjectives)
- [ ] [DeleteObjectiveSets](https://api.agilixbuzz.com/docs/#!/Command/DeleteObjectiveSets)
- [ ] [GetMasteryDetail](https://api.agilixbuzz.com/docs/#!/Command/GetMasteryDetail)
- [ ] [GetMasterySummary](https://api.agilixbuzz.com/docs/#!/Command/GetMasterySummary)
- [ ] [GetObjectiveList](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveList)
- [ ] [GetObjectiveMapList](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveMapList)
- [ ] [GetObjectiveMastery](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveMastery)
- [ ] [GetObjectiveSet2](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveSet2)
- [ ] [GetObjectiveSubjectList](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveSubjectList)
- [ ] [ListObjectiveSets](https://api.agilixbuzz.com/docs/#!/Command/ListObjectiveSets)
- [ ] [PutObjectiveMaps](https://api.agilixbuzz.com/docs/#!/Command/PutObjectiveMaps)
- [ ] [PutObjectives](https://api.agilixbuzz.com/docs/#!/Command/PutObjectives)
- [ ] [RestoreObjectiveSet](https://api.agilixbuzz.com/docs/#!/Command/RestoreObjectiveSet)
- [ ] [UpdateObjectiveSets](https://api.agilixbuzz.com/docs/#!/Command/UpdateObjectiveSets)

## Peer Grading

- [ ] [GetPeerResponse](https://api.agilixbuzz.com/docs/#!/Command/GetPeerResponse)
- [ ] [GetPeerResponseInfo](https://api.agilixbuzz.com/docs/#!/Command/GetPeerResponseInfo)
- [ ] [GetPeerResponseList](https://api.agilixbuzz.com/docs/#!/Command/GetPeerResponseList)
- [ ] [GetPeerReviewList](https://api.agilixbuzz.com/docs/#!/Command/GetPeerReviewList)
- [ ] [PutPeerResponse](https://api.agilixbuzz.com/docs/#!/Command/PutPeerResponse)

## Signals

- [ ] [CreateSignal](https://api.agilixbuzz.com/docs/#!/Command/CreateSignal)
- [ ] [GetLastSignalId](https://api.agilixbuzz.com/docs/#!/Command/GetLastSignalId)
- [ ] [GetSignalList2](https://api.agilixbuzz.com/docs/#!/Command/GetSignalList2)

## Submissions

- [ ] [DeleteWorkInProgress](https://api.agilixbuzz.com/docs/#!/Command/DeleteWorkInProgress)
- [ ] [GenerateSubmission](https://api.agilixbuzz.com/docs/#!/Command/GenerateSubmission)
- [ ] [GetScoData](https://api.agilixbuzz.com/docs/#!/Command/GetScoData)
- [ ] [GetStudentSubmission](https://api.agilixbuzz.com/docs/#!/Command/GetStudentSubmission)
- [ ] [GetStudentSubmissionHistory](https://api.agilixbuzz.com/docs/#!/Command/GetStudentSubmissionHistory)
- [ ] [GetStudentSubmissionInfo](https://api.agilixbuzz.com/docs/#!/Command/GetStudentSubmissionInfo)
- [ ] [GetTeacherResponse](https://api.agilixbuzz.com/docs/#!/Command/GetTeacherResponse)
- [ ] [GetTeacherResponseInfo](https://api.agilixbuzz.com/docs/#!/Command/GetTeacherResponseInfo)
- [ ] [GetWorkInProgress2](https://api.agilixbuzz.com/docs/#!/Command/GetWorkInProgress2)
- [ ] [PutItemActivity](https://api.agilixbuzz.com/docs/#!/Command/PutItemActivity)
- [ ] [PutScoData](https://api.agilixbuzz.com/docs/#!/Command/PutScoData)
- [ ] [PutStudentSubmission](https://api.agilixbuzz.com/docs/#!/Command/PutStudentSubmission)
- [ ] [PutTeacherResponse](https://api.agilixbuzz.com/docs/#!/Command/PutTeacherResponse)
- [ ] [PutTeacherResponses](https://api.agilixbuzz.com/docs/#!/Command/PutTeacherResponses)
- [ ] [PutWorkInProgress](https://api.agilixbuzz.com/docs/#!/Command/PutWorkInProgress)
- [ ] [SubmitWorkInProgress](https://api.agilixbuzz.com/docs/#!/Command/SubmitWorkInProgress)

## Wikis

- [ ] [CopyWikiPages](https://api.agilixbuzz.com/docs/#!/Command/CopyWikiPages)
- [ ] [DeleteWikiPages](https://api.agilixbuzz.com/docs/#!/Command/DeleteWikiPages)
- [ ] [GetWikiPage](https://api.agilixbuzz.com/docs/#!/Command/GetWikiPage)
- [ ] [GetWikiPageList](https://api.agilixbuzz.com/docs/#!/Command/GetWikiPageList)
- [ ] [ListRestorableWikiPages](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableWikiPages)
- [ ] [PutWikiPage](https://api.agilixbuzz.com/docs/#!/Command/PutWikiPage)
- [ ] [RestoreWikiPages](https://api.agilixbuzz.com/docs/#!/Command/RestoreWikiPages)
- [ ] [UpdateWikiPageViewed](https://api.agilixbuzz.com/docs/#!/Command/UpdateWikiPageViewed)


## Features

Implemented APIs from [Agilix Buzz API Docs](https://api.agilixbuzz.com/)

(Last updated on March 7, 2019)

| API |  Methods & Docs | Implemented? | Priority |
| --- | --- | --- | --- |
| Announcements | [DeleteAnnouncements](https://api.agilixbuzz.com/docs/#!/Command/DeleteAnnouncements), [GetAnnouncement](https://api.agilixbuzz.com/docs/#!/Command/GetAnnouncement), [GetAnnouncementInfo](https://api.agilixbuzz.com/docs/#!/Command/GetAnnouncementInfo), [GetAnnouncementList](https://api.agilixbuzz.com/docs/#!/Command/GetAnnouncementList), [GetUserAnnouncementList](https://api.agilixbuzz.com/docs/#!/Command/GetUserAnnouncementList), [ListRestorableAnnouncements](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableAnnouncements), [PutAnnouncement](https://api.agilixbuzz.com/docs/#!/Command/PutAnnouncement), [RestoreAnnouncements](https://api.agilixbuzz.com/docs/#!/Command/RestoreAnnouncements), [UpdateAnnouncementViewed](https://api.agilixbuzz.com/docs/#!/Command/UpdateAnnouncementViewed)  | ❌ | 🔼 |
| Assessments | [DeleteQuestions](https://api.agilixbuzz.com/docs/#!/Command/DeleteQuestions), [GetAttempt](https://api.agilixbuzz.com/docs/#!/Command/GetAttempt), [GetAttemptReview](https://api.agilixbuzz.com/docs/#!/Command/GetAttemptReview), [GetExam](https://api.agilixbuzz.com/docs/#!/Command/GetExam), [GetNextQuestion](https://api.agilixbuzz.com/docs/#!/Command/GetNextQuestion), [GetQuestion](https://api.agilixbuzz.com/docs/#!/Command/GetQuestion), [GetQuestionScores](https://api.agilixbuzz.com/docs/#!/Command/GetQuestionScores), [GetQuestionStats](https://api.agilixbuzz.com/docs/#!/Command/GetQuestionStats), [GetSubmissionState](https://api.agilixbuzz.com/docs/#!/Command/GetSubmissionState), [ListQuestions](https://api.agilixbuzz.com/docs/#!/Command/ListQuestions), [ListRestorableQuestions](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableQuestions), [PrepareOfflineAttempt](https://api.agilixbuzz.com/docs/#!/Command/PrepareOfflineAttempt), [PutQuestions](https://api.agilixbuzz.com/docs/#!/Command/PutQuestions), [RestoreQuestions](https://api.agilixbuzz.com/docs/#!/Command/RestoreQuestions), [SaveAttemptAnswers](https://api.agilixbuzz.com/docs/#!/Command/SaveAttemptAnswers), [SubmitAttemptAnswers](https://api.agilixbuzz.com/docs/#!/Command/SubmitAttemptAnswers), [SubmitOfflineAttempt](https://api.agilixbuzz.com/docs/#!/Command/SubmitOfflineAttempt) | ❌ | ⏺ |
| Authentication | [ExtendSession](https://api.agilixbuzz.com/docs/#!/Command/ExtendSession), [GetKey](https://api.agilixbuzz.com/docs/#!/Command/GetKey), [ForcePasswordChange](https://api.agilixbuzz.com/docs/#!/Command/ForcePasswordChange), [GetPasswordLoginAttemptHistory](https://api.agilixbuzz.com/docs/#!/Command/GetPasswordLoginAttemptHistory), [GetPasswordPolicy](https://api.agilixbuzz.com/docs/#!/Command/GetPasswordPolicy), [GetPasswordQuestion](https://api.agilixbuzz.com/docs/#!/Command/GetPasswordQuestion), [Login2](https://api.agilixbuzz.com/docs/#!/Command/Login2), [Logout](https://api.agilixbuzz.com/docs/#!/Command/Logout), [Proxy](https://api.agilixbuzz.com/docs/#!/Command/Proxy), [PutKey](https://api.agilixbuzz.com/docs/#!/Command/PutKey), [ResetLockout](https://api.agilixbuzz.com/docs/#!/Command/ResetLockout), [ResetPassword](https://api.agilixbuzz.com/docs/#!/Command/ResetPassword), [Unproxy](https://api.agilixbuzz.com/docs/#!/Command/Unproxy), [UpdatePassword](https://api.agilixbuzz.com/docs/#!/Command/UpdatePassword), [UpdatePasswordQuestionAnswer](https://api.agilixbuzz.com/docs/#!/Command/UpdatePasswordQuestionAnswer) | ❌ | 🔼 |
| Badges | [CreateBadge](https://api.agilixbuzz.com/docs/#!/Command/CreateBadge), [DeleteBadge](https://api.agilixbuzz.com/docs/#!/Command/DeleteBadge), [GetBadge](https://api.agilixbuzz.com/docs/#!/Command/GetBadge), [GetBadgeAssertion](https://api.agilixbuzz.com/docs/#!/Command/GetBadgeAssertion), [GetBadgeList](https://api.agilixbuzz.com/docs/#!/Command/GetBadgeList) | ❌ | 🔽 |
| Blogs | [DeleteBlogs](https://api.agilixbuzz.com/docs/#!/Command/DeleteBlogs), [GetBlog](https://api.agilixbuzz.com/docs/#!/Command/GetBlog), [GetBlogList](https://api.agilixbuzz.com/docs/#!/Command/GetBlogList), [GetBlogSummary](https://api.agilixbuzz.com/docs/#!/Command/GetBlogSummary), [GetRecentPosts](https://api.agilixbuzz.com/docs/#!/Command/GetRecentPosts), [PutBlog](https://api.agilixbuzz.com/docs/#!/Command/PutBlog), [UpdateBlogViewed](https://api.agilixbuzz.com/docs/#!/Command/UpdateBlogViewed) | ❌ | ⏬ |
| Command Tokens | [CreateCommandTokens](https://api.agilixbuzz.com/docs/#!/Command/CreateCommandTokens), [GetCommandToken](https://api.agilixbuzz.com/docs/#!/Command/GetCommandToken), [GetCommandTokenInfo](https://api.agilixbuzz.com/docs/#!/Command/GetCommandTokenInfo), [DeleteCommandTokens](https://api.agilixbuzz.com/docs/#!/Command/DeleteCommandTokens), [UpdateCommandTokens](https://api.agilixbuzz.com/docs/#!/Command/UpdateCommandTokens), [ListCommandTokens](https://api.agilixbuzz.com/docs/#!/Command/ListCommandTokens), [RedeemCommandToken](https://api.agilixbuzz.com/docs/#!/Command/RedeemCommandToken) | ❌ | ⏬
| Conversion | [ExportData](https://api.agilixbuzz.com/docs/#!/Command/ExportData), [GetConvertedData](https://api.agilixbuzz.com/docs/#!/Command/GetConvertedData), [ImportData](https://api.agilixbuzz.com/docs/#!/Command/ImportData) | ❌ | ⏬ |
| Courses | [CopyCourses](https://api.agilixbuzz.com/docs/#!/Command/CopyCourses), [CreateCourses](https://api.agilixbuzz.com/docs/#!/Command/CreateCourses), [CreateDemoCourse](https://api.agilixbuzz.com/docs/#!/Command/CreateDemoCourse), [DeactivateCourse](https://api.agilixbuzz.com/docs/#!/Command/DeactivateCourse), [DeleteCourses](https://api.agilixbuzz.com/docs/#!/Command/DeleteCourses), [GetCourse2](https://api.agilixbuzz.com/docs/#!/Command/GetCourse2), [GetCourseHistory](https://api.agilixbuzz.com/docs/#!/Command/GetCourseHistory), [ListCourses](https://api.agilixbuzz.com/docs/#!/Command/ListCourses), [MergeCourses](https://api.agilixbuzz.com/docs/#!/Command/MergeCourses), [RestoreCourse](https://api.agilixbuzz.com/docs/#!/Command/RestoreCourse), [UpdateCourses](https://api.agilixbuzz.com/docs/#!/Command/UpdateCourses) | ❌ | 🔼 |
| Discussion Boards | [DeleteMessage](https://api.agilixbuzz.com/docs/#!/Command/DeleteMessage), [DeleteMessagePart](https://api.agilixbuzz.com/docs/#!/Command/DeleteMessagePart), [GetMessage](https://api.agilixbuzz.com/docs/#!/Command/GetMessage), [GetMessageList](https://api.agilixbuzz.com/docs/#!/Command/GetMessageList), [ListRestorableMessages](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableMessages), [PutMessage](https://api.agilixbuzz.com/docs/#!/Command/PutMessage), [PutMessagePart](https://api.agilixbuzz.com/docs/#!/Command/PutMessagePart), [RestoreMessages](https://api.agilixbuzz.com/docs/#!/Command/RestoreMessages), [SubmitMessage](https://api.agilixbuzz.com/docs/#!/Command/SubmitMessage), [UpdateMessageViewed](https://api.agilixbuzz.com/docs/#!/Command/UpdateMessageViewed) | ❌ | 🔽
| Domains | [CreateDomains](https://api.agilixbuzz.com/docs/#!/Command/CreateDomains), [DeleteDomain](https://api.agilixbuzz.com/docs/#!/Command/DeleteDomain), [GetDomain2](https://api.agilixbuzz.com/docs/#!/Command/GetDomain2), [GetDomainContent](https://api.agilixbuzz.com/docs/#!/Command/GetDomainContent), [GetDomainEnrollmentMetrics](https://api.agilixbuzz.com/docs/#!/Command/GetDomainEnrollmentMetrics), [GetDomainParentList](https://api.agilixbuzz.com/docs/#!/Command/GetDomainParentList), [GetDomainSettings](https://api.agilixbuzz.com/docs/#!/Command/GetDomainSettings), [GetDomainStats](https://api.agilixbuzz.com/docs/#!/Command/GetDomainStats), [ListDomains](https://api.agilixbuzz.com/docs/#!/Command/ListDomains), [RestoreDomain](https://api.agilixbuzz.com/docs/#!/Command/RestoreDomain), [UpdateDomains](https://api.agilixbuzz.com/docs/#!/Command/UpdateDomains) | ✅ | ⏫ |
| Enrollments | [CreateEnrollments](https://api.agilixbuzz.com/docs/#!/Command/CreateEnrollments), [DeleteEnrollments](https://api.agilixbuzz.com/docs/#!/Command/DeleteEnrollments), [GetEnrollment3](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollment3), [GetEnrollmentActivity](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollmentActivity), [GetEnrollmentGradebook2](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollmentGradebook2), [GetEnrollmentGroupList](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollmentGroupList), [GetEnrollmentMetricsReport](https://api.agilixbuzz.com/docs/#!/Command/GetEnrollmentMetricsReport), [ListEnrollments](https://api.agilixbuzz.com/docs/#!/Command/ListEnrollments), [ListEnrollmentsByTeacher](https://api.agilixbuzz.com/docs/#!/Command/ListEnrollmentsByTeacher), [ListEntityEnrollments](https://api.agilixbuzz.com/docs/#!/Command/ListEntityEnrollments), [ListUserEnrollments](https://api.agilixbuzz.com/docs/#!/Command/ListUserEnrollments), [PutSelfAssessment](https://api.agilixbuzz.com/docs/#!/Command/PutSelfAssessment), [RestoreEnrollment](https://api.agilixbuzz.com/docs/#!/Command/RestoreEnrollment), [UpdateEnrollments](https://api.agilixbuzz.com/docs/#!/Command/UpdateEnrollments) | ❌ | 🔼 |
| General | [Echo](https://api.agilixbuzz.com/docs/#!/Command/Echo), [GetCommandList](https://api.agilixbuzz.com/docs/#!/Command/GetCommandList), [GetEntityType](https://api.agilixbuzz.com/docs/#!/Command/GetEntityType), [GetStatus](https://api.agilixbuzz.com/docs/#!/Command/GetStatus), [GetUploadLimits](https://api.agilixbuzz.com/docs/#!/Command/GetUploadLimits), [SendMail](https://api.agilixbuzz.com/docs/#!/Command/SendMail) | ❌ | ⏺ |
| Groups | [AddGroupMembers](https://api.agilixbuzz.com/docs/#!/Command/AddGroupMembers), [CreateGroups](https://api.agilixbuzz.com/docs/#!/Command/CreateGroups), [DeleteGroups](https://api.agilixbuzz.com/docs/#!/Command/DeleteGroups), [GetGroup](https://api.agilixbuzz.com/docs/#!/Command/GetGroup), [GetGroupEnrollmentList](https://api.agilixbuzz.com/docs/#!/Command/GetGroupEnrollmentList), [GetGroupList](https://api.agilixbuzz.com/docs/#!/Command/GetGroupList), [RemoveGroupMembers](https://api.agilixbuzz.com/docs/#!/Command/RemoveGroupMembers), [UpdateGroups](https://api.agilixbuzz.com/docs/#!/Command/UpdateGroups) | ❌ | ⏬ |
| Gradebook | [CalculateEnrollmentScenario](https://api.agilixbuzz.com/docs/#!/Command/CalculateEnrollmentScenario), [GetCalendar](https://api.agilixbuzz.com/docs/#!/Command/GetCalendar), [GetCalendarItems](https://api.agilixbuzz.com/docs/#!/Command/GetCalendarItems), [GetCalendarToken](https://api.agilixbuzz.com/docs/#!/Command/GetCalendarToken), [GetCertificates](https://api.agilixbuzz.com/docs/#!/Command/GetCertificates), [GetDueSoonList](https://api.agilixbuzz.com/docs/#!/Command/GetDueSoonList), [GetEntityGradebook2](https://api.agilixbuzz.com/docs/#!/Command/GetEntityGradebook2), [GetEntityGradebook3](https://api.agilixbuzz.com/docs/#!/Command/GetEntityGradebook3), [GetEntityGradebookSummary](https://api.agilixbuzz.com/docs/#!/Command/GetEntityGradebookSummary), [GetEntityWork2](https://api.agilixbuzz.com/docs/#!/Command/GetEntityWork2), [GetGrade](https://api.agilixbuzz.com/docs/#!/Command/GetGrade), [GetGradebookList](https://api.agilixbuzz.com/docs/#!/Command/GetGradebookList), [GetGradebookSummary](https://api.agilixbuzz.com/docs/#!/Command/GetGradebookSummary), [GetGradebookWeights](https://api.agilixbuzz.com/docs/#!/Command/GetGradebookWeights), [GetGradeHistory](https://api.agilixbuzz.com/docs/#!/Command/GetGradeHistory), [GetItemAnalysis2](https://api.agilixbuzz.com/docs/#!/Command/GetItemAnalysis2), [GetItemReport](https://api.agilixbuzz.com/docs/#!/Command/GetItemReport), [GetRubricMastery](https://api.agilixbuzz.com/docs/#!/Command/GetRubricMastery), [GetRubricStats](https://api.agilixbuzz.com/docs/#!/Command/GetRubricStats), [GetUserGradebook2](https://api.agilixbuzz.com/docs/#!/Command/GetUserGradebook2) | ❌ | 🔽 |
| Manifests and Items | [AssignItem](https://api.agilixbuzz.com/docs/#!/Command/AssignItem), [CopyItems](https://api.agilixbuzz.com/docs/#!/Command/CopyItems), [DeleteItems](https://api.agilixbuzz.com/docs/#!/Command/DeleteItems), [FindPersonalizedEntities](https://api.agilixbuzz.com/docs/#!/Command/FindPersonalizedEntities), [GetCourseContent](https://api.agilixbuzz.com/docs/#!/Command/GetCourseContent), [GetItem](https://api.agilixbuzz.com/docs/#!/Command/GetItem), [GetItemInfo](https://api.agilixbuzz.com/docs/#!/Command/GetItemInfo), [GetItemLinks](https://api.agilixbuzz.com/docs/#!/Command/GetItemLinks), [GetItemList](https://api.agilixbuzz.com/docs/#!/Command/GetItemList), [GetManifest](https://api.agilixbuzz.com/docs/#!/Command/GetManifest), [GetManifestData](https://api.agilixbuzz.com/docs/#!/Command/GetManifestData), [GetManifestInfo](https://api.agilixbuzz.com/docs/#!/Command/GetManifestInfo), [GetManifestItem](https://api.agilixbuzz.com/docs/#!/Command/GetManifestItem), [ListAssignableItems](https://api.agilixbuzz.com/docs/#!/Command/ListAssignableItems), [ListRestorableItems](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableItems), [NavigateItem](https://api.agilixbuzz.com/docs/#!/Command/NavigateItem), [PutItems](https://api.agilixbuzz.com/docs/#!/Command/PutItems), [RestoreItems](https://api.agilixbuzz.com/docs/#!/Command/RestoreItems), [Search2](https://api.agilixbuzz.com/docs/#!/Command/Search2), [UnassignItem](https://api.agilixbuzz.com/docs/#!/Command/UnassignItem), [UpdateManifestData](https://api.agilixbuzz.com/docs/#!/Command/UpdateManifestData) | ❌ | ⏺ |
| Objectives | [CreateObjectiveSets](https://api.agilixbuzz.com/docs/#!/Command/CreateObjectiveSets), [DeleteObjectiveMaps](https://api.agilixbuzz.com/docs/#!/Command/DeleteObjectiveMaps), [DeleteObjectives](https://api.agilixbuzz.com/docs/#!/Command/DeleteObjectives), [DeleteObjectiveSets](https://api.agilixbuzz.com/docs/#!/Command/DeleteObjectiveSets), [GetMasteryDetail](https://api.agilixbuzz.com/docs/#!/Command/GetMasteryDetail), [GetMasterySummary](https://api.agilixbuzz.com/docs/#!/Command/GetMasterySummary), [GetObjectiveList](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveList), [GetObjectiveMapList](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveMapList), [GetObjectiveMastery](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveMastery), [GetObjectiveSet2](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveSet2), [GetObjectiveSubjectList](https://api.agilixbuzz.com/docs/#!/Command/GetObjectiveSubjectList), [ListObjectiveSets](https://api.agilixbuzz.com/docs/#!/Command/ListObjectiveSets), [PutObjectiveMaps](https://api.agilixbuzz.com/docs/#!/Command/PutObjectiveMaps), [PutObjectives](https://api.agilixbuzz.com/docs/#!/Command/PutObjectives), [RestoreObjectiveSet](https://api.agilixbuzz.com/docs/#!/Command/RestoreObjectiveSet), [UpdateObjectiveSets](https://api.agilixbuzz.com/docs/#!/Command/UpdateObjectiveSets) | ❌ | ⏬ |
| Peer Grading | [GetPeerResponse](https://api.agilixbuzz.com/docs/#!/Command/GetPeerResponse), [GetPeerResponseInfo](https://api.agilixbuzz.com/docs/#!/Command/GetPeerResponseInfo), [GetPeerResponseList](https://api.agilixbuzz.com/docs/#!/Command/GetPeerResponseList), [GetPeerReviewList](https://api.agilixbuzz.com/docs/#!/Command/GetPeerReviewList), [PutPeerResponse](https://api.agilixbuzz.com/docs/#!/Command/PutPeerResponse) | ❌ | ⏬
| Ratings | [GetItemRating](https://api.agilixbuzz.com/docs/#!/Command/GetItemRating), [GetItemRatingSummary](https://api.agilixbuzz.com/docs/#!/Command/GetItemRatingSummary), [PutItemRating](https://api.agilixbuzz.com/docs/#!/Command/PutItemRating) | ❌ | ⏺ |
| Reports | [GetReportInfo](https://api.agilixbuzz.com/docs/#!/Command/GetReportInfo), [GetReportList](https://api.agilixbuzz.com/docs/#!/Command/GetReportList), [GetRunnableReportList](https://api.agilixbuzz.com/docs/#!/Command/GetRunnableReportList), [RunReport](https://api.agilixbuzz.com/docs/#!/Command/RunReport) | ❌ | ⏫ |
| Resources | [CopyResources](https://api.agilixbuzz.com/docs/#!/Command/CopyResources), [DeleteDocuments](https://api.agilixbuzz.com/docs/#!/Command/DeleteDocuments), [DeleteResources](https://api.agilixbuzz.com/docs/#!/Command/DeleteResources), [GetDocument](https://api.agilixbuzz.com/docs/#!/Command/GetDocument), [GetDocumentInfo](https://api.agilixbuzz.com/docs/#!/Command/GetDocumentInfo), [GetEntityResourceId](https://api.agilixbuzz.com/docs/#!/Command/GetEntityResourceId), [GetResource](https://api.agilixbuzz.com/docs/#!/Command/GetResource), [GetResourceInfo2](https://api.agilixbuzz.com/docs/#!/Command/GetResourceInfo2), [GetResourceList2](https://api.agilixbuzz.com/docs/#!/Command/GetResourceList2), [ListRestorableDocuments](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableDocuments), [ListRestorableResources](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableResources), [PutResource](https://api.agilixbuzz.com/docs/#!/Command/PutResource), [PutResourceFolders](https://api.agilixbuzz.com/docs/#!/Command/PutResourceFolders), [RestoreDocuments](https://api.agilixbuzz.com/docs/#!/Command/RestoreDocuments), [RestoreResources](https://api.agilixbuzz.com/docs/#!/Command/RestoreResources) | ❌ | ⏺ |
| Rights | [CreateRole](https://api.agilixbuzz.com/docs/#!/Command/CreateRole), [DeleteRole](https://api.agilixbuzz.com/docs/#!/Command/DeleteRole), [DeleteSubscriptions](https://api.agilixbuzz.com/docs/#!/Command/DeleteSubscriptions), [GetActorRights](https://api.agilixbuzz.com/docs/#!/Command/GetActorRights), [GetEffectiveRights](https://api.agilixbuzz.com/docs/#!/Command/GetEffectiveRights), [GetEffectiveSubscriptionList](https://api.agilixbuzz.com/docs/#!/Command/GetEffectiveSubscriptionList), [GetEntityRights](https://api.agilixbuzz.com/docs/#!/Command/GetEntityRights), [GetEntitySubscriptionList](https://api.agilixbuzz.com/docs/#!/Command/GetEntitySubscriptionList), [GetPersonas](https://api.agilixbuzz.com/docs/#!/Command/GetPersonas), [GetRights](https://api.agilixbuzz.com/docs/#!/Command/GetRights), [GetRightsList](https://api.agilixbuzz.com/docs/#!/Command/GetRightsList), [GetRole](https://api.agilixbuzz.com/docs/#!/Command/GetRole), [GetSubscriptionList](https://api.agilixbuzz.com/docs/#!/Command/GetSubscriptionList), [ListRoles](https://api.agilixbuzz.com/docs/#!/Command/ListRoles), [RestoreRole](https://api.agilixbuzz.com/docs/#!/Command/RestoreRole), [UpdateRights](https://api.agilixbuzz.com/docs/#!/Command/UpdateRights), [UpdateRole](https://api.agilixbuzz.com/docs/#!/Command/UpdateRole), [UpdateSubscriptions](https://api.agilixbuzz.com/docs/#!/Command/UpdateSubscriptions) | ❌ | 🔼 |
| Signals | [CreateSignal](https://api.agilixbuzz.com/docs/#!/Command/CreateSignal), [GetLastSignalId](https://api.agilixbuzz.com/docs/#!/Command/GetLastSignalId), [GetSignalList2](https://api.agilixbuzz.com/docs/#!/Command/GetSignalList2) | ❌ | 🔽 |
| Submissions | [DeleteWorkInProgress](https://api.agilixbuzz.com/docs/#!/Command/DeleteWorkInProgress), [GenerateSubmission](https://api.agilixbuzz.com/docs/#!/Command/GenerateSubmission), [GetScoData](https://api.agilixbuzz.com/docs/#!/Command/GetScoData), [GetStudentSubmission](https://api.agilixbuzz.com/docs/#!/Command/GetStudentSubmission), [GetStudentSubmissionHistory](https://api.agilixbuzz.com/docs/#!/Command/GetStudentSubmissionHistory), [GetStudentSubmissionInfo](https://api.agilixbuzz.com/docs/#!/Command/GetStudentSubmissionInfo), [GetTeacherResponse](https://api.agilixbuzz.com/docs/#!/Command/GetTeacherResponse), [GetTeacherResponseInfo](https://api.agilixbuzz.com/docs/#!/Command/GetTeacherResponseInfo), [GetWorkInProgress2](https://api.agilixbuzz.com/docs/#!/Command/GetWorkInProgress2), [PutItemActivity](https://api.agilixbuzz.com/docs/#!/Command/PutItemActivity), [PutScoData](https://api.agilixbuzz.com/docs/#!/Command/PutScoData), [PutStudentSubmission](https://api.agilixbuzz.com/docs/#!/Command/PutStudentSubmission), [PutTeacherResponse](https://api.agilixbuzz.com/docs/#!/Command/PutTeacherResponse), [PutTeacherResponses](https://api.agilixbuzz.com/docs/#!/Command/PutTeacherResponses), [PutWorkInProgress](https://api.agilixbuzz.com/docs/#!/Command/PutWorkInProgress), [SubmitWorkInProgress](https://api.agilixbuzz.com/docs/#!/Command/SubmitWorkInProgress) | ❌ | 🔽 |
| Users | [CreateUsers2](https://api.agilixbuzz.com/docs/#!/Command/CreateUsers2), [DeleteUsers](https://api.agilixbuzz.com/docs/#!/Command/DeleteUsers), [GetActiveUserCount](https://api.agilixbuzz.com/docs/#!/Command/GetActiveUserCount), [GetDomainActivity](https://api.agilixbuzz.com/docs/#!/Command/GetDomainActivity), [GetProfilePicture](https://api.agilixbuzz.com/docs/#!/Command/GetProfilePicture), [GetUser2](https://api.agilixbuzz.com/docs/#!/Command/GetUser2), [GetUserActivity](https://api.agilixbuzz.com/docs/#!/Command/GetUserActivity), [GetUserActivityStream](https://api.agilixbuzz.com/docs/#!/Command/GetUserActivityStream), [ListUsers](https://api.agilixbuzz.com/docs/#!/Command/ListUsers), [RestoreUser](https://api.agilixbuzz.com/docs/#!/Command/RestoreUser), [UpdateUsers](https://api.agilixbuzz.com/docs/#!/Command/UpdateUsers) | ❌ | ⏫ |
| Wikis | [CopyWikiPages](https://api.agilixbuzz.com/docs/#!/Command/CopyWikiPages), [DeleteWikiPages](https://api.agilixbuzz.com/docs/#!/Command/DeleteWikiPages), [GetWikiPage](https://api.agilixbuzz.com/docs/#!/Command/GetWikiPage), [GetWikiPageList](https://api.agilixbuzz.com/docs/#!/Command/GetWikiPageList), [ListRestorableWikiPages](https://api.agilixbuzz.com/docs/#!/Command/ListRestorableWikiPages), [PutWikiPage](https://api.agilixbuzz.com/docs/#!/Command/PutWikiPage), [RestoreWikiPages](https://api.agilixbuzz.com/docs/#!/Command/RestoreWikiPages), [UpdateWikiPageViewed](https://api.agilixbuzz.com/docs/#!/Command/UpdateWikiPageViewed) | ❌ | ⏬ |
| Example Name | Example Description | ✅ or ❌ | ⏫🔼⏺🔽⏬ |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/beneggett/agilix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Agilix::Buzz project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/agilix/blob/master/CODE_OF_CONDUCT.md).



