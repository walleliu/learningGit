//
//  leftViewController.h
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/9.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightViewController.h"
#import "areaListModel.h"
#import "DNSRequestData.h"
#import "NewRightViewController.h"
#import "SmartModel.h"

#import "LSDropdownList.h"


#import "STDPingServices.h"

#import "IPListView.h"
#import "IPModel.h"

@interface leftViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,LSDropdownListDelegate>
@property (strong, nonatomic) IBOutlet UITableView *listTabelView;
@property (nonatomic, strong) LSDropdownList  *dropdownList;
@property (strong, nonatomic) IBOutlet UIView *fourButtonView;
@property(nonatomic, strong) STDPingServices    *pingServices;
@property(nonatomic, strong) IPListView    *iPListView;
@end
