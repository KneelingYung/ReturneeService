//
//  DBMnager.m
//  UNIVERTWO
//
//  Created by 刘鑫然 on 16/5/6.
//  Copyright © 2016年 com.LiXiang. All rights reserved.
//

#import "DBMnager.h"
#import "FMDB.h"
#import "shoucangModel.h"
#import "wannengwenTwoModel.h"
#import "wannengwenOneModel.h"
#import "xiaoxiwenmodel.h"
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
        NSLog(@"%@",dbPath);
        //在改路径下创建数据库
        _dataBase = [[FMDatabase alloc]initWithPath:dbPath];
        //打开数据库
        [_dataBase open];
        //创建数据库表（招聘）
        
        // FMDatabase执行sql语句
        // 当数据库文件创建完成时，首先创建数据表，如果没有这个表，就去创建，有了就不创建
        
        NSString * creatZpSql = @"create table if not exists  zpcollection(zpId varchar(255), zpJobs varchar(255) ,zptype varchar(255), zpexperience varchar(255), zpstudy varchar(255), zpcompany varchar(255),zpcity varchar(255), zpImg varchar(255), zpdata  varchar(255))";
//
        [_dataBase executeUpdate:creatZpSql];
        
        //创建城市筛选表
        NSString * creatCitySql = @"create table if not exists citycollection(zpcity varchar(255))";
        [_dataBase executeUpdate:creatCitySql];
        
        //创建职位类型筛选表
        NSString * cratezwSql = @"create table if not exists zwcollection(zw varchar(255))";
        [_dataBase executeUpdate:cratezwSql];
        
        //创建时间筛选表
        NSString * cratedateSql = @"create table if not exists datecollection(date varchar(255))";
        
        [_dataBase executeUpdate:cratedateSql];
        
        //创建bannar表
        NSString * createbannarSql = @"create table if not exists bannarcollection(appid varchar(255), pid varchar(255), ad varchar(255), apptime varchar(255), title varchar(255), link varchar(255) ,linkid varchar(255))";
        //NSString *createbannarSql = @"create table if not exists bannarcollection()"
        [_dataBase executeUpdate:createbannarSql];
        
        //创建归国政策bannar表
        
        NSString * createGUIbannarSql = @"create table if not exists guibannarcollection(appid varchar(255), pid varchar(255), ad varchar(255), apptime varchar(255), title varchar(255), link varchar(255) ,linkid varchar(255))";
        [_dataBase executeUpdate:createGUIbannarSql];
        
        //创建归国政策表
        
        NSString * createGUISql = @"create table if not exists guicollection(appid varchar(255), img varchar(255), title varchar(255), city varchar(255), date varchar(255))";
        [_dataBase executeUpdate:createGUISql];
        //创建个人中心收藏的表
        NSString * PCshoucangGUISql = @"create table if not exists PCshoucollection(ID varchar(255),OID  varchar(255), title varchar(255),  date varchar(255),type varchar(255))";
        [_dataBase executeUpdate:PCshoucangGUISql];
        
        
    }
    //创建我的万能问收藏区的表库
    //万能问我的回答类的表
    NSString * PCwanmehuidaGUISql = @"create table if not exists PCwanmihuicollection(ID varchar(255), title varchar(255),  headimg varchar(255),name varchar(255),conten varchar(255),pls varchar(255),zan varchar(255))";
    [_dataBase executeUpdate:PCwanmehuidaGUISql];
    //创建万能问我的收藏的回答表格
    NSString * PCwanmetiwendaGUISql = @"create table if not exists PCwanmishouhuicollection(ID varchar(255), title varchar(255),  headimg varchar(255),name varchar(255),conten varchar(255),pls varchar(255),zan varchar(255))";
    [_dataBase executeUpdate:PCwanmetiwendaGUISql];
    //创建我的万能问关注的问题表格
    NSString * PCwanguanzhudaGUISql = @"create table if not exists PCwanguaznhucollection(ID varchar(255), title varchar(255),conten varchar(255),huida varchar(255),liulan varchar(255))";
    [_dataBase executeUpdate:PCwanguanzhudaGUISql];
    //创建我的万能问我的提问表格
    NSString * PCwanwentidaGUISql = @"create table if not exists PCwanwenticollection(ID varchar(255), title varchar(255),conten varchar(255),huida varchar(255),liulan varchar(255))";
    [_dataBase executeUpdate:PCwanwentidaGUISql];
    //创建消息类万能问消息表格
    NSString * PCwanxiaoxidaGUISql = @"create table if not exists PCwanxiaoxicollection(ID varchar(255), headimg varchar(255),  name varchar(255),ts varchar(255),title varchar(255),content varchar(255),date varchar(255),states varchar(255))";
    [_dataBase executeUpdate:PCwanxiaoxidaGUISql];
    //创建消息类系统消息
    NSString * PCxitongxiaoxidaGUISql = @"create table if not exists PCxitongxiaoxicollection(ID varchar(255), test varchar(255),  date varchar(255),states varchar(255))";
    [_dataBase executeUpdate:PCxitongxiaoxidaGUISql];
    return self;
    
}
//系统消息检查更新
- (BOOL)isxsitspcxitongxiaoxiWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from PCxitongxiaoxicollection where ID=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}
//系统消息去除提示点更新

-(void)isxsitspcxitongxiaoxtwojishuxinxiWithAppID {
    
    
    
    NSString * querySql = [NSString stringWithFormat:@"update PCxitongxiaoxicollection set states=1 "];
    
    [_dataBase executeUpdate:querySql];
    
}

    
    
    
    
    
    
    
    
//我的系统消息数据添加

- (void)addxitongxiaoxiCollectionModel:(NSArray *)modelarray{
    [self deleteallPCxitongxiaoxiData];
    NSString * insertZpSql = @"insert into PCxitongxiaoxicollection values (?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
        xiaoxiwenmodel  * model = modelarray[i];
        NSString * ID = [NSString stringWithFormat:@"%d",model.ID];
        NSString * states =  [NSString stringWithFormat:@"%d",model.status];
        // NSString * modelid = [NSString stringWithFormat:@"%d",model.ID];
        [_dataBase executeUpdate:insertZpSql ,ID ,model.c,model.date,states];
    }
    
    
}
//删除我的消息系统消息数据
- (void)deleteallPCxitongxiaoxiData{
    
    NSString * deletecitysql = @"delete from PCxitongxiaoxicollection";
    [_dataBase executeUpdate:deletecitysql];
}
//获取我的消息系统消息全部数据
-(NSArray *)getxitongxiaoxialldata{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from PCxitongxiaoxicollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        xiaoxiwenmodel * model = [[xiaoxiwenmodel alloc]init];
        
        NSString  * ids =[set stringForColumn:@"ID"];
        
        model.ID= [ids intValue];
        
        model.c = [set stringForColumn:@"test"];
        
        
        model.date =[set stringForColumn:@"date"];
        
      NSString * states =[set stringForColumn:@"states"];
        model.status = [states intValue];
        
        [array addObject:model];
    }
    return array;
    
}

//万能问消息检查更新
- (BOOL)isxsitspcwanxiaoxiWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from PCwanxiaoxicollection where ID=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}

//点击娃能问消息刷新更新
-(void)isxsitspcwanxiaodianjishuxinxiWithAppID:(NSString *)appid {
    
    
    
    NSString * querySql = [NSString stringWithFormat:@"update PCwanxiaoxicollection set states=1 where id=%@",appid];
    
 [_dataBase executeUpdate:querySql];
//    if ([set next]) {
//        return NO;
//    }else{
//        
//        return YES;
//    }
    
    
}
//我的娃能问消息数据添加

- (void)addwanxiaoxiCollectionModel:(NSArray *)modelarray{
    [self deleteallPCwanxiaoxiData];
    NSString * insertZpSql = @"insert into PCwanxiaoxicollection values (?,?,?,?,?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
        wannengwenTwoModel  * model = modelarray[i];
        NSString * ID = [NSString stringWithFormat:@"%d",model.oid];
        
        // NSString * modelid = [NSString stringWithFormat:@"%d",model.ID];
        [_dataBase executeUpdate:insertZpSql ,ID ,model.avatar,model.username,model.t,model.title,model.content,model.date,model.status];
    }
    
    
}
//删除我的消息万能问消息数据
- (void)deleteallPCwanxiaoxiData{
    
    NSString * deletecitysql = @"delete from PCwanxiaoxicollection";
    [_dataBase executeUpdate:deletecitysql];
}
//获取我的消息万能问消息全部数据
-(NSArray *)getwanxiaoxialldata{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from PCwanxiaoxicollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        wannengwenTwoModel * model = [[wannengwenTwoModel alloc]init];
        
        NSString  * ids =[set stringForColumn:@"ID"];
        
        model.oid = [ids intValue];
        
        model.avatar = [set stringForColumn:@"headimg"];
        
        
        model.username =[set stringForColumn:@"name"];
        model.t =[set stringForColumn:@"ts"];
       model.title =[set stringForColumn:@"title"];
        model.content =[set stringForColumn:@"content"];
        model.date =[set stringForColumn:@"date"];
        model.status =[set stringForColumn:@"states"];
              
        [array addObject:model];
    }
    return array;
    
}





//万能问我的问题检查更新
- (BOOL)isxsitspcwanwentiWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from PCwanwenticollection where ID=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}
//万能问我的问题数据添加

- (void)addwanwentiCollectionModel:(NSArray *)modelarray{
    [self deleteallPCwanwentiData];
    NSString * insertZpSql = @"insert into PCwanwenticollection values (?,?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
        wannengwenOneModel  * model = modelarray[i];
        NSString * ns = [NSString stringWithFormat:@"%d",model.hd];
        
        // NSString * modelid = [NSString stringWithFormat:@"%d",model.ID];
        [_dataBase executeUpdate:insertZpSql ,model.Id ,model.title,model.content,ns,model.n];
    }
    
    
}
//删除万能问我的问题数据
- (void)deleteallPCwanwentiData{
    
    NSString * deletecitysql = @"delete from PCwanwenticollection";
    [_dataBase executeUpdate:deletecitysql];
}
//获取万能问我的的问题全部数据
-(NSArray *)getwanwentialldata{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from PCwanwenticollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        wannengwenOneModel * model = [[wannengwenOneModel alloc]init];
        
        model.Id = [set stringForColumn:@"ID"];
        
        model.title = [set stringForColumn:@"title"];
        
        
        model.content =[set stringForColumn:@"conten"];
        model.n =[set stringForColumn:@"liulan"];
        NSString * hd =[set stringForColumn:@"huida"];
        model.hd = [hd intValue];
        //        model.zan =[set stringForColumn:@"zan"];
        //        model.pls =[set stringForColumn:@"pls"];
        
        
        
        
        
        [array addObject:model];
    }
    return array;
    
}


//万能问我的关注的问题检查更新
- (BOOL)isxsitspcwanguanzhuWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from PCwanguaznhucollection where ID=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}
//万能问我的关注的问题数据添加

- (void)addwanguanzhuCollectionModel:(NSArray *)modelarray{
    [self deleteallPCwanguanzhuData];
    NSString * insertZpSql = @"insert into PCwanguaznhucollection values (?,?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
        wannengwenOneModel  * model = modelarray[i];
        NSString * ns = [NSString stringWithFormat:@"%d",model.hd];
        
        // NSString * modelid = [NSString stringWithFormat:@"%d",model.ID];
        [_dataBase executeUpdate:insertZpSql ,model.newsid ,model.title,model.content,ns,model.n];
    }
    
    
}
//添加一条关注的问题数据
-(void)addoneguanzhuwentiwih:(wannengwenOneModel *)model{
    NSString * insertZpSql = @"insert into PCwanguaznhucollection values (?,?,?,?,?)";
    
    
        [_dataBase executeUpdate:insertZpSql ,model.Id ,model.title,model.content,model.ansnum,model.n];
    }
//取消一条关注的问题数据
-(void)quxiaoguanzhuwentionedatewith:(NSString *)ID{
    NSString * deletecitysql = [NSString stringWithFormat:@"delete from PCwanguaznhucollection where ID=%@",ID];
    [_dataBase executeUpdate:deletecitysql];
    
}
//删除万能问我的关注的问题数据
- (void)deleteallPCwanguanzhuData{
    
    NSString * deletecitysql = @"delete from PCwanguaznhucollection";
    [_dataBase executeUpdate:deletecitysql];
}
//获取万能问关注的问题全部数据
-(NSArray *)getwanaguznzhualldata{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from PCwanguaznhucollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        wannengwenOneModel * model = [[wannengwenOneModel alloc]init];
        
        model.newsid = [set stringForColumn:@"ID"];
       
        model.title = [set stringForColumn:@"title"];
        
  
        model.content =[set stringForColumn:@"conten"];
        model.n =[set stringForColumn:@"liulan"];
        NSString * hd =[set stringForColumn:@"huida"];
        model.hd = [hd intValue];
//        model.zan =[set stringForColumn:@"zan"];
//        model.pls =[set stringForColumn:@"pls"];
        
        
        
        
        
        [array addObject:model];
    }
    return array;
    
}




//万能问我的收藏的回答检查更新
- (BOOL)isxsitspcwanmishouhuiWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from PCwanmishouhuicollection where ID=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}
//万能问我的收藏的回答数据添加

- (void)addwanmishouhuiCollectionModel:(NSArray *)modelarray{
    [self deleteallPCwanmishouhuiData];
    NSString * insertZpSql = @"insert into PCwanmishouhuicollection values (?,?,?,?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
        wannengwenTwoModel  * model = modelarray[i];
        NSDictionary * dates = model.userinfo;
        NSString * nikename = dates[@"nickname"];
        NSString * headimg = dates[@"avatar"];
        
        
        // NSString * modelid = [NSString stringWithFormat:@"%d",model.ID];
        [_dataBase executeUpdate:insertZpSql ,model.Id ,model.title,headimg,nikename,model.content,model.pls,model.zan];
    }
    
    
}
//添加一条万能问收藏的回答数据
- (void)addwanmishouhuionedateCollectionModel:(wannengwenTwoModel *)model with:(NSString *)title{
    //[self deleteallPCshouData];
    NSString * insertZpSql = @"insert into PCwanmishouhuicollection values (?,?,?,?,?,?,?)";
    
       // wannengwenTwoModel  * model = modelarray[0];
        //NSDictionary * dates = model.userinfo;
        //NSString * nikename = dates[@"nickname"];
        //NSString * headimg = dates[@"avatar"];
        
        
    
        [_dataBase executeUpdate:insertZpSql ,model.Id ,model.title,model.avatar,model.username,model.content,model.pls,model.zan];
 
    
    
}






//删除万能问我的收藏的回答数据
- (void)deleteallPCwanmishouhuiData{
    
    NSString * deletecitysql = @"delete from PCwanmishouhuicollection";
    [_dataBase executeUpdate:deletecitysql];
}
//删除一条我的收藏的回答数据
- (void)deleteallPCwanmishouhuioneDatashuju:(NSString *)ID{
    NSString *deletecitysql = [NSString stringWithFormat:@"delete from PCwanmishouhuicollection where ID =%@",ID];
       [_dataBase executeUpdate:deletecitysql];
}
//获取万能问我的收藏的回答的全部数据
-(NSArray *)getwanmishouhhuialldata{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from PCwanmishouhuicollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        wannengwenTwoModel * model = [[wannengwenTwoModel alloc]init];
        
        model.pid = [set stringForColumn:@"ID"];
        //model.ID = [modelid intValue];
        model.title = [set stringForColumn:@"title"];
        
        //model.date = [set stringForColumn:@"date"];
        NSString * nickname =  [set stringForColumn:@"name"];
        NSString * headimg =  [set stringForColumn:@"headimg"];
        NSDictionary * dict = @{@"nickname":nickname,@"avatar":headimg};
        model.userinfo = dict;
        model.content =[set stringForColumn:@"conten"];
        model.zan =[set stringForColumn:@"zan"];
        model.pls =[set stringForColumn:@"pls"];
        
        
        
        
        
        [array addObject:model];
    }
    return array;
    
}






//万能问我的回答检查更新
- (BOOL)isxsitspcwanmihuiWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from PCwanmihuicollection where ID=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}
//万能问我的回答数据添加

- (void)addwanmihuiCollectionModel:(NSArray *)modelarray{
    [self deleteallPCwanmihuiData];
    NSString * insertZpSql = @"insert into PCwanmihuicollection values (?,?,?,?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
       wannengwenTwoModel  * model = modelarray[i];
        NSDictionary * dates = model.userinfo;
        NSString * nikename = dates[@"nickname"];
           NSString * headimg = dates[@"avatar"];
        
        
        // NSString * modelid = [NSString stringWithFormat:@"%d",model.ID];
        [_dataBase executeUpdate:insertZpSql ,model.Id ,model.title,headimg,nikename,model.content,model.pls,model.zan];
    }
    
    
}
//删除万能问我的回答数据
- (void)deleteallPCwanmihuiData{
    
    NSString * deletecitysql = @"delete from PCwanmihuicollection";
    [_dataBase executeUpdate:deletecitysql];
}
//获取万能问我的回答的全部数据
-(NSArray *)getwanmihuialldata{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from PCwanmihuicollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        wannengwenTwoModel * model = [[wannengwenTwoModel alloc]init];
        
        model.Id = [set stringForColumn:@"ID"];
        //model.ID = [modelid intValue];
        model.title = [set stringForColumn:@"title"];
        
        //model.date = [set stringForColumn:@"date"];
        NSString * nickname =  [set stringForColumn:@"name"];
         NSString * headimg =  [set stringForColumn:@"headimg"];
        NSDictionary * dict = @{@"nickname":nickname,@"avatar":headimg};
        model.userinfo = dict;
        model.content =[set stringForColumn:@"conten"];
        model.zan =[set stringForColumn:@"zan"];
        model.pls =[set stringForColumn:@"pls"];
        
        
        
        
        
        [array addObject:model];
    }
    return array;
    
}




//收藏检查更新
- (BOOL)isxsitspcshouWithAppID:(NSString *)appid{
    NSLog(@"%@",appid);
    
    NSString * querySql = [NSString stringWithFormat:@"select *from PCshoucollection where ID=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}

//收藏数据添加

- (void)addpcshouCollectionModel:(NSArray *)modelarray{
    [self deleteallPCshouData];
    NSString * insertZpSql = @"insert into PCshoucollection values (?,?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
        zhaopingModel * model = modelarray[i];
       // NSString * modelid = [NSString stringWithFormat:@"%d",model.ID];
        [_dataBase executeUpdate:insertZpSql ,model.ID ,model.OID, model.title,model.date,model.type];
    }
    
    
}
//添加一条个人中心收藏消息
-(void)addondateshoucang:(zhaopingModel * )model withoid:(NSString *)oid
{
     NSString * insertZpSql = @"insert into PCshoucollection values (?,?,?,?,?)";
    //zhaopingModel * model = modelarray[i];
    // NSString * modelid = [NSString stringWithFormat:@"%d",model.ID];
    [_dataBase executeUpdate:insertZpSql ,model.Id ,oid, model.fx,model.date,model.type];
}


//删除收藏数据哭
- (void)deleteallPCshouData{
    
    NSString * deletecitysql = @"delete from PCshoucollection";
    [_dataBase executeUpdate:deletecitysql];
}
//删除某一条收藏数据
-(void)selectshoucangonedatawith:(NSString * ) OID{
    NSString * deletecitysql = @"delete from PCshoucollection where OID =?";
    [_dataBase executeUpdate:deletecitysql,OID];
    
}
//获取收藏的全部数据
-(NSArray *)getshoucangalldata{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from PCshoucollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        zhaopingModel * model = [[zhaopingModel alloc]init];
    
      model.Id = [set stringForColumn:@"ID"];
        model.OID =[set stringForColumn:@"OID"];
        
        //model.ID = [modelid intValue];
        model.title = [set stringForColumn:@"title"];
       
        model.date = [set stringForColumn:@"date"];
        model.type = [set stringForColumn:@"type"];

        
        [array addObject:model];
    }
    return array;
    
}

//检测归国政策信息是否有更新
- (BOOL)isxsitsguiWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from guicollection where zpid=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}
//获取归国政策的所有信息
- (NSArray *)fetchAllguiData{
    
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from guicollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        searchModeltwo * model = [[searchModeltwo alloc]init];
        model.Id = [set stringForColumn:@"appid"];
        model.pic = [set stringForColumn:@"img"];
        model.title = [set stringForColumn:@"title"];
        model.city = [set stringForColumn:@"city"];
        model.date = [set stringForColumn:@"date"];
        
        [array addObject:model];
    }
    return array;
    
    
    
    
}

//添加数据
- (void)addguiCollectionModel:(NSArray *)modelarray{
    [self deleteallguiData];
    NSString * insertZpSql = @"insert into guicollection values (?,?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
        searchModeltwo * model = modelarray[i];
        [_dataBase executeUpdate:insertZpSql ,model.Id ,model.pic, model.title , model.city,model.date];
    }
    
    
}
- (void)deleteallguiData{
    
    NSString * deletecitysql = @"delete from guicollection ";
    [_dataBase executeUpdate:deletecitysql];
}
//检测招聘信息是否有更新
- (BOOL)isxsitsWithAppID:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from zpcollection where zpid=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
    
}
//检查归国政策bannar是否有更新
- (BOOL)isesitsguibannarid:(NSString *)appid{
    NSString * querySql = [NSString stringWithFormat:@"select *from guibannarcollection where id=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }

    
}
//删除归国政策bannar
- (void)deletebannarguiCollectionModel{
    
    NSString * deletecitysql = @"delete from guibannarcollection";
    [_dataBase executeUpdate:deletecitysql];
    
}
//检查bannar是否有更新
- (BOOL)isesitsbannarid:(NSString *)appid{
    
    NSString * querySql = [NSString stringWithFormat:@"select *from bannarcollection where id=%@",appid];
    FMResultSet * set = [_dataBase executeQuery:querySql];
    if ([set next]) {
        return NO;
    }else{
        
        return YES;
    }
    
}

//获取bannar所有信息
- (NSArray *)fetchAllguiBannarData{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from guibannarcollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        bannarModel * model = [[bannarModel alloc]init];
        model.Id = [set stringForColumn:@"id"];
        model.pid = [set stringForColumn:@"pid"];
        model.ad = [set stringForColumn:@"ad"];
        model.time = [set stringForColumn:@"time"];
        model.title = [set stringForColumn:@"title"];
        model.link = [set stringForColumn:@"link"];
        model.linkid = [set stringForColumn:@"linkid"];
        [array addObject:model];
    }
    return array;
    
    
}
//向数据归国bannar标中添加数据
- (void)addBannarguiCollectionModel:(NSArray *)bannarArray{
    [self deletebannarCollectionModel];
    
    
    NSString * insertZpSql = @"insert into guibannarcollection values (?,?,?,?,?,?,?)";
    for (int i = 0; i< bannarArray.count; i++) {
        bannarModel * model = bannarArray[i];
        NSLog(@"%@",model.Id);
        [_dataBase executeUpdate:insertZpSql ,model.Id,model.pid,model.ad,model.time,model.title,model.link,model.linkid ];
    }
    
    
}
//向招聘表中添加数据
- (void)addzpCollectionModel:(NSArray *)modelarray{
    [self deleteallData];
    NSString * insertZpSql = @"insert into zpcollection values (?,?,?,?,?,?,?,?,?)";
    for (int i = 0; i< modelarray.count; i++) {
        zhaopingModel * model = modelarray[i];
        [_dataBase executeUpdate:insertZpSql ,model.Id ,model.jobs, model.type , model.experience, model.study,model.company, model.city, model.img , model.date ];
    }
    
    
}
//删除招聘表中的所有数据
- (void)deleteallData{
    NSString * deleteZpsql = @"delete from zpcollection";
    [_dataBase executeUpdate:deleteZpsql];
    
    
}
//获取招聘的所有信息
- (NSArray *)fetchAllzpData{
    
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from zpcollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {

        zhaopingModel * model = [[zhaopingModel alloc]init];
        model.Id = [set stringForColumn:@"zpId"];
        model.jobs = [set stringForColumn:@"zpJobs"];
        model.type = [set stringForColumn:@"zptype"];
        model.experience = [set stringForColumn:@"zpexperience"];
        model.study = [set stringForColumn:@"zpstudy"];
        model.company = [set stringForColumn:@"zpcompany"];
        model.city = [set stringForColumn:@"zpcity"];
        model.img = [set stringForColumn:@"zpImg"];
        model.date = [set stringForColumn:@"zpdata"];
        [array addObject:model];
    }
    return array;

    
    
    
}

//获取bannar所有信息
- (NSArray *)fetchAllBannarData{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from bannarcollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        bannarModel * model = [[bannarModel alloc]init];
        model.Id = [set stringForColumn:@"id"];
        model.pid = [set stringForColumn:@"pid"];
        model.ad = [set stringForColumn:@"ad"];
        model.time = [set stringForColumn:@"time"];
        model.title = [set stringForColumn:@"title"];
        model.link = [set stringForColumn:@"link"];
        model.linkid = [set stringForColumn:@"linkid"];
        [array addObject:model];
    }
    return array;
    
    
}
//向数据库bannar标中添加数据
- (void)addBannarCollectionModel:(NSArray *)bannarArray{
    [self deletebannarCollectionModel];


    NSString * insertZpSql = @"insert into bannarcollection values (?,?,?,?,?,?,?)";
    for (int i = 0; i< bannarArray.count; i++) {
        bannarModel * model = bannarArray[i];
        NSLog(@"%@",model.Id);
        [_dataBase executeUpdate:insertZpSql ,model.Id,model.pid,model.ad,model.time,model.title,model.link,model.linkid ];
    }
    
    
}

//删除数据库中所有bannar信息
- (void)deletebannarCollectionModel{
    
    NSString * deletecitysql = @"delete from bannarcollection";
    [_dataBase executeUpdate:deletecitysql];
    
}
//向城市表中添加数据
- (void)addCityMessageArray:(NSArray *)array{
    [self deletecityMessage];
    for (int i = 0; i < array.count; i++) {
        NSString * insertZpSql = @"insert into citycollection values (?)";
        
        [_dataBase executeUpdate:insertZpSql ,array[i] ];
        
    }
    
    
}
//获取所有城市信息
- (NSArray *)fetchALLcitySxdata{
    
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from citycollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        NSString * string = [set stringForColumn:@"zpcity"];
        [array addObject:string];
    }
    return array;


    
}
//删除城市筛选表中所有数据
- (void)deletecityMessage{
    NSString * deletecitysql = @"delete * from citycollection";
    [_dataBase executeUpdate:deletecitysql];
    
}
//检查城市筛选是否有更新
- (BOOL)iscityesitscityArray:(NSArray *)array{
    NSArray * cityArray  = [self fetchALLcitySxdata];
    if (cityArray.count != array.count) {
        return YES;
    }else{
        BOOL YESorNo = YES;
        for (int i = 0; i< cityArray.count; i++) {
            if ([cityArray[i] isEqualToString:array[i]]) {
                YESorNo = NO;
                continue;
            }else{
                YESorNo = YES;
                break;
                
            }
        }
        return YESorNo;
    }
    
}
//向职位筛选表中添加数据
- (void)addzwMessagearray:(NSArray *)array{
    [self deteleZWmessage];
    for (int i = 0; i < array.count; i++) {
        NSString * insertZpSql = @"insert into zwcollection values (?)";
        
        [_dataBase executeUpdate:insertZpSql ,array[i] ];
        
    }
    
    
}
//获取所有职位信息
- (NSArray *)fetchAllzwSxData{
    
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from zwcollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        NSString * string = [set stringForColumn:@"zw"];
        [array addObject:string];
    }
    return array;
}
//检测职位是否有更新
- (BOOL)isZwesitscityArray:(NSArray *)array{
    NSArray * cityArray  = [self fetchAllzwSxData];
    if (cityArray.count != array.count) {
        return YES;
    }else{
        BOOL YESorNo = YES;
        for (int i = 0; i< cityArray.count; i++) {
            if ([cityArray[i] isEqualToString:array[i]]) {
                YESorNo = NO;
                continue;
            }else{
                YESorNo = YES;
                break;
                
            }
        }
        return YESorNo;
    }
    
}
//删除职位筛选表中的所有数据
- (void)deteleZWmessage{
    
    NSString * deletezwsql = @"delete * from zwcollection";
    [_dataBase executeUpdate:deletezwsql];
}


- (void)adddatemessagearray:(NSArray *)array{
    
    [self deletedatemessage];
    for (int i = 0; i < array.count; i++) {
        NSString * insertZpSql = @"insert into datecollection values (?)";
        
        [_dataBase executeUpdate:insertZpSql ,array[i] ];
        
    }
    
    
}
//获取所有时间筛选信息
- (NSArray *)fetchAllDateData{
    // 找出Collection表中所有的数据
    NSString * fetchSql = @"select * from datecollection";
    
    // 执行sql
    FMResultSet * set = [_dataBase executeQuery:fetchSql];
    
    // 循环遍历取出数据
    NSMutableArray * array = [[NSMutableArray alloc] init];
    while ([set next]) {
        
        NSString * string = [set stringForColumn:@"date"];
        [array addObject:string];
    }
    return array;
    
    
}

- (BOOL)isDateesitscityArray:(NSArray *)array{
    NSArray * cityArray  = [self fetchAllDateData];
    if (cityArray.count != array.count) {
        return YES;
    }else{
        BOOL YESorNo = YES;
        for (int i = 0; i< cityArray.count; i++) {
            if ([cityArray[i] isEqualToString:array[i]]) {
                YESorNo = NO;
                continue;
            }else{
                YESorNo = YES;
                break;
                
            }
        }
        return YESorNo;
    }
    
}
//删除时间筛选表中的所有数据
- (void)deletedatemessage{
    NSString * deletedatesql = @"delete * from datecollection";
    [_dataBase executeUpdate:deletedatesql];
    
}
@end
