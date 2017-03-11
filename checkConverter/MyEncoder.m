//
//  MyEncoder.m
//  checkConverter
//
//  Created by pebble8888 on 2016/07/01.
//  Copyright © 2016年 pebble8888. All rights reserved.
//

#import "MyEncoder.h"
#include <AudioToolbox/AudioToolbox.h>
#import "KFAACEncoder.h"
#import "checkConverter-swift.h"
#import "KFFrame.h"

@implementation MyEncoder

- (void)run 
{
    KFAACEncoder* encoder = [[KFAACEncoder alloc] initWithBitrate:64*1000 sampleRate:44100 channels:1];
    encoder.delegate = self;
    
    for( int i = 0; i < 128; ++i){
        CMSampleBufferRef buf = [Creator createSilentAudio:0 nFrames:4096 sampleRate:44100 numChannels:1];
        // データ供給
        [encoder encodeSampleBuffer:buf]; 
        CFRelease(buf);
    }
}

// 変換後のデータ
- (void)encoder:(KFEncoder*)encoder encodedFrame:(KFFrame*)frame
{
    if (frame != nil){
        if (frame.data != nil){
            NSLog(@"frame %@ %@ length %@", frame.data, @(frame.pts.value), @(frame.data.length));
        } else {
            NSLog(@"frame.data is nil");
        }
    } else {
        NSLog(@"frame is nil");
    }
}
@end
