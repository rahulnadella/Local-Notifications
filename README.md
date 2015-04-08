Local-Notifications
===================

Overview
-------------------

The NSLocalNotificationScheduler class is a singleton classes which are an important concept to understand because they exhibit an extremely useful design pattern. This idea is used throughout the iPhone SDK, for example, UIApplication has a method called sharedApplication which when called from anywhere will return the UIApplication instance which relates to the currently running application.

The NSLocalNotificationScheduler singleton class gives the ability to schedule local notifications based on a specific fire date, alert text, alert action, sound file, lauch image, user info, and repeat interval.  There is also several helper methods to manage the bagde count per notification, handle a notification when received by operating system, and cancel a specific notification.

#####Version
>Version 1.0 - Design and Implementation of the Local Notifications
>Build (Master) - Works on iOS 5.0 or greater

Usage
-------------------
	#import "NSLocalNotificationScheduler.h"    

	[[NSLocalNotificationsScheduler sharedInstance] scheduleNotificationOn:refillAlertDate text:text action:action sound:currentRefillRemainderAlertSound launchImage:nil andInfo:localNotificationDictionary andRepeatInterval:0];

License
------------------------------

*MIT License* --> A short, permissive software license. Basically, you can do whatever you want as long as you include the original copyright and license notice in any copy of the software/source.  There are many variations of this license in use.
