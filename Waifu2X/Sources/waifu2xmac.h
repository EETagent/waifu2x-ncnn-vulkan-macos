//
//  waifu2xmac.h
//  waifu2xmac
//
//  Created by Cocoa on 2019/4/25.
//  Copyright © 2019-2020 Cocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "GPUInfo.h"

typedef NS_ENUM(NSInteger, Backend) {
    BackendWaifu2X,
    BackendRealSR
};

typedef void (^waifu2xProgressBlock)(int current, int total, NSString * description);

@interface waifu2xmac : NSObject

+ (NSImage *)input:(NSArray<NSString *> *)inputpaths
            output:(NSArray<NSString *> *)outputpaths
             noise:(int)noise
             scale:(int)scale
             backend:(Backend)backend
          tilesize:(int)tilesize
             model:(NSString *)model
             gpuid:(int)gpuid
          tta_mode:(BOOL)enable_tta_mode
      load_job_num:(int)jobs_load
      proc_job_num:(int)jobs_proc
      save_job_num:(int)jobs_save
       single_mode:(BOOL)is_single_mode
         VRAMUsage:(double *)usage
          progress:(waifu2xProgressBlock)cb;

@end

