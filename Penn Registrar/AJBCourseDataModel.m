//
//  AJBCourseDataModel.m
//  Penn Registrar
//
//  Created by Alex Brashear on 8/1/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBCourseDataModel.h"
#import "AJBAPIMap.h"
#import "AJBDepartment.h"
#import "AJBWebRequestManager.h"

@interface AJBCourseDataModel()

//@property (nonatomic, strong) NSArray *departments;

@end

NSString * const AJBBearerHeaderKey = @"Authorization-Bearer";
NSString * const AJBTokenHeaderKey = @"Authorization-Token";

NSString * const AJBBearerHeaderField = @"UPENN_OD_emud_1000683";
NSString * const AJBTokenHeaderField = @"1vkd6m32bo1polkdfup713dmte";

NSString * const AJBResultDataKey = @"result_data";

NSString * const AJBCourseSectionSearchParametersURL = @"https://esb.isc-seo.upenn.edu/8091/open_data/course_section_search_parameters/";
// https://esb.isc-seo.upenn.edu/8091/open_data/course_info/ACCT/?page_number=2

static NSArray *departments;

@implementation AJBCourseDataModel

- (id)init {
    departments = [[NSMutableArray alloc] init];
    return self;
}

+ (void)retrieveCourseInformationWithCompletion:(void (^) (void))reloadTableviewBlock {
    NSMutableURLRequest *urlrequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:AJBCourseSectionSearchParametersURL]];
    [urlrequest setValue:AJBBearerHeaderField forHTTPHeaderField:AJBBearerHeaderKey];
    [urlrequest setValue:AJBTokenHeaderField forHTTPHeaderField:AJBTokenHeaderKey];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlrequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableDictionary *profileDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        AJBAPIMap *apiMap = [[AJBAPIMap alloc] initWithDictionary:[[profileDictionary objectForKey:AJBResultDataKey] lastObject]];
        
        departments = [[apiMap departments] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

        //reloadTableviewBlock();
        NSMutableArray *depts = [[NSMutableArray alloc] init];
        
        for (NSString *dept in [apiMap departments]) {
            NSMutableDictionary *deptDictionary = [NSMutableDictionary dictionary];
            deptDictionary[[AJBDepartment fullNameKey]] = [apiMap departmentForkey:[AJBDepartment fullNameKey]];
            deptDictionary[[AJBDepartment abbrNameKey]] = dept;
            
            [depts addObject:deptDictionary];
        }
    }];
}

- (void)

+ (NSInteger)numberOfDepartments {
    return [departments count];
}

+ (NSString *)departmentAtIndex:(NSInteger)index {
    return [departments objectAtIndex:index];
}

@end
