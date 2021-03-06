//
//  Settings.m
//  MacBox
//
//  Created by Mark on 15/08/2017.
//  Copyright © 2017 Mark McGuill. All rights reserved.
//

#import "Settings.h"

#define kRevealDetailsImmediately @"revealDetailsImmediately"
#define kFullVersion @"fullVersion"
#define kEndFreeTrialDate @"endFreeTrialDate"
#define kAutoLockTimeout @"autoLockTimeout"
#define kPasswordGenerationParameters @"passwordGenerationParameters"
#define kWarnedAboutTouchId @"warnedAboutTouchId"
#define kAlwaysShowUsernameInOutlineView @"alwaysShowUsernameInOutlineView"
#define kAlwaysShowPassword @"alwaysShowPassword"

static NSString* const kAutoFillNewRecordSettings = @"autoFillNewRecordSettings";
static NSString* const kAutoSave = @"autoSave";

@implementation Settings

+ (instancetype)sharedInstance {
    static Settings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Settings alloc] init];
    });
    return sharedInstance;
}

- (BOOL)revealDetailsImmediately {
    return [self getBool:kRevealDetailsImmediately];
}

- (void)setRevealDetailsImmediately:(BOOL)value {
    [self setBool:kRevealDetailsImmediately value:value];
}

- (BOOL)warnedAboutTouchId {
    return [self getBool:kWarnedAboutTouchId];
}

- (void)setWarnedAboutTouchId:(BOOL)warnedAboutTouchId {
    [self setBool:kWarnedAboutTouchId value:warnedAboutTouchId];
}

- (BOOL)fullVersion {
    return [self getBool:kFullVersion];
}

- (void)setFullVersion:(BOOL)value {
    [self setBool:kFullVersion value:value];
}

- (BOOL)alwaysShowPassword {
    return [self getBool:kAlwaysShowPassword];
}

-(void)setAlwaysShowPassword:(BOOL)alwaysShowPassword {
    [self setBool:kAlwaysShowPassword value:alwaysShowPassword];
}

- (BOOL)alwaysShowUsernameInOutlineView {
    return [self getBool:kAlwaysShowUsernameInOutlineView];
}

- (void)setAlwaysShowUsernameInOutlineView:(BOOL)alwaysShowUsernameInOutlineView {
    [self setBool:kAlwaysShowUsernameInOutlineView value:alwaysShowUsernameInOutlineView];
}

- (BOOL)freeTrial {
    NSDate* date = self.endFreeTrialDate;
    
    if(date == nil) {
        return YES;
    }
    
    return !([date timeIntervalSinceNow] < 0);
}

- (NSInteger)freeTrialDaysRemaining {
    NSDate* date = self.endFreeTrialDate;
    
    if(date == nil) {
        return -1;
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay
                                                fromDate:[NSDate date]
                                                  toDate:date
                                                 options:0];
    
    NSInteger days = [components day];
    
    return days;
}

- (NSDate*)endFreeTrialDate {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:kEndFreeTrialDate];
}

- (void)setEndFreeTrialDate:(NSDate *)endFreeTrialDate {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:endFreeTrialDate forKey:kEndFreeTrialDate];
    
    [userDefaults synchronize];
}

- (BOOL)getBool:(NSString*)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults boolForKey:key];
}

- (void)setBool:(NSString*)key value:(BOOL)value {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:value forKey:key];
    
    [userDefaults synchronize];
}

- (NSInteger)autoLockTimeoutSeconds {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:kAutoLockTimeout];
}

- (void)setAutoLockTimeoutSeconds:(NSInteger)autoLockTimeoutSeconds {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:autoLockTimeoutSeconds forKey:kAutoLockTimeout];
    
    [userDefaults synchronize];
}

- (PasswordGenerationParameters *)passwordGenerationParameters {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:kPasswordGenerationParameters];
    
    if(encodedObject == nil) {
        return [[PasswordGenerationParameters alloc] initWithDefaults];
    }
    
    PasswordGenerationParameters *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

-(void)setPasswordGenerationParameters:(PasswordGenerationParameters *)passwordGenerationParameters {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:passwordGenerationParameters];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:kPasswordGenerationParameters];
    [defaults synchronize];
}

- (AutoFillNewRecordSettings*)autoFillNewRecordSettings {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kAutoFillNewRecordSettings];
    
    if(data) {
        return (AutoFillNewRecordSettings *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return AutoFillNewRecordSettings.defaults;
}

- (void)setAutoFillNewRecordSettings:(AutoFillNewRecordSettings *)autoFillNewRecordSettings {
    NSData *encoded = [NSKeyedArchiver archivedDataWithRootObject:autoFillNewRecordSettings];
    
    [[NSUserDefaults standardUserDefaults] setObject:encoded forKey:kAutoFillNewRecordSettings];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)autoSave {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSObject* autoSave = [userDefaults objectForKey:kAutoSave];

    BOOL ret = TRUE;
    if(!autoSave) {
        NSLog(@"No Autosave settings... defaulting to Yes");
    }
    else {
        NSNumber* num = (NSNumber*)autoSave;
        ret = num.boolValue;
    }

    return ret;
}

-(void)setAutoSave:(BOOL)autoSave {
    [self setBool:kAutoSave value:autoSave];
}

@end
