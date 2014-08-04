//
//  AJBDepartment.m
//  Penn Registrar
//
//  Created by Alex Brashear on 8/3/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBDepartment.h"

@implementation AJBDepartment

@dynamic fullName, abbrName;

+ (NSString *)fullNameKey {
    return @"fullName";
}

+ (NSString *)abbrNameKey {
    return @"abbrName";
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary managedObjectContext:(NSManagedObjectContext *)context {
    
    NSString *fullName = dictionary[@"fullName"];
    NSString *abbrName = dictionary[@"abbrName"];
    
    self = [self initWithFullName:fullName abbrName:abbrName managedobjectContext:context];
    
    return self;
}

- (instancetype)initWithFullName:(NSString *)fullName
                        abbrName:(NSString *)abbrName
            managedobjectContext:(NSManagedObjectContext *)context {
    
    self = [self initWithEntity:[NSEntityDescription entityForName:@"AJBDepartment" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
    
    if (self) {
        self.fullName = fullName;
        self.abbrName = abbrName;
    }
    
    return self;
}


@end
