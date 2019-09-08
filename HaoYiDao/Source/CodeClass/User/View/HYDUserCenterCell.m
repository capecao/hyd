//
//  HYDUserCenterCell.m
//  HaoYiDao
//
//  Created by capecao on 16/9/19.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDUserCenterCell.h"

@interface HYDUserCenterCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HYDUserCenterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self p_setupView];
    }
    return self;
}

- (void) p_setupView {
    
    self.imgView = [[UIImageView alloc]init];
    self.titLab = [[UILabel alloc]init];
    
    
    _titLab.frame = CGRectMake(10 * WIDTHTSCALE,
                               0,
                               self.bounds.size.width - 30 * WIDTHTSCALE,
                               self.bounds.size.height);

    _imgView.frame = CGRectMake(CGRectGetMaxX(_titLab.frame),
                                       CGRectGetMidY(_titLab.frame) - 8 * HEIGHTSCALE,
                                       8 * WIDTHTSCALE,
                                       16 * HEIGHTSCALE);
    
    
    _titLab.font = HYD_font(14.f);
    _titLab.numberOfLines = 0;
    _imgView.image = [UIImage imageNamed:@"icon_more_rightforward"];
    
    [self.contentView addSubview:_titLab];
    [self.contentView addSubview:_imgView];
    
    self.line = [[UIView alloc]init];
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    _line.backgroundColor = [UIColor colorwithHexString:@"#e9e9e9"];
    [self.contentView addSubview:_line];
    
}

- (void)layoutSubviews {
    
    _titLab.frame = CGRectMake(10 * WIDTHTSCALE,
                               0,
                               self.bounds.size.width - 30 * WIDTHTSCALE,
                               self.bounds.size.height);
    
    _imgView.frame = CGRectMake(CGRectGetMaxX(_titLab.frame),
                                CGRectGetMidY(_titLab.frame) - 8 * HEIGHTSCALE,
                                8 * WIDTHTSCALE,
                                16 * HEIGHTSCALE);
    
    _line.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    
}


@end
