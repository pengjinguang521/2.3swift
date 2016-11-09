//
//  DBChatModel.m
//  ChatDemo
//
//  Created by JGPeng on 16/11/9.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "DBChatModel.h"
#import "NetWorkSessionManger.h"

#define ChatDataBase @"dbChat.sqlite"
#define TableTolk    @"tabletolk"

@implementation DBChatModel

/**
 *  创建数据库，这个代码一般在AppDelegate时候就执行
 */
+ (void)CreateDB{
    //创建dbChat.sqlite数据库
    [[DBSaveHelper sharedHelper]openDB:ChatDataBase];
#warning 如果.h文件属性有修改，这边也应该修改，与表字断对应 “ text”固定后缀 ！
    NSArray * propertyArray = @[@"sender text",@"receive text",@"messageType text",@"sendtime text",@"sendcontent text", @"duration text"];
    //创建表
    [[DBSaveHelper sharedHelper]createTableWithName:TableTolk AndArray:propertyArray];
}

/**
 *  存入消息对象
 *
 *  @param model 消息对象
 */
+ (void)SaveDBWithModel:(DBChatModel *)model{
    [[DBSaveHelper sharedHelper]openDB:ChatDataBase];
    [[DBSaveHelper sharedHelper]insertIntoDBWithTableName:TableTolk AndModel:model];
}

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
                  Receive:(NSString *)receive{
    
    NSString * sql = [NSString stringWithFormat:@"select * from %@ where sender = ? and receive =? and ID < ? order by ID desc limit %d",TableTolk,MessageCount];
    NSArray * arr = @[sender,receive,[NSString stringWithFormat:@"%ld",(long)lastID]];
       NSArray * array = [[DBSaveHelper sharedHelper]searchDBWithSql:sql AndArray:arr AndTableName:TableTolk];
    return array;
}





@end
