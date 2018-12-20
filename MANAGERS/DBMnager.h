//
//  DBMnager.h
//  UNIVERTWO
//
//  Created by 刘鑫然 on 16/5/6.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zhaopingModel.h"
#import "bannarModel.h"
#import "searchModeltwo.h"
#import "shoucangModel.h"
#import "wannengwenTwoModel.h"
#import "wannengwenOneModel.h"
@interface DBMnager : NSObject


+ (instancetype)sharedManager;
//检查招聘信息是否有更新
- (BOOL)isxsitsWithAppID:(NSString *)appid;
//检查归国政策是否有更新
- (BOOL)isesitsguibannarid:(NSString *)appid;
//向归国政策的bannar里添加数据
- (void)addBannarguiCollectionModel:(NSArray *)bannarArray;
//获取归国政策所有信息
- (NSArray *)fetchAllguiBannarData;
//检查城市筛选是否有更新
- (BOOL)iscityesitscityArray:(NSArray *)array;
//检查日期筛选是否有更新
- (BOOL)isDateesitscityArray:(NSArray *)array;
//检查职位筛选是否有更新
- (BOOL)isZwesitscityArray:(NSArray *)array;
//检查bannar图是否有更新
- (BOOL)isesitsbannarid:(NSString *)appid;
//检查归国政策是否有更新
- (BOOL)isxsitsguiWithAppID:(NSString *)appid;
//获取归国政策的所有信息
- (NSArray *)fetchAllguiData;
//向数据库中增加招聘信息
- (void)addzpCollectionModel:(NSArray *) modelarray;
//向归国政策中添加数据
- (void)addguiCollectionModel:(NSArray *)modelarray;

//向数据库中增加bannar信息
- (void)addBannarCollectionModel:(NSArray *)bannarArray;


//向数据库中增加城市信息
- (void)addCityMessageArray:(NSArray *)array;



//向数据库中增加时间筛选信息
- (void)adddatemessagearray:(NSArray *)array;


//向数据库中增加职位筛选信息
- (void)addzwMessagearray:(NSArray *)array;


//获取招聘的所有信息
- (NSArray *)fetchAllzpData;

//获取bannar所有信息
- (NSArray *)fetchAllBannarData;
//获取所有城市信息
- (NSArray *)fetchALLcitySxdata;
//获取所有职位信息
- (NSArray *)fetchAllzwSxData;
//获取所有时间筛选信息
- (NSArray *)fetchAllDateData;


//检查个人中心收藏数据的更新
- (BOOL)isxsitspcshouWithAppID:(NSString *)appid;
//添加个人中心收藏数据
- (void)addpcshouCollectionModel:(NSArray *)modelarray;
//添加一条个人中心收藏消息
-(void)addondateshoucang:(zhaopingModel * )model withoid:(NSString *)oid;
//删除个人中心收藏的数据
- (void)deleteallPCshouData;
//获取收藏的全部数据
-(NSArray *)getshoucangalldata;
//删除收藏的某一条数据
-(void)selectshoucangonedatawith:(NSString * ) OID;
//万能问我的回答检查更新
- (BOOL)isxsitspcwanmihuiWithAppID:(NSString *)appid;
//万能问我的回答数据添加

- (void)addwanmihuiCollectionModel:(NSArray *)modelarray;
//删除万能问我的回答数据
- (void)deleteallPCwanmihuiData;
//获取万能问我的回答的全部数据
-(NSArray *)getwanmihuialldata;
//万能问我的收藏的回答检查更新
- (BOOL)isxsitspcwanmishouhuiWithAppID:(NSString *)appid;
//万能问我的收藏的回答数据添加

- (void)addwanmishouhuiCollectionModel:(NSArray *)modelarray;
//添加一条万能问收藏的回答数据
-(void)addwanmishouhuionedateCollectionModel:(wannengwenTwoModel *)model with:(NSString *)title;
//删除万能问我的收藏的回答数据
- (void)deleteallPCwanmishouhuiData;
//删除一条我的收藏的回答数据
- (void)deleteallPCwanmishouhuioneDatashuju:(NSString *)ID;
//获取万能问我的收藏的回答的全部数据
-(NSArray *)getwanmishouhhuialldata;
//万能问我的关注的问题检查更新
- (BOOL)isxsitspcwanguanzhuWithAppID:(NSString *)appid;
//万能问我的关注的问题数据添加

- (void)addwanguanzhuCollectionModel:(NSArray *)modelarray;
//添加一条关注的问题数据
-(void)addoneguanzhuwentiwih:(wannengwenOneModel *)model;
//取消一条关注的问题数据
-(void)quxiaoguanzhuwentionedatewith:(NSString *)ID;
//删除万能问我的关注的问题数据
- (void)deleteallPCwanguanzhuData;
//获取万能问关注的问题全部数据
-(NSArray *)getwanaguznzhualldata;
//万能问我的问题检查更新
- (BOOL)isxsitspcwanwentiWithAppID:(NSString *)appid;
//万能问我的问题数据添加

- (void)addwanwentiCollectionModel:(NSArray *)modelarray;
//删除万能问我的问题数据
- (void)deleteallPCwanwentiData;
//获取万能问wode的问题全部数据
-(NSArray *)getwanwentialldata;
//万能问消息检查更新
- (BOOL)isxsitspcwanxiaoxiWithAppID:(NSString *)appid;
//我的娃能问消息数据添加

- (void)addwanxiaoxiCollectionModel:(NSArray *)modelarray;
//删除我的消息万能问消息数据
- (void)deleteallPCwanxiaoxiData;
//获取我的消息万能问消息全部数据
-(NSArray *)getwanxiaoxialldata;
//点击娃能问消息刷新更新
-(void)isxsitspcwanxiaodianjishuxinxiWithAppID:(NSString *)appid;
//系统消息检查更新
- (BOOL)isxsitspcxitongxiaoxiWithAppID:(NSString *)appid;
//我的系统消息数据添加

- (void)addxitongxiaoxiCollectionModel:(NSArray *)modelarray;
//删除我的消息系统消息数据
- (void)deleteallPCxitongxiaoxiData;
//获取我的消息系统消息全部数据
-(NSArray *)getxitongxiaoxialldata;
//系统消息去除提示点更新
-(void)isxsitspcxitongxiaoxtwojishuxinxiWithAppID ;

@end
