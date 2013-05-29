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
 
 NSLocalNotificationScheduler.m
 Local Notifications
 
 Created by Rahul Nadella on 5/28/13.
 Copyright 2013 Rahul Nadella. All rights reserved.
 */

#import "NSLocalNotificationsScheduler.h"

static NSLocalNotificationsScheduler *_instance;
/*
 This class provides an implementation of the NSLocalNotificationScheduler interface.
 
 @since 1.0
 @version 1.0
 */
@implementation NSLocalNotificationsScheduler

@synthesize badgeCount = _badgeCount;

#pragma mark - Singleton Methods

+ (NSLocalNotificationsScheduler*)sharedInstance
{
	@synchronized(self) {
		
        if (_instance == nil) {
			
			// iOS 4 compatibility check
			Class notificationClass = NSClassFromString(@"UILocalNotification");
			
			if(notificationClass == nil)
			{
				_instance = nil;
			}
			else 
			{				
				_instance = [[super allocWithZone:NULL] init];				
				_instance.badgeCount = 0;
			}
        }
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone
{	
   return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

#pragma mark - Schedule Notification On

- (void)scheduleNotificationOn:(NSDate *) fireDate
                          text:(NSString *) alertText
                        action:(NSString *) alertAction
                         sound:(NSString *) soundfileName
                   launchImage:(NSString *) launchImage 
                       andInfo:(NSDictionary *) userInfo
             andRepeatInterval:(NSInteger)repeatInterval
{
	UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = fireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];	
	
    localNotification.alertBody = alertText;
    localNotification.alertAction = alertAction;
	localNotification.repeatCalendar = [NSCalendar currentCalendar];
    
    switch(repeatInterval) 
    {
        case 1: 
            localNotification.repeatInterval = NSDayCalendarUnit;
            break;
        case 2: 
            localNotification.repeatInterval = NSWeekdayCalendarUnit;
            break;
        case 3:
            localNotification.repeatInterval = NSMonthCalendarUnit;
            break;
        default: 
            localNotification.repeatInterval = 0;
            break;
    }
	
	if(soundfileName == nil)
	{
		localNotification.soundName = UILocalNotificationDefaultSoundName;
	}
	else 
	{
		localNotification.soundName = soundfileName;
	}

	localNotification.alertLaunchImage = launchImage;
	
	self.badgeCount ++;
    localNotification.applicationIconBadgeNumber = self.badgeCount;			
    localNotification.userInfo = userInfo;
	
	/* Schedule it with the app */
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

#pragma mark - Clear Badge Count

- (void)clearBadgeCount
{
	self.badgeCount = 0;
	[UIApplication sharedApplication].applicationIconBadgeNumber = self.badgeCount;
}

#pragma mark - Decrease Badge Count By

- (void)decreaseBadgeCountBy:(int) count
{
	self.badgeCount -= count;
	if(self.badgeCount < 0) self.badgeCount = 0;
	
	[UIApplication sharedApplication].applicationIconBadgeNumber = self.badgeCount;
}

#pragma mark - Handle Received Notification

- (void)handleReceivedNotification:(UILocalNotification*) thisNotification
{
	[self decreaseBadgeCountBy:1];
}

#pragma mark - Cancel Notification

- (void)cancelNotification:(NSString *)localNotificationKey
{
    NSString *myIDToCancel = localNotificationKey;
    UILocalNotification *notificationToCancel=nil;
    NSArray *scheduledLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *aNotif in scheduledLocalNotifications) 
    {
        NSString *notificationUserInfoValue = [aNotif.userInfo objectForKey:localNotificationKey];
        if([notificationUserInfoValue isEqualToString:myIDToCancel]) 
        {
            notificationToCancel=aNotif;
            break;
        }
    }
    if (notificationToCancel != nil)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:notificationToCancel];
    }
}

#pragma mark - Cancel All Notifications

- (void)cancelAllNotifications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
