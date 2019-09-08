//
//  HYDHomeThemeCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/3.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeThemeCell.h"

@implementation HYDHomeThemeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];
    }
    
    return self;
}

- (void) p_setupView {
    
    self.imgView = [[UIImageView alloc]init];
    self.titleLab = [[UILabel alloc]init];
    
    _imgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * .8);
    _titleLab.frame = CGRectMake(15, CGRectGetMaxY(_imgView.frame),
                                 self.frame.size.width - 30, self.frame.size.height * .2);
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titleLab];
    
    _titleLab.font = HYD_font(14.f);
    _titleLab.textColor = [UIColor colorwithHexString:@"#414141"];
    _titleLab.text = @"超鄙视自己";
    
    _imgView.backgroundColor = [UIColor colorWithWhite:.2 alpha:.3];
    
}

- (void)layoutSubviews {
  
    _imgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * .8);
    _titleLab.frame = CGRectMake(15, CGRectGetMaxY(_imgView.frame),
                                 self.frame.size.width - 30, self.frame.size.height * .2);

}






@end
