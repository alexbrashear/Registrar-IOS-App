//
//  AJBAPIMap.h
//  Penn Registrar
//
//  Created by Alex Brashear on 8/1/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AJBAPIMap : NSObject

- (AJBAPIMap *)initWithDictionary:(NSDictionary *)profileDictionary;

- (NSString *)departmentForkey:(NSString *)key;
- (NSString *)programForkey:(NSString *)key;
- (NSString *)hourForkey:(NSString *)key;
- (NSString *)dayForkey:(NSString *)key;
- (NSString *)termForkey:(NSString *)key;
- (NSString *)activityForkey:(NSString *)key;
- (NSString *)searchParametersURLForKey:(NSString *)key;
- (NSArray *)departments;



@end
