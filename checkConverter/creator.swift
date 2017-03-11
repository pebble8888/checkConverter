//
//  creator.swift
//  checkConverter
//
//  Created by pebble8888 on 2016/07/01.
//  Copyright © 2016年 pebble8888. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation

class Creator : NSObject {

    static func createSilentAudio(_ startFrm: Int64, nFrames: Int, sampleRate: Float64, numChannels: UInt32) -> CMSampleBuffer? {
        let bytesPerFrame = UInt32(2 * numChannels)
        let blockSize = nFrames*Int(bytesPerFrame)
        
        var block: CMBlockBuffer?
        var status = CMBlockBufferCreateWithMemoryBlock(
            kCFAllocatorDefault,
            nil,
            blockSize,  // blockLength
            nil,        // blockAllocator
            nil,        // customBlockSource
            0,          // offsetToData
            blockSize,  // dataLength
            0,          // flags
            &block
        )
        assert(status == kCMBlockBufferNoErr)
        
        // we seem to get zeros from the above, but I can't find it documented. so... memset:
        status = CMBlockBufferFillDataBytes(0, block!, 0, blockSize)
        assert(status == kCMBlockBufferNoErr)
        
        var asbd = AudioStreamBasicDescription(
            mSampleRate: sampleRate,
            mFormatID: kAudioFormatLinearPCM,
            mFormatFlags: kLinearPCMFormatFlagIsSignedInteger|kLinearPCMFormatFlagIsPacked,
            mBytesPerPacket: bytesPerFrame,
            mFramesPerPacket: 1,
            mBytesPerFrame: bytesPerFrame,
            mChannelsPerFrame: numChannels,
            mBitsPerChannel: 16,
            mReserved: 0
        )
        
        var formatDesc: CMAudioFormatDescription?
        status = CMAudioFormatDescriptionCreate(kCFAllocatorDefault, &asbd, 0, nil, 0, nil, nil, &formatDesc)
        assert(status == noErr)
        
        var sampleBuffer: CMSampleBuffer?
        
        // born ready
        status = CMAudioSampleBufferCreateReadyWithPacketDescriptions(
            kCFAllocatorDefault,
            block,      // dataBuffer
            formatDesc!,
            nFrames,    // numSamples
            CMTimeMake(startFrm, Int32(sampleRate)),    // sbufPTS
            nil,        // packetDescriptions
            &sampleBuffer
        )
        assert(status == noErr)
        
        return sampleBuffer
    }
    
}
