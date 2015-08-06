//
// Created by Saurabh Gupta on 6/7/15.
// Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "MSNetworkManager.h"

// Timeout for most network requests (in seconds)
#define REQUEST_TIMEOUT 15

typedef enum {
    RequestTypeGet,
    RequestTypePost,
} RequestType;


@implementation MSNetworkManager {
@private
    NSString *_transmitUrl;
}

@synthesize transmitUrl = _transmitUrl;

- (void)transmitSamples:(NSArray *)samples forDeviceId:(NSString *)deviceId withSessionId:(NSString *)sessionId{
    if(_transmitUrl != nil) {
        NSDictionary *data = @{
                @"deviceId" : deviceId,
                @"sessionId": sessionId,
                @"data" : samples
        };
        [MSNetworkManager sendRequestOfType:RequestTypePost
                                 withParams:data
                                      toUrl:[NSURL URLWithString:_transmitUrl]
                               withDeviceId:deviceId];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }

    return self;
}


+ (MSNetworkManager *)instance {
    static MSNetworkManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}


+ (NSData *)sendRequestOfType:(RequestType)requestType
                   withParams:(NSDictionary *)params
                        toUrl:(NSURL *)url
                 withDeviceId:(NSString *)deviceId {
    NSString *method;
    switch (requestType) {
        case RequestTypeGet: method = @"GET"; break;
        case RequestTypePost: method = @"POST"; break;
    }

    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSURLRequest *request = [self requestForURL:url
                                     parameters:params
                                         method:method
                                         asJson:YES
                                    cachePolicy:NSURLRequestReloadIgnoringCacheData
                                   withDeviceId:(NSString *)deviceId];

    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];

    if (error) {
        NSLog(@"[ERROR] Failed GET request to %@: %@", [request URL], [error localizedDescription]);
        return nil;
    } else if ([response statusCode] == 200) {
        return data;
    } else {
        NSLog(@"[ERROR] Failed GET request to %@: response was %d %@",
                [request URL],
                [response statusCode],
                [NSHTTPURLResponse localizedStringForStatusCode:[response statusCode]]);
        return nil;
    }
}

+ (NSURLRequest *)requestForURL:(NSURL *)requestURL
                     parameters:(NSDictionary *)parameters
                         method:(NSString *)method
                         asJson:(BOOL)useJson //if YES, then form content is JSON, else is form encoded; relevant only for POST method
                    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                   withDeviceId:(NSString *)deviceId {

    NSMutableURLRequest *request = nil;

    if ([method isEqualToString:@"GET"]) {
        NSString *queryString = parameters ? [self queryStringFromParameters:parameters] : nil;
        requestURL = queryString ? [self URLByAppendingQueryString:queryString toURL:requestURL] : requestURL;
        request = [NSMutableURLRequest requestWithURL:requestURL
                                          cachePolicy:cachePolicy
                                      timeoutInterval:REQUEST_TIMEOUT];
    } else if ([method isEqualToString:@"POST"]) {
        request = [[NSMutableURLRequest alloc] initWithURL:requestURL
                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                           timeoutInterval:REQUEST_TIMEOUT];
        if (parameters) {
            if(useJson) {
                [self setPostJSONPayload:parameters onRequest:request];
            }
            else {
                [self setFormPostParameters:parameters onRequest:request];
            }
        }
    }
    [request setHTTPMethod:method];
    [request setValue:deviceId forHTTPHeaderField:@"x-mobilesensor-deviceid"];

    return request;
}

+ (BOOL) setPostJSONPayload:(NSDictionary *) object onRequest: (NSMutableURLRequest *) request {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];

    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return NO;
    }
    else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        [request setHTTPBody:jsonData];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        return YES;
    }
}

+ (void) setFormPostParameters: (NSDictionary *) parameters onRequest: (NSMutableURLRequest *)request {
    NSString *formPostParams = [self encodeFormPostParameters: parameters];

    [request setHTTPBody:[formPostParams dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}

+ (NSString *) encodeFormPostParameters: (NSDictionary *) parameters {
    NSMutableString *formPostParams = [[NSMutableString alloc] init];

    NSEnumerator *keys = [parameters keyEnumerator];
    BOOL isFirst = YES;
    for (NSString *name in keys) {
        if(name != nil) {
            if(isFirst) {
                isFirst = NO;
            }
            else {
                [formPostParams appendString: @"&"];
            }
            NSString *encodedValue =
                    (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                            (__bridge CFStringRef) parameters[name],
                            NULL, CFSTR("=/: "), kCFStringEncodingUTF8);

            [formPostParams appendString: name];
            [formPostParams appendString: @"="];
            [formPostParams appendString: encodedValue];
            CFRelease((__bridge CFStringRef)encodedValue);
        }
    }
    NSLog(@"form string is: %@", formPostParams);

    return formPostParams;
}

+ (NSString *)queryStringFromParameters:(NSDictionary *)parameters {
    __block NSMutableString *queryString = [NSMutableString stringWithString:@""];
    if (parameters != nil && [parameters count] > 0) {
        [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *queryParameter = [NSString stringWithFormat:@"%@=%@&", key, obj];
            [queryString appendString:queryParameter];
        }];
        // Remove the last "&"
        [queryString deleteCharactersInRange:NSMakeRange([queryString length] - 1, 1)];
    }
    return queryString;
}

+ (NSURL *) URLByAppendingQueryString:(NSString *)queryString
                                toURL: (NSURL *) url {
    if (![queryString length]) {
        return url;
    }

    NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@%@",
                                                           [url absoluteString],
                                                           [url query] ? @"&" : @"?", queryString];
    NSURL *theURL = [NSURL URLWithString:URLString];
    return theURL;
}

@end