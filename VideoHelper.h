//
//  VideoHelper.h
//  VideoDemo
//
//  Created by Hemant on 2/6/15.
//  Copyright (c) 2015 SmartCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoHelper : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


+ (VideoHelper *)sharedInstance;
- (void)recordVideo ;

@end
