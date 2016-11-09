//
//  DBChatModel.h
//  ChatDemo
//
//  Created by JGPeng on 16/11/9.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#pragma mark - 数据库模型 主要用来处理聊天记录

#import <Foundation/Foundation.h>
#import "DBSaveHelper.h"
#import "ShaHeSave.h"

//每次返回的消息条数
#define MessageCount   10

/**
 消息类型
 */
typedef enum {
    DBMessageTypeMessage = 0,//文本
    DBMessageTypePicture = 1,//图片
    DBMessageTypeVoice   = 2,//声音
}DBMessageType;


@interface DBChatModel : NSObject

///** 数据库中标示消息的ID字断,前端不要传，读就可以 */
//@property (nonatomic,assign)NSInteger ID;//前端不要传

/** 谁发的 －> 发送者 */
@property (nonatomic,strong)NSString * sender;
//------sender的信息，如果要做的话，建议是再建个用户表------
//------sender的信息，简单点的话，就是在这下面去添加属性----

/** 发给谁 －> 接收者 */
@property (nonatomic,strong)NSString * receive;
//------receive的信息同sender-------------------------


/** 消息类型 */
@property (nonatomic,assign)DBMessageType messageType;
/** 接受消息时间 */
@property (nonatomic,strong)NSString * sendtime;
/** 语音消息时常 */
@property (nonatomic,strong)NSString * duration;
/** 消息内容，文字则存文字，图片和声音则存路径 */
@property (nonatomic,strong)NSString * sendcontent;


/***********************数据库操作的主要方法*************************/

/**
 *  创建数据库，这个代码一般在AppDelegate时候就执行
 */
+ (void)CreateDB;

/**
 *  存入消息对象
 *
 *  @param model 消息对象
 */
+ (void)SaveDBWithModel:(DBChatModel *)model;

/**
 *  查询数据库中的记录
 *
 *  @param lastID  就是你最后一次拿到的记录ID 如果首次请传1000000000
 *  @param sender  发送者
 *  @param receive 接收者
 *
 *  @return 字典数组
 */
+ (NSArray *)FindDBWithID:(NSInteger)lastID
                   Sender:(NSString *)sender
                  Receive:(NSString *)receive;



@end
