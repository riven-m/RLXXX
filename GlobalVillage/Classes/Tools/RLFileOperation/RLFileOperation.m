//
//  FileOperation.m
//  GlobalVillage
//
//  Created by RivenL on 14/12/19.
//  Copyright (c) 2014年 RivenL. All rights reserved.
//

#import "RLFileOperation.h"

static NSString * const kUserLogin = @"UserLoginKey";

@implementation RLFileOperation
+ (NSDictionary *)constructUserLoginInfo:(NSString *)name pwd:(NSString *)pwd date:(NSDate *)date plateforme:(NSString *)plateforme openKey:(NSString *)openKey {
    NSDictionary *dic = nil;
    if(name == nil && pwd == nil && openKey) {
        dic = [NSDictionary dictionaryWithObjectsAndKeys:date, @"kUserLoginDate", plateforme, @"kPlateforme", openKey, @"kOpenKey", nil];
    }
    else {
        dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"kUsername", pwd, @"kUserPwd", date, @"kUserLoginDate", plateforme, @"kPlateforme", nil];
    }
    
    return dic;
}

+ (void)setUserLoginInfo:(NSDictionary *)dic {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dic forKey:kUserLogin];
    [userDefaults synchronize];
}

+ (void)removeUserLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kUserLogin];
    [userDefaults synchronize];
}

+ (NSDictionary *)userLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    DLog(@"%@", [userDefaults objectForKey:kUserLogin]);
    return [userDefaults objectForKey:kUserLogin];
}

+ (BOOL)isLogined {
    return [[[self userLoginInfo] objectForKey:@"logined"] boolValue];
}

+ (BOOL)storeLoginInfo:(NSString *)name pwd:(NSString *)pwd date:(NSDate *)date plateforme:(NSString *)plateforme openKey:(NSString *)openKey {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self constructUserLoginInfo:name pwd:pwd date:date plateforme:plateforme openKey:openKey]];
    [dic setObject:[NSNumber numberWithBool:YES] forKey:@"logined"];
    
    [self setUserLoginInfo:dic];
    
    return YES;
}
@end
