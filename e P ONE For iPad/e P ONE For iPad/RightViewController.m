//
//  RightViewController.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/9.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController
#pragma mark -SplitView support
//split将要隐藏时
-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{

}
//split将要显示时
-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{

}
//split将要呈现时
-(void)splitViewController:(UISplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [_customLab setTextColor:[UIColor blackColor]];
    [_customLab setText:@"区域名称"];
    _customLab.textAlignment = NSTextAlignmentCenter;
    _customLab.font = [UIFont boldSystemFontOfSize:19];
    self.navigationItem.titleView = _customLab;
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view from its nib.
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    
}
#pragma mark uitableviewDelegate
//设置section表头内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"";
    
}
//row  高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 120;
    }else{
        return 220;
    }
    
    
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
    
    return 2;
    
    
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
     NSString *cellname = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.row,(long)indexPath.section];
    if (indexPath.row==0) {
//        static NSString *cellname = @"cellname1";
        firstTableViewCell * firstCell = [tableView dequeueReusableCellWithIdentifier: cellname];
        if (!firstCell ) {
           firstCell = [[firstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname withAreaModel:_areaModel];
        }
        
        [firstCell setSelectionStyle:UITableViewCellSelectionStyleNone];

        return firstCell;
    }else{
    
    otherTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellname];
        NSMutableArray *cellArr = [NSMutableArray array];
        switch (indexPath.row) {
            case 1:
                cellArr = _pm25DetailArr;
                break;
            case 2:
                cellArr = _pm10DetailArr;
                break;
            case 3:
                cellArr = _tempDetailArr;
                break;
            case 4:
                cellArr = _humiDetailArr;
                break;
            case 5:
                cellArr = _hchoDetailArr;
                break;
            case 6:
                cellArr = _co2DetailArr;
                break;
            case 7:
                cellArr = _vocDetailArr;
                break;
            
                
            default:
                break;
        }

//        if (cell == nil) {
            cell = [[otherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname andDataType:indexPath.row withCellArr:cellArr];
//        }
      
        
        
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 
        

    return cell;
     }
    
   
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
