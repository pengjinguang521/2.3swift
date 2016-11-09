//
//  NetWorkSessionManger.m
//  NetWork
//
//  Created by JGPeng on 16/9/3.
//  Copyright © 2016年 self. All rights reserved.
//

#import "NetWorkSessionManger.h"

@implementation NetWorkSessionManger

/**
 *  创建管理者
 *
 *  @param url 判断url是否https
 *
 *  @return
 */
+ (AFHTTPSessionManager *)getMgrWithUrl:(NSString *)url
{
    // 创建请求管理者
    AFHTTPSessionManager * mgr                    = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval         = TIMEREQUESTINTERVAL;
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", @"image/jpeg", nil];

    // https 请求
    if ([url hasPrefix:@"https"]) {
    AFSecurityPolicy * securityPolicy             = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    mgr.securityPolicy                            = securityPolicy;
#pragma  mark  --如果需要验证的话则之行下面的方法，并修改相应的方法
//        mgr.securityPolicy = [NetWorkSessionManger customSecurityPolicy];
    }
    return mgr;
}

/**
 *  设置ssl认证
 *
 *  @return 证书
 */
+ (AFSecurityPolicy*)customSecurityPolicy{
    // /先导入证书
    NSString *cerPath                             = [[NSBundle mainBundle] pathForResource:@"mfp" ofType:@"cer"];//证书的路径
    NSData *certData                              = [NSData dataWithContentsOfFile:cerPath];

    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy              = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];

    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates       = YES;

    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName            = NO;
    NSSet * set                                   = [NSSet setWithObjects:certData, nil];
    securityPolicy.pinnedCertificates             = set;
    return securityPolicy;
}

/**
 *  下面依次调用get post delete put 等网络请求
 *
 *  @param url      地址
 *  @param params   这边需要考虑上传格式需不需要加密或者json
 *  @param progress 进度
 *  @param success  成功
 *  @param fail     失败
 *  @param end      end方法主要是为了方便关闭菊花，或者是如果有依赖情况的话 方便之行代码
 */

+ (void)GET:(NSString *)url Params:(NSDictionary *)params Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end{
    AFHTTPSessionManager * mgr  = [NetWorkSessionManger getMgrWithUrl:url];
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        BLOCK_EXEC(progress,downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BLOCK_EXEC(success,responseObject);
        BLOCK_EXEC(end);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_EXEC(fail,error);
        BLOCK_EXEC(end);
    }];
}

+ (void)POST:(NSString *)url Params:(NSDictionary *)params Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end{
     AFHTTPSessionManager * mgr  = [NetWorkSessionManger getMgrWithUrl:url];
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        BLOCK_EXEC(progress,uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BLOCK_EXEC(success,responseObject);
        BLOCK_EXEC(end);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_EXEC(fail,error);
        BLOCK_EXEC(end);
    }];
}

+ (void)PUT:(NSString *)url Params:(NSDictionary *)params Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end{
    AFHTTPSessionManager * mgr  = [NetWorkSessionManger getMgrWithUrl:url];
    [mgr PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BLOCK_EXEC(success,responseObject);
        BLOCK_EXEC(end);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_EXEC(fail,error);
        BLOCK_EXEC(end);
    }];


}

+ (void)DELET:(NSString *)url Params:(NSDictionary *)params Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end{
    AFHTTPSessionManager * mgr  = [NetWorkSessionManger getMgrWithUrl:url];
    [mgr DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BLOCK_EXEC(success,responseObject);
        BLOCK_EXEC(end);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_EXEC(fail,error);
        BLOCK_EXEC(end);
    }];

}

#pragma mark - 下面是文件上传


+ (NSArray *)SwitchType:(UploadType)type{
    NSString * typeDes = @"jpeg";
    NSString * typeStr = @"image/jpeg";
    if (type) {
        switch (type) {
            case UploadTypeImage:
                typeStr = @"image/jpeg";
                typeDes = @"jpeg";
                break;
            case UploadTypeGzip:
                typeStr = @"application/x-gzip";
                typeDes = @"gz";
                break;
            case UploadTypeAu:
                typeStr = @"audio/basic";
                typeDes = @"au";
                break;
            case UploadTypeMidi:
                typeStr = @"audio/x-midi";
                typeDes = @"midi";
                break;
            case UploadTypeRealAudio:
                typeStr = @"audio/x-pn-realaudio";
                typeDes = @"ra";
                break;
            case UploadTypeAVI:
                typeStr = @"video/x-msvideo";
                typeDes = @"avi";
                break;
            case UploadTypeTAR:
                typeStr = @"application/x-tar";
                typeDes = @"tar";
                break;
            case UploadTypeGIF:
                typeStr = @"image/gif";
                typeDes = @"gif";
                break;
            default:
                break;
        }
    }
    return @[typeDes,typeStr];
}


+ (void)UPLOAD:(NSString *)url Params:(NSDictionary *)params Type:(UploadType)type Data:(NSData *)data Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end{
    
    NSArray * typeArr = [NetWorkSessionManger SwitchType:type];
    
    
    NSTimeInterval timeInt = [[NSDate date] timeIntervalSince1970];
    NSString * fileName = [NSString stringWithFormat:@"%.0f.%@", timeInt,typeArr[0]];
    NSString * uploadName = [NSString stringWithFormat:@"%.0f", timeInt];
    AFHTTPSessionManager * mgr  = [NetWorkSessionManger getMgrWithUrl:url];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:uploadName fileName:fileName mimeType:typeArr[1]];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        BLOCK_EXEC(progress,uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BLOCK_EXEC(success,responseObject);
        BLOCK_EXEC(end);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_EXEC(fail,error);
        BLOCK_EXEC(end);
    }];
}


@end
