//
//  AJBWebRequestManager.m
//  Penn Registrar
//
//  Created by Alex Brashear on 8/4/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBWebRequestManager.h"

@implementation AJBWebRequestManager

+ (void)retrieveDataWithAsyncURLRequest:(NSURLRequest *)urlrequest AndCompletion:(void (^) (NSDictionary *))block {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlrequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableDictionary *profileDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        block(profileDictionary);
    }];
}

@end
