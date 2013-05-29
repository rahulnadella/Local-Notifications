/*
 Copyright (c) 2013 Rahul Nadella
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 LocalNotificationsTests.m
 Local Notifications
 
 Created by Rahul Nadella on 5/28/13.
 Copyright 2013 Rahul Nadella. All rights reserved.
 */

#import "LocalNotificationsTests.h"
/*
 The implementation of the LocalNotificationsTests interface.
 
 @since 1.0
 @version 1.0
 */
@implementation LocalNotificationsTests

@synthesize currentDate = _currentDate;
@synthesize titleMessage = _titleMessage;
@synthesize actionMessage = _actionMessage;
@synthesize localNotificationDictionary = _localNotificationDictionary;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.currentDate = [NSDate date];
    self.titleMessage = @"Local Notification Test";
    self.actionMessage = @"Local Notification Test using OCUnit";
    self.localNotificationDictionary = [[NSMutableDictionary alloc] init];
    [self.localNotificationDictionary setObject:@"Testing Local Notifications 1" forKey:@"1"];
}

- (void)tearDown
{
    // Tear-down code here.
    self.currentDate = nil;
    self.titleMessage = nil;
    self.actionMessage = nil;
    [self.localNotificationDictionary removeAllObjects];
    
    [super tearDown];
}

- (void)testSharedInstance
{
    NSLocalNotificationsScheduler *localNotification = [NSLocalNotificationsScheduler sharedInstance];
    STAssertNotNil(localNotification, @"Shared Instance is initialized");
}

- (void)testScheduleLocalNotification
{
    /* Schedule a Local Notification */
    [[NSLocalNotificationsScheduler sharedInstance] scheduleNotificationOn:self.currentDate text:self.titleMessage action:self.actionMessage sound:nil launchImage:nil andInfo:self.localNotificationDictionary andRepeatInterval:0];
    STAssertEquals(1, [NSLocalNotificationsScheduler sharedInstance].badgeCount, @"Check the equality of badge count to verify the local notification fired");
    
    /* Cancel the specific Notification */
    [[NSLocalNotificationsScheduler sharedInstance] cancelNotification:@"1"];
    /* Cancel All Notifications */
    [[NSLocalNotificationsScheduler sharedInstance] cancelAllNotifications];
}

- (void)testClearBadgeCount
{
    NSLocalNotificationsScheduler *localNotification = [NSLocalNotificationsScheduler sharedInstance];
    STAssertNotNil(localNotification, @"Shared Instance is initialized");
    /* Clear Badge Count to 0 */
    [localNotification clearBadgeCount];
    STAssertEquals(0, localNotification.badgeCount, @"Check the equality of badge count to verify the local notification has been cleared");
}

@end
