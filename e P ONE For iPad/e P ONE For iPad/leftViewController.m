//
//  leftViewController.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/9.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "leftViewController.h"

// 背景蓝
#define BACK_BLUE_COLOR [UIColor colorWithRed:0/255.0 green:74/255.0  blue:151/255.0 alpha:1.0]
@interface leftViewController ()
{
    AFHTTPSessionManager *manager;
    NSMutableArray *areaListArray ;
    UIImageView *titleImageView;
    
    
    NSIndexPath *current;
    NSInteger recordRow;
    
    UIView *IPview;
    UIView *bgView;
    
    UIButton *setIPButton;
    UIButton *stateButton;
}
@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *topHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,300,44)];
    
    topHeadView.backgroundColor = [UIColor clearColor];
    titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,180,25)];
    
    titleImageView.image = [UIImage imageNamed:@"PURENFORT.png"];
    titleImageView.center = topHeadView.center;
    titleImageView.userInteractionEnabled = YES;
    [topHeadView addSubview:titleImageView];
    self.navigationItem.titleView = topHeadView;
    // 双击logo 弹出对话框
    //UITapGestureRecognizer *singleTapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
   // singleTapTwo.numberOfTouchesRequired = 1;
   // singleTapTwo.numberOfTapsRequired = 2;
//    singleTapTwo.delegate = self;
   // [titleImageView addGestureRecognizer:singleTapTwo];

    NSLog(@"git test");
    
    self.navigationController.navigationBar.translucent = NO;
    self.splitViewController.maximumPrimaryColumnWidth = 300;
    self.splitViewController.preferredPrimaryColumnWidthFraction = 0.5;
    // Do any additional setup after loading the view from its nib.
    areaListArray = [NSMutableArray array];
    
    _listTabelView.delegate = self;
    _listTabelView.dataSource = self;
    [self getAreaListDataWithIndex:0];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"getListData" object:nil];
    
    _fourButtonView.sd_layout
    .topSpaceToView(_listTabelView, 0);
    
    recordRow = 0;
    
    
    
    [self createFourButton];
    

}
-(void)createFourButton{
    setIPButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [setIPButton setBackgroundImage:[UIImage imageNamed:@"setIP1"] forState:UIControlStateNormal];
    setIPButton.tag = 2001;
    [setIPButton setBackgroundImage:[UIImage imageNamed:@"setIP2"] forState:UIControlStateHighlighted];
    [setIPButton addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fourButtonView addSubview:setIPButton];
    
    stateButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [stateButton setBackgroundImage:[UIImage imageNamed:@"state1"] forState:UIControlStateNormal];
    stateButton.tag = 2002;
    [stateButton setBackgroundImage:[UIImage imageNamed:@"state2"] forState:UIControlStateHighlighted];
    [stateButton addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fourButtonView addSubview:stateButton];
    
    UIButton *stateButton1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [stateButton1 setBackgroundImage:[UIImage imageNamed:@"state1"] forState:UIControlStateNormal];
    [stateButton1 setBackgroundImage:[UIImage imageNamed:@"state2"] forState:UIControlStateHighlighted];
    [_fourButtonView addSubview:stateButton1];
    
    UIButton *stateButton2 =[UIButton buttonWithType:UIButtonTypeCustom];
    [stateButton2 setBackgroundImage:[UIImage imageNamed:@"state1"] forState:UIControlStateNormal];
    [stateButton2 setBackgroundImage:[UIImage imageNamed:@"state2"] forState:UIControlStateHighlighted];
    [_fourButtonView addSubview:stateButton2];
    
    _fourButtonView.sd_equalWidthSubviews = @[setIPButton, stateButton,stateButton1,stateButton2];
    
    setIPButton.sd_layout
    .leftSpaceToView(_fourButtonView, 40)
    .topSpaceToView(_fourButtonView, 15)
    .autoHeightRatio(1);
    
    stateButton1.sd_layout
    .leftSpaceToView(setIPButton, 40)
    .topEqualToView(setIPButton)
    .heightRatioToView(setIPButton, 1);
    
    stateButton2.sd_layout
    .leftSpaceToView(stateButton1, 40)
    .topEqualToView(stateButton1)
    .heightRatioToView(stateButton1, 1);
    
    stateButton.sd_layout
    .leftSpaceToView(stateButton2, 40)
    .rightSpaceToView(_fourButtonView, 40)
    .topEqualToView(stateButton2)
    .heightRatioToView(stateButton2, 1);
    
    
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.view.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}
/**
 左视图下方4个按钮方法
 2001 设置IP地址
 2002 查看IP地址在线状态
 2003
 2004
 */
-(void)fourButtonAction:(UIButton *)button{
    if (button.tag == 2001) {
        NSLog(@"设置ip地址");
        [setIPButton setBackgroundImage:[UIImage imageNamed:@"setIP2"] forState:UIControlStateNormal];
        [setIPButton setBackgroundImage:[UIImage imageNamed:@"setIP1"] forState:UIControlStateHighlighted];
        [self createIPView];
    }else if(button.tag == 2002){
        NSLog(@"查看ip列表状态");
        [stateButton setBackgroundImage:[UIImage imageNamed:@"state2"] forState:UIControlStateNormal];
        [stateButton setBackgroundImage:[UIImage imageNamed:@"state1"] forState:UIControlStateHighlighted];
        [self getIPListData];
        
    }
}
-(void)createIPListViewWith:(NSMutableArray *)ipModelarr{
    
    bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    [self.splitViewController.view addSubview:bgView];
    bgView.sd_layout
    .centerXEqualToView(self.splitViewController.view)
    .centerYEqualToView(self.splitViewController.view)
    .widthRatioToView(self.splitViewController.view, 1)
    .heightRatioToView(self.splitViewController.view, 1);
    UITapGestureRecognizer *singleTapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IPListVIewBGViewTap:)];
    singleTapTwo.numberOfTouchesRequired = 1;
    singleTapTwo.numberOfTapsRequired = 1;
    //    singleTapTwo.delegate = self;
    [bgView addGestureRecognizer:singleTapTwo];
    
    _iPListView = [[IPListView alloc] initWithFrame:CGRectMake(150, 100, self.splitViewController.view.frame.size.width-300, self.splitViewController.view.frame.size.height-200) withIPModelArr:ipModelarr];
    [self.splitViewController.view addSubview:_iPListView];
}
-(void)notice:(NSNotification *)sender{
    
//    areaListModel *areaModel = sender.object;
    NSLog(@"%@",sender.object);
    [self  getAreaListDataWithIndex:[sender.object integerValue]];

}
//请求数据时按钮禁止
-(void)allButtonEnabledWith:(BOOL)buttonBool{
    titleImageView.userInteractionEnabled = buttonBool;
    _listTabelView.userInteractionEnabled = buttonBool;
    NewRightViewController *rightVC = (NewRightViewController *)self.splitViewController.delegate;
    rightVC.navigationItem.rightBarButtonItem.enabled = buttonBool;
    rightVC.CenterCollection.userInteractionEnabled = buttonBool;
}
//获取区域列表
-(void)getAreaListDataWithIndex:(NSInteger )row{
     NewRightViewController *rightVC = (NewRightViewController *)self.splitViewController.delegate;
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    
    if ([projectIP isEqualToString:@"http://(null)"]|| projectIP.length < 8) {
        [self createIPView];
    }else{
        NSString *urlStr =
        [projectIP stringByAppendingString:@":8000/api/regions"];
//        [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        manager = [DNSRequestData requestURL:urlStr httpMethod:@"GET" params:params file:nil progress:^(NSProgress *loadProgress) {
            NSLog(@"/api/regionsprogress:%@",loadProgress);
        } success:^(id data) {
            NSLog(@"/api/regionssuccess:%@",data);
            if ([[data objectForKey:@"desc"] isEqualToString:@"OK"]) {
                [areaListArray removeAllObjects];
                NSMutableArray *regionsArr = [data objectForKey:@"regions"];
                NSMutableArray *timeNotNowArr = [NSMutableArray array];
                for (NSMutableDictionary *regionsDic in regionsArr) {
                    areaListModel *areaModel = [[areaListModel alloc] init];
                    if ([[regionsDic objectForKey:@"airdata"] isKindOfClass:[NSNull class]]) {
                        areaModel.areaID=[NSString stringWithFormat:@"%@",[regionsDic objectForKey:@"id"]];
                        areaModel.areaName=[NSString stringWithFormat:@"%@",[regionsDic objectForKey:@"name"]];
                        
                        
                        if (areaModel.time.length<10) {
                            [timeNotNowArr addObject:areaModel];
                        }else{
                            if ([self getTimeForNowWith:areaModel.time]) {
                                
                                [areaListArray addObject:areaModel];
                            }else{
                                [timeNotNowArr addObject:areaModel];
                            }
                        }
                    }else{
                        NSMutableDictionary *airdataDic = [regionsDic objectForKey:@"airdata"];
                        
                        areaModel.areaID=[NSString stringWithFormat:@"%@",[regionsDic objectForKey:@"id"]];
                        areaModel.areaName=[NSString stringWithFormat:@"%@",[regionsDic objectForKey:@"name"]];
                        areaModel.temp =[NSString stringWithFormat:@"%.1f",[[[airdataDic objectForKey:@"data"] objectAtIndex:1]floatValue]/10];
                        areaModel.humi =[NSString stringWithFormat:@"%.1f",[[[airdataDic objectForKey:@"data"] objectAtIndex:2]floatValue]/10];
                        areaModel.hcho =[NSString stringWithFormat:@"%@",[[airdataDic objectForKey:@"data"] objectAtIndex:5]];
                        areaModel.co2 =[NSString stringWithFormat:@"%@",[[airdataDic objectForKey:@"data"] objectAtIndex:0]];
                        areaModel.voc =[NSString stringWithFormat:@"%@",[[airdataDic objectForKey:@"data"] objectAtIndex:6]];
                        areaModel.pm25 =[NSString stringWithFormat:@"%@",[[airdataDic objectForKey:@"data"] objectAtIndex:3]];
                        areaModel.pm10 =[NSString stringWithFormat:@"%@",[[airdataDic objectForKey:@"data"] objectAtIndex:4]];
                        areaModel.time =[NSString stringWithFormat:@"%@",[airdataDic objectForKey:@"time"]];

                        if (areaModel.time.length<10) {
                             [timeNotNowArr addObject:areaModel];
                        }else{
                            if ([self getTimeForNowWith:areaModel.time]) {
                                
                                [areaListArray addObject:areaModel];
                            }else{
                                [timeNotNowArr addObject:areaModel];
                            }
                        }
                        
                        
                    }
                }
                [areaListArray addObjectsFromArray:timeNotNowArr];
            }
            [_listTabelView reloadData];
            
            
            [rightVC.headView removeFromSuperview];
            rightVC.headView = nil;
            
            areaListModel *areaModel = [areaListArray objectAtIndex:row];
            
            rightVC.customLab.text = areaModel.areaName;
            rightVC.cellIndexpathRow = [NSString stringWithFormat:@"%d",row];
            rightVC.areaModel = areaModel;
            if (!areaModel.temp) {
                
            }else{
                [rightVC createSevenView];
            }
            
            if ([projectIP isEqualToString:@"http://210.13.100.190"]) {
                [rightVC.MCBarView removeFromSuperview];
                rightVC.MCBarView = nil;
                [rightVC.smartView removeFromSuperview];
                rightVC.smartView = nil;
            }else{
                [rightVC.MCBarView removeFromSuperview];
                rightVC.MCBarView = nil;
                if (!areaModel.temp) {
                    [self allButtonEnabledWith:YES];
                }else{
                    [self getDetailAirDataWithRegion:areaModel.areaID];
                }
                
                [rightVC.smartView removeFromSuperview];
                [rightVC.smartModelArr removeAllObjects];
                [self getDevicesDataWithRegion:areaModel.areaID];
            }
            
            
        } fail:^(NSError *error) {
            NSLog(@"/api/regionsfail:%@",error);
        }];
    }
    
}
//获取设备控制列表
-(void)getDevicesDataWithRegion:(NSString *)regionStr{
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    
    if ([projectIP isEqualToString:@"http://(null)"]|| projectIP.length < 8) {
        [self createIPView];
    }else{
        NSString *urlStr =
        [projectIP stringByAppendingString:@":8000/api/devices"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:regionStr forKey:@"region"];
        manager = [DNSRequestData requestURL:urlStr httpMethod:@"GET" params:params file:nil progress:^(NSProgress *loadProgress) {
            NSLog(@":8000/api/devicesProgress:%@",loadProgress);
        } success:^(id data) {
            NSLog(@":8000/api/devicesSuccess:%@",data);

            if ([[data objectForKey:@"desc"]isEqualToString:@"OK"]) {
                NSMutableArray *devicesArr = [data objectForKey:@"devices"];
                if (devicesArr.count== 0) {
                    NSLog(@"没有设备");
                }else{
                    NSMutableArray *SmartArray = [NSMutableArray array];
                    for (NSMutableDictionary *deviceDic in devicesArr) {
                        SmartModel *smart= [[SmartModel alloc] init];
                        smart.category = [NSString stringWithFormat:@"%@",[deviceDic objectForKey:@"category"]];
                        smart.ctldata = [NSString stringWithFormat:@"%@",[deviceDic objectForKey:@"ctldata"]];
                        smart.ctltype = [NSString stringWithFormat:@"%@",[deviceDic objectForKey:@"ctltype"]];
                        smart.name = [NSString stringWithFormat:@"%@",[deviceDic objectForKey:@"name"]];
                        smart.ID = [NSString stringWithFormat:@"%@",[deviceDic objectForKey:@"id"]];
                        [SmartArray addObject:smart];
                    }
                    NewRightViewController *rightVC = (NewRightViewController *)self.splitViewController.delegate;
                    rightVC.smartModelArr = SmartArray;
                    [rightVC.smartView removeFromSuperview];
                    rightVC.smartView = nil;
                    [rightVC createSmartTableView];
                }
            }
            
            
        } fail:^(NSError *error) {
            NSLog(@":8000/api/devicesFail:%@",error);
        }];
    }
}
//获取详细数据
-(void)getDetailAirDataWithRegion:(NSString *)reginonStr{
    
    [self allButtonEnabledWith:NO];
    
    
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    
    if ([projectIP isEqualToString:@"http://(null)"]|| projectIP.length < 8) {
        [self createIPView];
    }else{
        NSString *urlStr =
        [projectIP stringByAppendingString:@"/api/datagram.php"];
        //        [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:reginonStr forKey:@"region"];
        [params setObject:@"300" forKey:@"interval"];
        manager = [DNSRequestData requestURL:urlStr httpMethod:@"GET" params:params file:nil progress:^(NSProgress *loadProgress) {
            NSLog(@"/api/deatagram.phpProgress:%@",loadProgress);
        } success:^(id data) {
            [self allButtonEnabledWith:YES];
            NSLog(@"/api/deatagram.phpSuccess:%@",data);
            if ([[data objectForKey:@"result"] isEqualToString:@"success"]) {
                NSMutableArray *infoArr = [data objectForKey:@"info"];
                NSMutableArray *tempDetailArr = [infoArr objectAtIndex:1];
                NSMutableArray *humiDetailArr = [infoArr objectAtIndex:2];
                NSMutableArray *hchoDetailArr = [infoArr objectAtIndex:5];
                NSMutableArray *co2DetailArr = [infoArr objectAtIndex:0];
                NSMutableArray *vocDetailArr = [infoArr objectAtIndex:6];
                NSMutableArray *pm25DetailArr = [infoArr objectAtIndex:3];
                NSMutableArray *pm10DetailArr = [infoArr objectAtIndex:4];
                
                NewRightViewController *rightVC = (NewRightViewController *)self.splitViewController.delegate;                
                rightVC.tempDetailArr = tempDetailArr;
                rightVC.humiDetailArr = humiDetailArr;
                rightVC.hchoDetailArr = hchoDetailArr;
                rightVC.co2DetailArr = co2DetailArr;
                rightVC.vocDetailArr = vocDetailArr;
                rightVC.pm25DetailArr = pm25DetailArr;
                rightVC.pm10DetailArr = pm10DetailArr;
                [rightVC createBarView];
//                [rightVC.detailTableView reloadData];
            }

        } fail:^(NSError *error) {
            [self allButtonEnabledWith:YES];
            NSLog(@"/api/deatagram.phpFail:%@",error);
        }];
    }
    
}
/**
 获取要检测是否在线IP列表
 */
-(void)getIPListData{
    NSString *projectIP =[NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    
    if ([projectIP isEqualToString:@"http://(null)"]|| projectIP.length < 8) {
        [self createIPView];
    }else{
        NSString *urlStr =
        [projectIP stringByAppendingString:@"/api/projectAllMcp.php"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        manager = [DNSRequestData requestURL:urlStr httpMethod:@"GET" params:params file:nil progress:^(NSProgress *loadProgress) {
            NSLog(@"/api/regionsprogress:%@",loadProgress);
        } success:^(id data) {
            NSLog(@"/api/regionssuccess:%@",data);
            if ([[data objectForKey:@"result"]isEqualToString:@"success"]) {
                NSMutableArray *ipModelArr = [NSMutableArray array];
                NSMutableArray *infoArr =[data objectForKey:@"info"];
                for (NSMutableDictionary *dic in infoArr) {
                    IPModel *ipModel = [[IPModel alloc] init];
                    ipModel.name = [dic objectForKey:@"name"];
                    ipModel.ID = [dic objectForKey:@"id"];
                    ipModel.serial = [dic objectForKey:@"serial"];
                    ipModel.address = [dic objectForKey:@"address"];
                    
                    [ipModelArr addObject:ipModel];
                    
                }
                [self createIPListViewWith:ipModelArr];
                
                
            }
            
            
            
        } fail:^(NSError *error) {
            NSLog(@"/api/regionsfail:%@",error);
        }];
    }
}

/**
 出现IPList列表时 单击背景退出列表
 */
-(void)IPListVIewBGViewTap:(UITapGestureRecognizer *)sender{
    [stateButton setBackgroundImage:[UIImage imageNamed:@"state1"] forState:UIControlStateNormal];
    [stateButton setBackgroundImage:[UIImage imageNamed:@"state2"] forState:UIControlStateHighlighted];
    [bgView removeFromSuperview];
    bgView = nil;
    [_iPListView removeFromSuperview];
    _iPListView = nil;
}

/**
 出现填写IP地址时 点击背景 收回历史IP地址下拉框

 */
- (void)handleOneTap:(UITapGestureRecognizer *)sender {
    NSLog(@"单击击");
    [_dropdownList setShowDropList:NO];
    
}

/**
 弹出输入Ip地址的View
 */
-(void)createIPView{
    bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    [self.splitViewController.view addSubview:bgView];
    bgView.sd_layout
    .centerXEqualToView(self.splitViewController.view)
    .centerYEqualToView(self.splitViewController.view)
    .widthRatioToView(self.splitViewController.view, 1)
    .heightRatioToView(self.splitViewController.view, 1);
    UITapGestureRecognizer *singleTapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOneTap:)];
    singleTapTwo.numberOfTouchesRequired = 1;
    singleTapTwo.numberOfTapsRequired = 1;
    //    singleTapTwo.delegate = self;
    [bgView addGestureRecognizer:singleTapTwo];
    
    
    IPview = [[UIView alloc] init];
    IPview.backgroundColor = [UIColor whiteColor];
    IPview.layer.cornerRadius = 20;
    IPview.layer.masksToBounds = YES;
    [self.splitViewController.view addSubview:IPview];
    
    [IPview addGestureRecognizer:singleTapTwo];
    IPview.sd_layout
    .topSpaceToView(self.splitViewController.view, 100)
    .centerXEqualToView(self.splitViewController.view)
    .widthIs(300)
    .heightIs(180);
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [IPview addSubview:lineView1];
    lineView1.sd_layout
    .leftSpaceToView(IPview, 0)
    .rightSpaceToView(IPview, 0)
    .heightIs(1)
    .widthRatioToView(IPview, 1)
    .bottomSpaceToView(IPview, 50);
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [IPview addSubview:lineView2];
    lineView2.sd_layout
    .topSpaceToView(lineView1, 0)
    .centerXEqualToView(IPview)
    .widthIs(1)
    .bottomSpaceToView(IPview, 0);
    
    UILabel *IPlabel= [[UILabel alloc] init];
    IPlabel.text = @"请输入IP地址:";
    IPlabel.textAlignment = NSTextAlignmentCenter;
    [IPview addSubview:IPlabel];
    IPlabel.sd_layout
    .centerXEqualToView(IPview)
    .topSpaceToView(IPview, 20)
    .widthRatioToView(IPview, 1)
    .heightIs(40);
    
    NSString *projectIP =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"projectIP"]];
    
    if ([projectIP isEqualToString:@"(null)"]|| projectIP.length < 8) {
        projectIP= @"";
    }

    NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"OldIPAdressArr.plist"];
    NSMutableArray *IPArr = [NSMutableArray arrayWithContentsOfFile:newFielPath];
  //  if (!IPArr) {
    //    IPArr = [NSMutableArray array];
        
   // }
    //[IPArr addObject:@"11"];
    NSSet *set = [NSSet setWithArray:IPArr];
    NSArray *oldIPadressArr = [set allObjects];
    
   // NSArray *list = [NSArray arrayWithObjects:@"管理员",@"开发人员",@"游客",@"用户", nil];
    _dropdownList = [[LSDropdownList alloc] initWithFrame:CGRectMake(self.splitViewController.view.frame.size.width/2 - 250/2, 170, 250, 40) list:oldIPadressArr];
    _dropdownList.delegate = self;
    _dropdownList.textField.text = projectIP;
    [_dropdownList.textField
     becomeFirstResponder];

    [self.splitViewController.view addSubview:_dropdownList];
    
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.tag = 1001;
    [cancelButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(IPButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [IPview addSubview:cancelButton];
    
    cancelButton.sd_layout
    .leftSpaceToView(IPview, 0)
    .rightSpaceToView(lineView2, 0)
    .topSpaceToView(lineView1, 0)
    .bottomSpaceToView(IPview, 0);
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.tag = 1002;
    [rightButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(IPButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [IPview addSubview:rightButton];
    rightButton.sd_layout
    .leftSpaceToView(lineView2, 0)
    .rightSpaceToView(IPview, 0)
    .topSpaceToView(lineView1, 0)
    .bottomSpaceToView(IPview, 0);

}

/**
 设置IP地址页面的取消和确定按钮方法
 */
-(void)IPButtonAction:(UIButton*)button{
    [setIPButton setBackgroundImage:[UIImage imageNamed:@"setIP1"] forState:UIControlStateNormal];
    [setIPButton setBackgroundImage:[UIImage imageNamed:@"setIP2"] forState:UIControlStateHighlighted];
    if (button.tag == 1001) {
        [self removeIPView];
    }else if (button.tag == 1002)
    {
       
        self.pingServices = [STDPingServices startPingAddress:_dropdownList.textField.text callbackHandler:^(STDPingItem *pingItem, NSArray *pingItems) {
            
            if (pingItem.status != STDPingStatusFinished) {
                //未通过

            } else {
                [STDPingItem statisticsWithPingItems:pingItems];
                if ([[STDPingItem statisticsWithPingItems:pingItems] integerValue] > 0 ) {
                    //通过
                    NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
                    NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"OldIPAdressArr.plist"];
                    NSMutableArray *IPArr = [NSMutableArray arrayWithContentsOfFile:newFielPath];
                    if (!IPArr) {
                        IPArr = [NSMutableArray array];
                        
                    }
                    [IPArr addObject:_dropdownList.textField.text];
                    NSSet *set = [NSSet setWithArray:IPArr];
                    NSArray *oldIPadressArr = [set allObjects];
                    
                    BOOL isSucceed =[oldIPadressArr writeToFile:newFielPath atomically:YES];
                    if (isSucceed) {
                        NSLog(@"写入成功");
                    }else
                    {
                        NSLog(@"写入失败");
                    }
                    
                    NSLog(@"输入的ip地址为:%@",_dropdownList.textField.text );
                    //ip地址保存本地
                    [[NSUserDefaults standardUserDefaults] setObject:_dropdownList.textField.text forKey:@"projectIP"];
                    [self getAreaListDataWithIndex:0];
                    recordRow = 0;
                    
                    [self removeIPView];
                }else{
                    //未通过
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法连接此IP地址" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                    
                    [alert show];
                    
                }
                
            }
            
        }];
         self.pingServices.maximumPingTimes = 2;
        
    }
    
}

/**
 删除设置Ip地址的View
 */
-(void)removeIPView{
    //取消
    [_dropdownList.textField resignFirstResponder];
    //
    [_dropdownList removeFromSuperview];
    _dropdownList = nil;
    //
    [bgView removeFromSuperview];
    bgView= nil;
    //
    [IPview removeFromSuperview];
    IPview= nil;
}


/**
 下拉框 代理
 */
- (void)dropdownListDidSelectedItem:(NSString *)item {
    NSLog(@"zzzzz%@",item);
}

#pragma mark uitableviewDelegate
//设置section表头内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"";
    
}
//row  高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
    
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
    
    return areaListArray.count;
    
    
}
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != current.row) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:current];
        areaListModel *areaModel = [areaListArray objectAtIndex:current.row];
        if (areaModel.time.length<10) {
            //没有时间
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }else{
            //判断后台时间和当前时间是否一致(10分钟浮动)
            
            if ([self getTimeForNowWith:areaModel.time]) {
                cell.textLabel.textColor = [UIColor redColor];
                cell.detailTextLabel.textColor = [UIColor redColor];
            }else{
                cell.textLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.textColor = [UIColor grayColor];
            }
        }
        
    }
    //recordRow全局变量用来防止点击已选择的cell，重复请求数据
    
    if (indexPath.row != recordRow) {
        
        recordRow = indexPath.row;
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = BACK_BLUE_COLOR;
        cell.detailTextLabel.textColor = BACK_BLUE_COLOR;
        //        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        areaListModel *areaModel = [areaListArray objectAtIndex:indexPath.row];
        NewRightViewController *rightVC = (NewRightViewController *)self.splitViewController.delegate;
        [rightVC.headView removeFromSuperview];
        rightVC.headView = nil;
        rightVC.customLab.text = areaModel.areaName;
        rightVC.areaModel= areaModel;
        rightVC.cellIndexpathRow = [NSString stringWithFormat:@"%d",indexPath.row];
        [rightVC.MCBarView removeFromSuperview];
        rightVC.MCBarView = nil;
        if (!areaModel.temp) {
            
        }else{
            
            [rightVC createSevenView];
            [self getDetailAirDataWithRegion:areaModel.areaID];
        }
        
        
        
        [rightVC.smartModelArr removeAllObjects];
        [rightVC.smartView removeFromSuperview];
        rightVC.smartView = nil;
        [self getDevicesDataWithRegion:areaModel.areaID];
        
    }
}
//cell 布局
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellname = @"cellname1";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellname];
    if(!cell){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellname];
    }
    cell.backgroundColor = [UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    areaListModel *areaModel = [areaListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = areaModel.areaName;
    cell.detailTextLabel.text = areaModel.time;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
   
    if(indexPath.row == recordRow)
        
    {
        recordRow = indexPath.row;
        //current全局变量用来记录没有进行设置之前的选择的cell
        current = indexPath;
        //设置cell的属性accessoryType，实现打对勾的效果
        //        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = BACK_BLUE_COLOR;
        cell.detailTextLabel.textColor =BACK_BLUE_COLOR;
        
    }else{
        if (areaModel.time.length<10) {
            //没有时间
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }else{
            //判断后台时间和当前时间是否一致(10分钟浮动)
            if ([self getTimeForNowWith:areaModel.time]) {
                //
                cell.textLabel.textColor = [UIColor redColor];
                cell.detailTextLabel.textColor = [UIColor redColor];
            }else{
                cell.textLabel.textColor = [UIColor blackColor];
                cell.detailTextLabel.textColor = [UIColor grayColor];
            }
        }
        
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    areaListModel *areaModel = [areaListArray objectAtIndex:indexPath.row];
    if (areaModel.time.length<10) {
        //没有时间
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }else{
        //判断后台时间和当前时间是否一致(10分钟浮动)
        
        if ([self getTimeForNowWith:areaModel.time]) {
            cell.textLabel.textColor = [UIColor redColor];
            cell.detailTextLabel.textColor = [UIColor redColor];
        }else{
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }
    }
    
    
}

/**
 检测每条数据上的时间与当前时间是否相差10分钟以上

 @param time 数据时间
 @return 相差10分钟以上返回 yes
 */
-(BOOL)getTimeForNowWith:(NSString *)time{
    BOOL isRed = NO;

    NSDate *nowDate = [NSDate date];
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate *startD =[date dateFromString:time];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [nowDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分",day,house,minute];
        isRed = YES;
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"耗时%d小时%d分",house,minute];
        isRed = YES;
    }else if (day== 0 && house== 0 && minute!=0) {
        if (minute >=10 || minute <= -10) {
            isRed = YES;
        }
        str = [NSString stringWithFormat:@"耗时%d分",minute];
    }
//    NSLog(@"%@",str);®
    
//        NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    
//    
////    [formatter setDateStyle:NSDateFormatterMediumStyle];
////    
////    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    NSString *DateTime = [formatter stringFromDate:date];
//    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
//    // 截止时间字符串格式
////    time = @"2017-05-27 16:15:00";
//    NSString *expireDateStr = time;
//    // 当前时间字符串格式
//    NSString *nowDateStr = [formatter stringFromDate:date];
//    // 截止时间data格式
//    NSDate *expireDate = [formatter dateFromString:expireDateStr];
//    // 当前时间data格式
//    date = [formatter dateFromString:nowDateStr];
//    // 当前日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    // 需要对比的时间数据
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
//    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    // 对比时间差
//    NSDateComponents *dateCom = [calendar components:unit fromDate:date toDate:expireDate options:0];
//    NSLog(@"时间差额%d",dateCom.minute);
//    if (dateCom.minute < -10) {
//        isRed = YES;
//    }
    return isRed;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
