//
//  AppDelegate.h
//  MovieBuzz
//
//  Created by Abhishek Desai on 10/11/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) UITabBarController *tabController;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (retain, nonatomic) NSString* zipCode;
@property (nonatomic, assign) BOOL searchByCurrentLocation;
@property (nonatomic, assign) BOOL searchByMovie;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
