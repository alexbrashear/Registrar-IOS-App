//
//  AJBCourseDataModel.m
//  Penn Registrar
//
//  Created by Alex Brashear on 8/1/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBCourseDataModel.h"

@implementation AJBCourseDataModel

- (void)retrieveCoursesWithCompletion:(void (^) (void))reloadTableviewBlock {
    [NSURLConnection sendAsynchronousRequest:<#(NSURLRequest *)#> queue:<#(NSOperationQueue *)#> completionHandler:<#^(NSURLResponse *response, NSData *data, NSError *connectionError)handler#>]
}

@end
