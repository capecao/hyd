//
//  HYDHomeClassifyCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/3.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeClassifyCell.h"

@interface HYDHomeClassifyCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDHomeClassifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_setupView];
    }
    
    return self;
}

- (void) p_setupView {
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 15,
                                                             self.frame.size.height - .5)];
    _titleLab.font = HYD_font(14.f);
    _titleLab.numberOfLines = 0;
    [self.contentView addSubview:_titleLab];
    
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - .5,
                                                        self.frame.size.width, .5)];
    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    [self.contentView addSubview:_line];
    
    _titleLab.text = @"好医道";

}


- (void) layoutSubviews {
    
    _titleLab.frame = CGRectMake(10, 0, self.frame.size.width - 15,
                                 self.frame.size.height - .5);
    _line.frame = CGRectMake(0, self.frame.size.height - .5,
                             self.frame.size.width, .5);

}

@end
