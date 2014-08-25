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

NSString * const AJBResultDataKey = @"result_data";

NSString * const AJBCourseSectionSearchParametersURL = @"https://esb.isc-seo.upenn.edu/8091/open_data/course_section_search_parameters/";
NSString * const AJBCourseCatalogURL = @"https://esb.isc-seo.upenn.edu/8091/open_data/course_info/";
NSString * const AJBPageNumber = @"/?page_number=";

@implementation AJBCourseDataFetcher

+ (void)retrieveDepartmentData {
    NSURLRequest *urlrequest = [AJBWebRequestManager URLRequestWithURL:AJBCourseSectionSearchParametersURL];
    
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
        [self retrieveCourseDataFromDepartment:departments];
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

+ (void)retrieveCourseDataFromDepartment:(NSArray *)departments {
    for (NSString *department in departments) {
        // get first page to retrieve service meta data
        NSString *url = [NSString stringWithFormat:@"%@%@%@%d", AJBCourseCatalogURL, department, AJBPageNumber, 1];
        NSURLRequest *urlrequest = [AJBWebRequestManager URLRequestWithURL:url];

        NSDictionary *serviceMetaDictionary = [[AJBWebRequestManager retrieveDictionaryWithSynchronousRequest:urlrequest] objectForKey:@"service_meta"];
        NSInteger numPages = [[serviceMetaDictionary objectForKey:@"number_of_pages"] integerValue];
        NSInteger currentPage = 1;
        
        while (currentPage <= numPages) {
            NSString *url = [NSString stringWithFormat:@"%@%@%@%d", AJBCourseCatalogURL, department, AJBPageNumber, currentPage];
            
            NSURLRequest *urlrequest = [AJBWebRequestManager URLRequestWithURL:url];
            
            [AJBWebRequestManager retrieveDataWithAsyncURLRequest:urlrequest AndCompletion:^(NSDictionary *profileDictionary){
                NSLog(@"asdfasdf");
            }];
            currentPage = currentPage + 1;
        }
    }
}

@end
