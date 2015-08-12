
/* 14-12-8:创建
 *
 */

#import "QTDataCenter.h"
#import "FMDatabase.h"

@interface DataFromWeb :NSObject <NSURLConnectionDataDelegate>
@property (nonatomic, copy) void(^success)(NSData *);
@end
@implementation DataFromWeb {
    NSMutableData *_data;
}
- (void)dataFromUrl:(NSString *)url {
    _data = [[NSMutableData alloc]init];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_data setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _success(_data);
}
@end

@implementation QTDataCenter {
    @private
    NSString   *_DBPath;
    FMDatabase *_DBMngr;
    
}
+ (id)sharedDataCenter {
    static QTDataCenter *dc = nil;
    if (!dc) {
        dc = [[QTDataCenter alloc]init];
    }
    return dc;
}
- (id)init {
    self = [super init];
    if (self) {
        NSString *DBPath = [[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"mydb.db"];
        _DBPath = DBPath;
        _DBMngr = [[FMDatabase alloc]initWithPath:DBPath];
        if ([_DBMngr open]) {
            NSString *sql = @"create table if not exists reserveRecord(id integer primary key autoincrement, doct varchar(32), dept varchar (80), hosp varchar(160), date varchar(16), time varchar(8), mony varchar(32), name varchar(32), phon varchar(160), card varchar(180), ptnCard varchar(180), ptnPswd varchar(180));";
            [_DBMngr executeUpdate:sql];
            NSLog(@"%@", _DBPath);
        }
    }
    return self;
}
- (void)dataFromUrl:(NSString *)url success:(void(^)(NSData *))success {
    DataFromWeb *web = [[DataFromWeb alloc]init];
    [web setSuccess:success];
    [web dataFromUrl:url];
}
- (void)insertDataFromArray:(NSArray *)array {
    NSString *sql = @"insert into reserveRecord(doct, dept, hosp, date, time, mony, name, card, phon, ptnCard, ptnPswd) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
    [_DBMngr executeUpdate:sql, array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10]];
}

@end
