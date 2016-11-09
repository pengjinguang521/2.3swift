//
//  NetWorkSessionManger.h
//  NetWork
//
//  Created by JGPeng on 16/9/3.
//  Copyright © 2016年 self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define TIMEREQUESTINTERVAL 30                              //网络超时
#define BLOCK_EXEC(block,...) if(block){block(__VA_ARGS__);}//判断block是否存在
typedef void (^Progress)(NSProgress *progress);             //返回进度条，这边可不传
typedef void (^SuccessBlock)(id json);                      //成功回调
typedef void (^FailBlock)(NSError * error);                 //失败回调error
typedef void (^EndBlock)();                                 //一次网络请求完成后要做的事情
typedef enum {

    UploadTypeImage     = 0, //JPEG图形 default
    UploadTypeGzip      = 1, //GZIP文件
    UploadTypeAu        = 2, //au声音文件
    UploadTypeMidi      = 3, //MIDI音乐文件
    UploadTypeRealAudio = 4, //RealAudio音乐文件
    UploadTypeAVI       = 5, //AVI文件
    UploadTypeTAR       = 6, //TAR文件
    UploadTypeGIF       = 7, //GIF图形

}UploadType;


@interface NetWorkSessionManger : NSObject
/**
 *  创建管理者
 *
 *  @param url 判断url是否https
 *
 *  @return
 */
+ (AFHTTPSessionManager *)getMgrWithUrl:(NSString *)url;

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



#pragma mark -get请求
+ (void)GET:(NSString *)url Params:(NSDictionary *)params Progress:(Progress)progress SuccessBlock:(void (^)(id json))success FailBlock:(void (^)(NSError * error))fail End:(EndBlock)end;
#pragma mark -post请求
+ (void)POST:(NSString *)url Params:(NSDictionary *)params Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end;
#pragma mark -put请求
+ (void)PUT:(NSString *)url Params:(NSDictionary *)params Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end;
#pragma mark -delete请求
+ (void)DELET:(NSString *)url Params:(NSDictionary *)params Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end;
#pragma mark - 文件上传
+ (void)UPLOAD:(NSString *)url Params:(NSDictionary *)params Type:(UploadType)type Data:(NSData *)data Progress:(Progress)progress SuccessBlock:(SuccessBlock)success FailBlock:(FailBlock)fail End:(EndBlock)end;


@end
