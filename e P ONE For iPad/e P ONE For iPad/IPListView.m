//
//  IPListView.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/6/7.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "IPListView.h"

@implementation IPListView
{
    NSMutableArray *ipModelArr;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withIPModelArr:(NSMutableArray *)array{
   self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        ipModelArr = array;
        [self createTitleView];
        
        _listTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, self.frame.size.height)];
        _listTabelView.delegate = self;
        _listTabelView.dataSource = self;
        _listTabelView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_listTabelView];
    }
    return self;
    
    
    
    return self;
    
}
-(void)createTitleView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titleView];
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(titleView.frame.size.width/3, 0, 1, titleView.frame.size.height)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(titleView.frame.size.width/3*2, 0, 1, titleView.frame.size.height)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 59, titleView.frame.size.width, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView3];
    
    UILabel *nameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, 60)];
    nameTitleLabel.text = @"名称";
    nameTitleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:nameTitleLabel];
    UILabel *IPTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/3, 0, self.frame.size.width/3, 60)];
    IPTitleLabel.text = @"IP地址";
    IPTitleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:IPTitleLabel];
    UILabel *stateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/3*2, 0, self.frame.size.width/3, 60)];
    stateTitleLabel.text = @"状态";
    stateTitleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:stateTitleLabel];
    
    
    
    
    
    
    
}
#pragma mark uitableviewDelegate
//设置section表头内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"";
    
}
//row  高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
//组 高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
    
    
}
//底视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}
//row数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ipModelArr.count;
    
    
}
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
//cell 布局
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellname = @"cellname1";
    IPListViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellname];
    if(!cell){
        
        cell = [[IPListViewTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellname];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    IPModel *ipModel = [ipModelArr objectAtIndex:indexPath.row];
    cell.nameLabel.text = ipModel.name;
    cell.addressLable.text = ipModel.address;
    cell.stateLable.text  = @"检测中...";
    
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([projectIP isEqualToString:@"http://(null)"]|| projectIP.length < 8) {
            
        }else{
            NSString *urlStr =
            [projectIP stringByAppendingString:@"/api/pingAddress.php"];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:ipModel.address forKey:@"address"];
            [DNSRequestData requestURL:urlStr httpMethod:@"GET" params:params file:nil progress:^(NSProgress *loadProgress) {
                NSLog(@"/api/regionsprogress:%@",loadProgress);
            } success:^(id data) {
                NSLog(@"/api/regionssuccess:%@",data);
                if ([[data objectForKey:@"result"]isEqualToString:@"success"]) {
                    NSMutableDictionary *infoDic = [data objectForKey:@"info"];
                    if ([[infoDic objectForKey:@"state"] integerValue] == 0) {
                        NSLog(@"不在线");
                        cell.stateLable.text = @"不在线";
                    }else{
                        NSLog(@"在线");
                        cell.stateLable.text = @"在线";
                    }
                }
                
            } fail:^(NSError *error) {
                NSLog(@"/api/regionsfail:%@",error);
            }];
        }

    });
    
    return cell;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
