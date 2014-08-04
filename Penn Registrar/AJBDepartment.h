//
//  AJBDepartment.h
//  Penn Registrar
//
//  Created by Alex Brashear on 8/3/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AJBDepartment : NSManagedObject

@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *abbrName;

+ (NSString *)fullNameKey;
+ (NSString *)abbrNameKey;
@end
