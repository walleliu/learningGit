//
//  DNSRequestData.h
//  AFN
//
//  Created by 吴泽楠 on 16/5/4.
//  Copyright © 2016年 DNS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface DNSRequestData : NSObject

/**
 *  数据请求
 *
 *  @param urlstring URL
 *  @param method    get or Post
 *  @param parmas    请求参数
 *  @param files     请求文件(图片)
 *  @param progress  请求进度的block
 *  @param success   请求成功的block
 *  @param fail      请求失败的block
 */

//@property(nonatomic,strong) AFHTTPSessionManager *manager;
+ (AFHTTPSessionManager *)requestURL:(NSString *)requestURL
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
          progress:(void (^)(NSProgress *loadProgress))progress
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail;
+ (void)StopRequest;
@end
