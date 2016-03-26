//
//  LXRemindMethod.h
//  TestCoreAnima
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 xu li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface LXRemindMethod : NSObject
{
    SystemSoundID systemsoundID ,systemshake;  //系统声音ID
}

/**系统 震动*/
- (void)playToShake;
/**初始化系统声音*/
- (id)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType;
/**播放*/
- (void)playMusic;
- (void)deallocSound;

@end
