//
//  ViewController.m
//  事件请求方法
//
//  Created by 曹羊羊 on 16/1/25.
//  Copyright © 2016年 曹羊羊. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>
{
    NSMutableData *recDates;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://115.159.1.248:56666/index.html"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
    }];
    
    NSURLSession *session1 = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task1 = [session1 dataTaskWithURL:url];
    [task resume];
    [task1 resume];
}


#pragma mark - NSURLSession datadelete
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"开始！");
    completionHandler(NSURLSessionResponseAllow);
    recDates = [[NSMutableData alloc]init];
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"接受！");
    [recDates appendData:data];//可能不是一次接受完成
}


-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
    NSLog(@"完成！recDatas=%@",[[NSString alloc]initWithData:recDates encoding:NSUTF8StringEncoding]);
    
}


@end
