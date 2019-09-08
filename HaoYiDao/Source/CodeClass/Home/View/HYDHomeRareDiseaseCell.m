//
//  HYDHomeRareDiseaseCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeRareDiseaseCell.h"

@interface HYDHomeRareDiseaseCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDHomeRareDiseaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setupView];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}

- (void) p_setupView {
    
    self.imgView = [[UIImageView alloc]init];
    self.titLab = [[UILabel alloc]init];
    
    _imgView.frame = CGRectMake(10 * WIDTHTSCALE, self.frame.size.height * .25,
                                self.frame.size.height * .5,
                                self.frame.size.height * .5);
    
    _titLab.frame = CGRectMake(CGRectGetMaxX(_imgView.frame) + 10 * WIDTHTSCALE, 0,
                               self.frame.size.width - CGRectGetMaxX(_imgView.frame) - 10 * WIDTHTSCALE,
                               self.frame.size.height);
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titLab];

    _titLab.textColor = [UIColor colorwithHexString:@"#414141"];
    _titLab.font = HYD_font(16.f);
    
    self.line = [[UIView alloc]init];
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    [self.contentView addSubview:_line];
    
}

-(void)layoutSubviews {
    
    _imgView.frame = CGRectMake(10 * WIDTHTSCALE, self.frame.size.height * .25,
                                self.frame.size.height * .5,
                                self.frame.size.height * .5);
    
    _titLab.frame = CGRectMake(CGRectGetMaxX(_imgView.frame) + 10 * WIDTHTSCALE, 0,
                               self.frame.size.width - CGRectGetMaxX(_imgView.frame) - 10 * WIDTHTSCALE,
                               self.frame.size.height);
    
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);

}



@end
