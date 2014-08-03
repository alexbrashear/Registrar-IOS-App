//
//  AJBCourseDataModel.h
//  Penn Registrar
//
//  Created by Alex Brashear on 8/1/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AJBCourseDataModel : NSObject

+ (void)retrieveCourseInformationWithCompletion:(void (^) (void))reloadTableviewBlock;
+ (NSInteger)numberOfDepartments;
+ (NSString *)departmentAtIndex:(NSInteger)index;



@end
