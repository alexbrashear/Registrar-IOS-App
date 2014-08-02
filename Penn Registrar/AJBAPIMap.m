//
//  AJBAPIMap.m
//  Penn Registrar
//
//  Created by Alex Brashear on 8/1/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBAPIMap.h"

@interface AJBAPIMap()
@property (nonatomic, strong) NSDictionary *departmentMap;
@property (nonatomic, strong) NSDictionary *programMap;
@property (nonatomic, strong) NSDictionary *hourMap;
@property (nonatomic, strong) NSDictionary *dayMap;
@property (nonatomic, strong) NSDictionary *termMap;
@property (nonatomic, strong) NSDictionary *activityMap;
@property (nonatomic, strong) NSDictionary *searchParametersMap;
@end

NSString * const departmentKey = @"departments_map";
NSString * const programKey = @"program_map";
NSString * const hourKey = @"starts_at_or_after_hour_map";
NSString * const dayKey = @"starts_on_day_map";
NSString * const termKey = @"available_terms_map";
NSString * const activityKey = @"activity_map";
NSString * const searchParametersKey = @"acceptable_search_url_parameters_map";


@implementation AJBAPIMap

- (AJBAPIMap *)initWithDictionary:(NSDictionary *)profileDictionary {
    self.departmentMap = [[NSDictionary alloc] initWithDictionary:[profileDictionary objectForKey:departmentKey]];
    self.programMap = [[NSDictionary alloc] initWithDictionary:[profileDictionary objectForKey:programKey]];
    self.hourMap = [[NSDictionary alloc] initWithDictionary:[profileDictionary objectForKey:hourKey]];
    self.dayMap = [[NSDictionary alloc] initWithDictionary:[profileDictionary objectForKey:dayKey]];
    self.termMap = [[NSDictionary alloc] initWithDictionary:[profileDictionary objectForKey:termKey]];
    self.activityMap = [[NSDictionary alloc] initWithDictionary:[profileDictionary objectForKey:activityKey]];
    self.searchParametersMap = [[NSDictionary alloc] initWithDictionary:[profileDictionary objectForKey:searchParametersKey]];
    
    return self;
}

- (NSString *)departmentForkey:(NSString *)key {
    return [self.departmentMap objectForKey:key];
}

- (NSString *)programForkey:(NSString *)key {
    return [self.departmentMap objectForKey:key];
}

- (NSString *)hourForkey:(NSString *)key {
    return [self.hourMap objectForKey:key];
}

- (NSString *)dayForkey:(NSString *)key {
    return [self.dayMap objectForKey:key];
}

- (NSString *)termForkey:(NSString *)key {
    return [self.termMap objectForKey:key];
}

- (NSString *)activityForkey:(NSString *)key {
    return [self.activityMap objectForKey:key];
}

- (NSString *)searchParametersURLForKey:(NSString *)key {
    return [self.searchParametersMap objectForKey:key];
}

@end
