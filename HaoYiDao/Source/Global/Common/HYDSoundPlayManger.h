//
//  JYSoundPlayManger.h
//  JYFSKElectricity
//
//  Created by Sprixin on 16/7/20.
//  Copyright © 2016年 sprixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h> 

@interface HYDSoundPlayManger : NSObject

{
    SystemSoundID soundID;
}

-(instancetype)initForPlayingVibrate;


-(instancetype)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;


-(instancetype)initForPlayingSoundEffectWith:(NSString *)filename;


-(void)play;

@end
