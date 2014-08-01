//
//  AJBCourseDataModel.m
//  Penn Registrar
//
//  Created by Alex Brashear on 8/1/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBCourseDataModel.h"

NSString * const AJBBearerHeaderKey = @"Authorization-Bearer";
NSString * const AJBTokenHeaderKey = @"Authorization-Token";

NSString * const AJBBearerHeaderField = @"UPENN_OD_emud_1000683";
NSString * const AJBTokenHeaderField = @"1vkd6m32bo1polkdfup713dmte";

NSString * const AJBCourseSectionSearchParametersURL = @"https://esb.isc-seo.upenn.edu/8091/open_data/course_section_search_parameters/";

@implementation AJBCourseDataModel

- (void)retrieveCourseInformationWithCompletion{//:(void (^) (void))reloadTableviewBlock {
    NSMutableURLRequest *urlrequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:AJBCourseSectionSearchParametersURL]];
    [urlrequest setValue:AJBBearerHeaderField forHTTPHeaderField:AJBBearerHeaderKey];
    [urlrequest setValue:AJBTokenHeaderField forHTTPHeaderField:AJBTokenHeaderKey];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlrequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableDictionary *profileDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //reloadTableviewBlock();
    }];
}

@end
