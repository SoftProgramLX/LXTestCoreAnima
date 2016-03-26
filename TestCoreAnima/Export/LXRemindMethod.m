//
//  LXRemindMethod.m
//  TestCoreAnima
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 xu li. All rights reserved.
//

#import "LXRemindMethod.h"

@implementation LXRemindMethod

- (id)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType
{
    self = [super init];
    if (self) {
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
        if (path) {
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                systemsoundID = theSoundID;
            }
        }
        systemshake = kSystemSoundID_Vibrate;
    }
    return self;
}
- (void)playMusic
{
    AudioServicesPlaySystemSound(systemsoundID);
}
- (void)playToShake
{
    //震动
    AudioServicesPlaySystemSound(systemshake);
}

- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(systemsoundID);
}

//释放
-(void)deallocSound
{
    AudioServicesDisposeSystemSoundID(systemsoundID);
}

@end




