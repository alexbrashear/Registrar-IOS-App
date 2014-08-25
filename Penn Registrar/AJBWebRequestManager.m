//
//  AJBWebRequestManager.m
//  Penn Registrar
//
//  Created by Alex Brashear on 8/4/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBWebRequestManager.h"

NSString * const AJBBearerHeaderKey = @"Authorization-Bearer";
NSString * const AJBTokenHeaderKey = @"Authorization-Token";

NSString * const AJBBearerHeaderField = @"UPENN_OD_emud_1000683";
NSString * const AJBTokenHeaderField = @"1vkd6m32bo1polkdfup713dmte";

@implementation AJBWebRequestManager

+ (void)retrieveDataWithAsyncURLRequest:(NSURLRequest *)urlrequest AndCompletion:(void (^) (NSDictionary *))block {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlrequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableDictionary *profileDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        block(profileDictionary);
    }];
}

+ (NSDictionary *)retrieveDictionaryWithSynchronousRequest:(NSURLRequest *)urlrequest {
    
    NSURLResponse *urlResponse;    NSError *urlError;
    NSError *jsonError;
    
    NSData *urlData = [NSURLConnection sendSynchronousRequest:urlrequest returningResponse:&urlResponse error:&urlError];
    
    NSDictionary *profileDIctionary = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableLeaves error:&jsonError];
    
    return profileDIctionary;
}

+ (NSURLRequest *)URLRequestWithURL:(NSString *)url {
    NSMutableURLRequest *urlrequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlrequest setValue:AJBBearerHeaderField forHTTPHeaderField:AJBBearerHeaderKey];
    [urlrequest setValue:AJBTokenHeaderField forHTTPHeaderField:AJBTokenHeaderKey];
    
    return urlrequest;
}
@end
