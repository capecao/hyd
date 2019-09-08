//
//  HYDHomeClassifyDiseaseCell.m
//  HaoYiDao
//
//  Created by Sprixin on 16/9/5.
//  Copyright © 2016年 cape. All rights reserved.
//

#import "HYDHomeClassifyDiseaseCell.h"

@implementation HYDHomeClassifyDiseaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupView];
    }
    return self;
}

- (void) p_setupView {
    
    self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(10 * WIDTHTSCALE, 0,
                                                           90 * WIDTHTSCALE, self.frame.size.height)];
    self.infoLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titLab.frame), 0,
                                                            self.frame.size.width - 130 * WIDTHTSCALE,
                                                            self.frame.size.height)];
    self.detialImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_infoLab.frame) + 10 * WIDTHTSCALE,
                                                                  self.centerY - 10 * HEIGHTSCALE,
                                                                  10 * WIDTHTSCALE, 20 * HEIGHTSCALE)];
    
    _detialImg.image = [UIImage imageNamed:@"next_icon"];
    _detialImg.hidden = YES;
    
    _titLab.textColor = [UIColor colorwithHexString:@"#414141"];
    _titLab.font = HYD_font(12.f);
    
    _infoLab.font = HYD_font(12.f);
    
    [self.contentView addSubview:_titLab];
    [self.contentView addSubview:_infoLab];
    [self.contentView addSubview:_infoLab];

}

- (void)layoutSubviews {
    
    _titLab.frame = CGRectMake(10 * WIDTHTSCALE, 0,
                               90 * WIDTHTSCALE, self.frame.size.height);
    _infoLab.frame = CGRectMake(CGRectGetMaxX(_titLab.frame), 0,
                                self.frame.size.width - 130 * WIDTHTSCALE,
                                self.frame.size.height);
    _detialImg.frame = CGRectMake(CGRectGetMaxX(_infoLab.frame) + 10 * WIDTHTSCALE,
                                  self.centerY - 10 * HEIGHTSCALE,
                                  10 * WIDTHTSCALE, 20 * HEIGHTSCALE);
    
}




@end
