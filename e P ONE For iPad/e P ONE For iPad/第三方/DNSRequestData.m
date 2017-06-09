//
//  DNSRequestData.m
//  AFN
//
//  Created by 吴泽楠 on 16/5/4.
//  Copyright © 2016年 DNS. All rights reserved.
//

#import "DNSRequestData.h"
#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>
//#define SERVER_HTTP_FILEADDRESS @"https://socket.purenfort.com/purenfort/Api/"
@implementation DNSRequestData

+ (AFHTTPSessionManager *)requestURL:(NSString *)url
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
          progress:(void (^)(NSProgress *loadProgress))progress
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail
{
//    NSString *wifiName = [self getWifiName];
    NSString *requestURL;
//    if ([wifiName isEqualToString:@"PURENFORT-ZH"]) {
//        requestURL = [ZH_HTTP_FILEADDRESS stringByAppendingString:url];
//    }else{
//    NSString *projectIP = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    requestURL = url;
//    }
    
    NSLog(@"网络请求地址:%@",requestURL);
    NSLog(@"网络请求类型:%@\n 请求请求参数:%@",method,parmas);
   
    //1.构造操作对象管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.设置解析格式，不设置 --- 默认为json
    
//    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    //简写 --- 类方法实现的就是上面的写法
    manager.responseSerializer = [AFJSONResponseSerializer serializer];


    //3.如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];

    
//    //4.判断网络状况
//    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
//    [netManager startMonitoring];  //开始监听
//    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
//    
//        
//        
//        if (status == AFNetworkReachabilityStatusNotReachable)
//        {
//
//            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络链接错误,请检查网络链接" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil]show];
//            
//            //NSLog(@"没有网络");
//            
//            return;
//            
//        }else if (status == AFNetworkReachabilityStatusUnknown){
//            
//            NSLog(@"未知网络");
//            //创建一个消息对象
//            NSNotification * notice = [NSNotification notificationWithName:@"haveInternet" object:nil userInfo:nil];
//            //发送消息
//            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            
//        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
//            //创建一个消息对象
//            NSNotification * notice = [NSNotification notificationWithName:@"haveInternet" object:nil userInfo:nil];
//            //发送消息
//            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            NSLog(@"手机网络");
//            
//        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
//            //创建一个消息对象
//            NSNotification * notice = [NSNotification notificationWithName:@"haveInternet" object:nil userInfo:nil];
//            //发送消息
//            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            NSLog(@"WiFi");
//        }
//        
//        
//        
//    }];
    
    
    
    // 5.get请求
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        
        [manager GET:requestURL
          parameters:parmas
            progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) {
                    progress(downloadProgress);
                }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
        }];
        
        
        // 6.post请求不带文件 和post带文件
    }else if ([[method uppercaseString] isEqualToString:@"POST"]) {
        
        
        if (files == nil) {
            
            [manager POST:requestURL
               parameters:parmas
                 progress:^(NSProgress * _Nonnull uploadProgress) {
                     if (progress) {
                         progress(uploadProgress);
                     }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (fail) {
                    fail(error);
                }
            }];
            
            
        } else {
            
            [manager POST:requestURL
               parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                   for (id key in files) {
                       
                       id value = files[key];
                       
                       
                       
                       [formData appendPartWithFileData:value
                                                   name:key
                                               fileName:@"header.png"
                                               mimeType:@"image/png"];
                   }

            } progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) {
                    
                    progress(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (fail) {
                    fail(error);
                }
            }];
            
        }
        
    }
    return manager;
    
}
-(void)sendSettingNSNotification{
    
}
//#pragma mark 获取当前wifi名称
//+ (NSString *)getWifiName
//{
//    NSString *wifiName = nil;
//    
//    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
//    
//    if (!wifiInterfaces) {
//        return nil;
//    }
//    
//    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
//    
//    for (NSString *interfaceName in interfaces) {
//        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
//        
//        if (dictRef) {
//            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
//            NSLog(@"network info -> %@", networkInfo);
//            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
//            
//            CFRelease(dictRef);
//        }
//    }
//    
//    CFRelease(wifiInterfaces);
//    return wifiName;
//}
+ (void)StopRequest{
//    AFURLSessionManager *maan  = [AFURLSessionManager alloc] init
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager.operationQueue cancelAllOperations];
//    self = nil;

}
@end
