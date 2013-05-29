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
 
 NSLocalNotificationsScheduler.h
 Local Notifications
 
 Created by Rahul Nadella on 5/28/13.
 Copyright 2013 Rahul Nadella. All rights reserved.
 */

#import <Foundation/Foundation.h>
/*
 The NSLocalNotificationScheduler class is a singleton classes which are an important concept to understand because they exhibit an extremely useful design pattern. This idea is used throughout the iPhone SDK, for example, UIApplication has a method called sharedApplication which when called from anywhere will return the UIApplication instance which relates to the currently running application.
 
 Instances of UILocalNotification represent notifications that an application can schedule for presentation to its users at specific dates and times. The operating system is responsible for delivering the notification at the proper time; the application does not have to be running for this to happen. Although local notifications are similar to remote notifications in that they are used for displaying alerts, playing sounds, and badging application icons, they are composed and delivered locally and do not require connection with remote servers.
 
 Local notifications are primarily intended for applications with timer-based behaviors and simple calendar or to-do list applications. Applications that run in the allowed period in the background may also present a local notification, scheduled or immediate, to inform the user of an incoming message, chat, or update. An application can have only a limited number of scheduled notifications; the system keeps the soonest-firing 64 notifications (with automatically rescheduled notifications counting as a single notification) and discards the rest
 
 When you create a local notification, you must specify when the system should deliver the notification. You can qualify this “fire date” (fireDate) with a time zone so that the fire date is adjusted when time-zone changes occur. You can also specify a repeat interval (daily, weekly, monthly, and so on). The substance of the notification can be an alert message or an application-icon badge number; you can also request that sound be played when alert messages are displayed. Local notifications can include custom data stored in a dictionary. Because UILocalNotification adopts the NSCopying protocol, you can copy existing local notifications and modify them to suit.
 
 The NSLocalNotificationScheduler singleton class gives the ability to schedule local notifications based on a specific fire date, alert text, alert action, sound file, lauch image, user info, and repeat interval.  There is also several helper methods to manage the bagde count per notification, handle a notification when received by operating system, and cancel a specific notification.
 
 @since 1.0
 @version 1.0
 */
@interface NSLocalNotificationsScheduler : NSObject 
{
	int _badgeCount;
}

@property int badgeCount;
/*
 A sharedInstance is often implemented with the singleton pattern. Like in [UIApplication sharedApplication] -> There is only one application which you access through this singleton. The idea is to have one instance of a class which can be accessed by calling a class method, in objective-c commonly named sharedXXX. The sharedInstance class method provides an extremely powerful way to share data between different parts of code without having to pass the data around manually.
 
 @since 1.0
 */
+ (NSLocalNotificationsScheduler *) sharedInstance;

/*
 The schedule notification on method provides the capability to schedule a UILocalNotification based on the fireDate, alertText, alertAction, soundfileName, launchImage, userInfo, and repeatInterval.
 
 @since 1.0
 
 @param fireDate
        The specific date to fire the UILocalNotification
 @param alertText
        The specific text associated to the UILocalNotification
 @param alertAction
        The specific action associated to the UILocalNotification
 @param soundfileName
        The specific sound file associated to the UILocalNotification
 @param launchImage
        The launch image file associated to the UILocalNotification
 @param userInfo
        The user info associated to the UILocalNotification
 @param repeatInterval
        The repeat interval associated to the UILocalNotification
 */
- (void)scheduleNotificationOn:(NSDate *) fireDate
						   text:(NSString *) alertText
						 action:(NSString *) alertAction
						  sound:(NSString *) soundfileName
					launchImage:(NSString *) launchImage 
						andInfo:(NSDictionary *) userInfo
              andRepeatInterval:(NSInteger)repeatInterval;

/*
 The handle received notification method provides the ability to receive a UILocalNotification and process the result to the UI interface of the user.
 
 @since 1.0
 
 @param thisNotification
        The specific UILocalNotification being processed.
 */
- (void)handleReceivedNotification:(UILocalNotification *) thisNotification;

/*
 The cancel notification method cancels a specific notification based on a key
 
 @since 1.0
 
 @param localNotificationKey
        The specific unique key to reference the UILocalNotification
 */
- (void)cancelNotification:(NSString *)localNotificationKey;

/*
 The cancel all notifications method removes all local notifications from the current context.
 
 @since 1.0
 */
- (void)cancelAllNotifications;

/*
 The decrease badge count by method decreases the badge count by a specific number
 
 @since 1.0
 
 @param count
        The integer value to decrease the badge count
 */
- (void)decreaseBadgeCountBy:(int) count;

/*
 Provides the functionality to clear a badge count
 
 @since 1.0
 */
- (void)clearBadgeCount;

@end
