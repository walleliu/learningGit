//
//  IPListViewTableViewCell.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/6/8.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "IPListViewTableViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation IPListViewTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width/3, self.contentView.frame.size.height)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.addressLable = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/3, 0, self.contentView.frame.size.width/3, self.contentView.frame.size.height)];
        self.addressLable.textAlignment = NSTextAlignmentCenter;
        self.addressLable.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.addressLable];
        
        self.stateLable = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/3*2, 0, self.contentView.frame.size.width/3, self.contentView.frame.size.height)];
        
        self.stateLable.textAlignment = NSTextAlignmentCenter;
        self.stateLable.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.stateLable];
        
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 300;
    [super setFrame:frame];
}


@end
