//
//  DBMnager.m
//  UNIVERTWO
//
//  Created by 我在路上 on 16/8/2.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#import "DBMnager.h"
#import "FMDB.h"
#import "zhaopingModel.h"
#import <Foundation/Foundation.h>
@implementation DBMnager{
    //创建数据库对象
    FMDatabase * _dataBase;
}
+ (instancetype)sharedManager{
    static dispatch_once_t token;
    static DBMnager * gDbManager = nil;
    
    dispatch_once (&token, ^{
        if (!gDbManager) {
            gDbManager = [[DBMnager alloc]init];
        }
        
        
    });
    return gDbManager;
    
}
- (instancetype)init{
    if (self = [super init]) {
        //使用fmdb第三方框架，创建数据库
        NSString * dbPath = [NSString stringWithFormat:@"%@/Documents/app.sqlite",NSHomeDirectory()];
        NSLog(@"数据库的路径%@",dbPath);
        //在改路径下创建数据库
        _dataBase = [[FMDatabase alloc]initWithPath:dbPath];
        //打开数据库
        [_dataBase open];
        //创建数据库表（招聘）
        
        // FMDatabase执行sql语句
        // 当数据库文件创建完成时，首先创建数据表，如果没有这个表，就去创建，有了就不创建
        
        NSString * creatjoblist = @"create table if not exists  joblistIDD (ID varchar(255),dabiao varchar(255))";
        //
        [_dataBase executeUpdate:creatjoblist ];
        
        NSString * creatLikeList = @"create table if not exists likeList(ID varchar(255), istongBu varchar(255))";
        [_dataBase executeUpdate:creatLikeList];
        
        NSString * creatUnLikeList = @"create table if not exists UnlikeList(ID varchar(255), istongBu varchar(255))";
        [_dataBase executeUpdate:creatUnLikeList];
    }
        return self;



}
//工作数据检查更新
- (BOOL)isxsitsJOBxiWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select * from joblistIDD where ID = %@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    
    if ([set next]) {
        return YES;
    }else{
        
        return NO;
    }
    
    
}

- (void)addLikeListmessage:(NSString *)Id{
    
    NSString * inserLikelistSql = @"insert into likeList values (? , ?) ";
    [_dataBase executeUpdate:inserLikelistSql,Id,@"no"];
}

- (void)addUnLikeListmessage:(NSString *)Id andtongbu:(NSString *)tongbu{
    
    NSString * inserLikelistSql = @"insert into UnlikeList values (? , ?) ";
    [_dataBase executeUpdate:inserLikelistSql,Id,tongbu];
}




//添加一条数据

- (void)addJOBCollectionModel:(NSString *)IDD withbiaoji:(NSString *)biao{
    NSString * querySql = [NSString stringWithFormat:@"select * from joblistIDD where ID = %@",IDD];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    
    if ([set next]) {
       
    }else{
        NSString * insertZpSql = @"insert into joblistIDD  values (?,?)";
        BOOL ischaru = [_dataBase executeUpdate:insertZpSql ,IDD ,biao];
        if(ischaru){
            NSLog(@"插入数据成功");
        }else{
            NSLog(@"插入数据失败");
        }
  
       
    }

    
    
    //[self deleteallPCJOBData];
      // }
    //NSLog(@"插入数据到数据库");
    
}

- (NSArray *)getLikeListAllData{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from likeList";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    NSMutableArray * array = [NSMutableArray array];
    while ([set next]) {
        NSString * Id = [set stringForColumn:@"ID"];
        NSString * istongbu = [set stringForColumn:@"istongBu"];
        NSDictionary * dic = @{@"ID":Id,@"istongbu":istongbu};
        [array addObject:dic];
    }
    
    return array;
    
    
    
}
- (NSArray *)getUnLikeListAllData{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from UnlikeList where istongBu = 0";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    NSMutableArray * array = [NSMutableArray array];
    while ([set next]) {
        NSString * Id = [set stringForColumn:@"ID"];
        NSString * istongbu = [set stringForColumn:@"istongBu"];
//        NSDictionary * dic = @{@"ID":Id,@"istongbu":istongbu};
       
        
    }
    
    return array;
    
    
    
}
- (void)xiugaiistongbu{
    NSString * fetchSql = @"update likeList set istongBu='yes'";
    [_dataBase executeUpdate:fetchSql];

    NSString * UnfetchSql = @"update UnlikeList set istongBu='yes'";
    [_dataBase executeUpdate:UnfetchSql];
    
}

//删除工作一条数据数据
- (void)deleteallPCwanxiaoxiData :(NSString *) IDD{
    
    NSString * deletecitysql = @"delete from joblistIDD  where   ID = ? ";
    
    BOOL  isdelect =  [_dataBase executeUpdate:deletecitysql,IDD];
    if(isdelect){
        NSLog(@"成功删除一条数据");

    }else{
        NSLog(@"失败矮油，不错欧，没删掉");

    }
    }
//获取工作的全部数据
-(NSArray *)getJOBalldata{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from joblistIDD";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
//    // 循环遍历取出数据
   NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
//        
//        wannengwenTwoModel * model = [[wannengwenTwoModel alloc]init];
        
//        
        NSString  * ID =[set stringForColumn:@"ID"];
        if(ID.length > 0){
            [array insertObject:ID atIndex:0];
            //[array addObject:ID];

        }
//        
//        model.oid = [ids intValue];
//        
//        model.avatar = [set stringForColumn:@"headimg"];
//        
//        
//        model.username =[set stringForColumn:@"name"];
//        model.t =[set stringForColumn:@"ts"];
          }
    return array;
    
}

//按条件查询没有标记为同步的数据
-(NSArray *)seenotlgou:(NSString *)logo{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from joblistIDD where dabiao = ?";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql,logo];
    
    //    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        //
        //        wannengwenTwoModel * model = [[wannengwenTwoModel alloc]init];
        //
        NSString  * ID =[set stringForColumn:@"ID"];
        if(ID.length > 0){
            //[array insertObject:ID atIndex:0];
        [array addObject:ID];
        }
    }
    return array;

    
    
    
    
    
   }

//更新数据将未标记的，标记

-(void)genxinbiaoji{
   
    NSString *updateSql = [NSString stringWithFormat:@"update joblistIDD set dabiao='1' "];
    BOOL res = [_dataBase executeUpdate:updateSql];
    
    if (!res) {
        NSLog(@"已经读取标记修改成功");
    } else {
        NSLog(@"已经读取标记修改失败");
    }
    
    
    
    
    
    
    
}







@end
