//
//  AJBCourseDataFetcher.m
//  Penn Registrar
//
//  Created by Alex Brashear on 8/4/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBCourseDataFetcher.h"
#import "AJBWebRequestManager.h"
#import "AJBCoreDataManager.h"
#import "AJBAPIMap.h"
#import "AJBDepartment.h"
#import "AJBCourse.h"

NSString * const AJBBearerHeaderKey = @"Authorization-Bearer";
NSString * const AJBTokenHeaderKey = @"Authorization-Token";

NSString * const AJBBearerHeaderField = @"UPENN_OD_emud_1000683";
NSString * const AJBTokenHeaderField = @"1vkd6m32bo1polkdfup713dmte";

NSString * const AJBResultDataKey = @"result_data";

NSString * const AJBCourseSectionSearchParametersURL = @"https://esb.isc-seo.upenn.edu/8091/open_data/course_section_search_parameters/";

@implementation AJBCourseDataFetcher

+ (void)retrieveDepartmentData {
    NSMutableURLRequest *urlrequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:AJBCourseSectionSearchParametersURL]];
    [urlrequest setValue:AJBBearerHeaderField forHTTPHeaderField:AJBBearerHeaderKey];
    [urlrequest setValue:AJBTokenHeaderField forHTTPHeaderField:AJBTokenHeaderKey];
    
    [AJBWebRequestManager retrieveDataWithAsyncURLRequest:urlrequest AndCompletion:^(NSDictionary *profileDictionary) {
        AJBAPIMap *apiMap = [[AJBAPIMap alloc] initWithDictionary:[[profileDictionary objectForKey:AJBResultDataKey] lastObject]];
        NSArray *departments = [[NSArray alloc] init];
        departments = [[apiMap departments] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        NSMutableArray *depts = [[NSMutableArray alloc] init];
        
        for (NSString *dept in [apiMap departments]) {
            NSMutableDictionary *deptDictionary = [NSMutableDictionary dictionary];
            deptDictionary[[AJBDepartment fullNameKey]] = [apiMap departmentForkey:dept];
            deptDictionary[[AJBDepartment abbrNameKey]] = dept;
            
            [depts addObject:deptDictionary];
        }
        [AJBCourseDataFetcher setupDepartmentsFromArray:depts];
    }];
}

+ (void)setupDepartmentsFromArray:(NSArray *)depts {
    NSManagedObjectContext *context = [[AJBCoreDataManager sharedManager] managedObjectContext];
    for (NSDictionary *dict in depts) {
        [[AJBDepartment alloc] initWithDictionary:dict managedObjectContext:context];
    }
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

+ (void)retrieveCourseData {
    
}

@end
