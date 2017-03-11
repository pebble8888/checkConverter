//
//  AACEncoder.h
//  checkConverter
//
//  Created by pebble8888 on 2016/07/01.
//  Copyright © 2016年 pebble8888. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KFEncoder.h"

@interface MyEncoder : NSObject
<KFEncoderDelegate>

- (void)run;
@end
