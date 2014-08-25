//
//  AJBWebRequestManager.h
//  Penn Registrar
//
//  Created by Alex Brashear on 8/4/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AJBWebRequestManager : NSObject

+ (void)retrieveDataWithAsyncURLRequest:(NSURLRequest *)urlrequest AndCompletion:(void (^) (NSDictionary *))block;

+ (NSDictionary *)retrieveDictionaryWithSynchronousRequest:(NSURLRequest *)urlrequest;

+ (NSURLRequest *)URLRequestWithURL:(NSString *)url;


@end
