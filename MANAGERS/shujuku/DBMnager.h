//
//  DBMnager.h
//  UNIVERTWO
//
//  Created by 我在路上 on 16/8/2.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBMnager : NSObject
+ (instancetype)sharedManager;
//工作的数据检查更新
- (BOOL)isxsitsJOBxiWithAppID:(NSString *)appid;
//添加一条数据,添加一个标记标签

- (void)addJOBCollectionModel:(NSString *)IDD withbiaoji:(NSString *)biao;
//删除全部工作的数据
//- (void)deleteallPCJOBData;
//获取我的工作的全部数据
-(NSArray *)getJOBalldata;
//点击娃能问消息刷新更新
//-(void)JOBshuxinAppID:(NSString *)appid;
//删除一条工作的数据
- (void)deleteallPCwanxiaoxiData :(NSString *) IDD;


//添加一条喜欢的工作
- (void)addLikeListmessage:(NSString *)Id;
//添加一条不喜欢的工作
- (void)addUnLikeListmessage:(NSString *)Id andtongbu:(NSString *)tongbu;
//获取全部喜欢的工作
- (NSArray *)getLikeListAllData;
//获取全部不喜欢的工作
- (NSArray *)getUnLikeListAllData;
//修改同步信息
- (void)xiugaiistongbu;

//按条件查询没有标记为同步的数据
-(NSArray *)seenotlgou:(NSString *)logo;
//标签更新的方法
-(void)genxinbiaoji;

@end
