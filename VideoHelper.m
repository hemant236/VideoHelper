//
//  VideoHelper.m
//  VideoDemo
//
//  Created by Hemant on 2/6/15.
//  Copyright (c) 2015 SmartCloud. All rights reserved.
//

#import "VideoHelper.h"

@implementation VideoHelper

static VideoHelper *sharedInstance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(sharedInstance) {
        // avoid creating more than one instance
    }

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        // own initialization code here
    }
    return self;
}

+ (VideoHelper *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[VideoHelper alloc] initWithNibName:@"recordingScreen" bundle:nil];
    });
    return sharedInstance;
}

- (void)recordVideo {
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {

    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;


    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;

    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];

    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;

    cameraUI.delegate = delegate;

    [controller presentViewController:cameraUI animated:YES completion:NULL];
    return YES;
}


// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {

    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];

    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *tempPath = [documentsDirectory stringByAppendingFormat:@"/vid1.mp4"];

    BOOL success = [videoData writeToFile:tempPath atomically:YES];
    if (!success) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Video saved successfully"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }

    [picker dismissViewControllerAnimated:YES completion:NULL];

}

/*
- (IBAction)playVideo:(id)sender {
    //[self startMediaBrowserFromViewController: self usingDelegate: self];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSURL *videoURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:@"/vid1.mp4"]];


    MPMoviePlayerViewController* theMovie =
    [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];


    [self presentMoviePlayerViewControllerAnimated:theMovie];

    // Register for the playback finished notification
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector(myMovieFinishedCallback:)
     name: MPMoviePlayerPlaybackDidFinishNotification
     object: theMovie];


}
// When the movie is done, release the controller.
-(void) myMovieFinishedCallback: (NSNotification*) aNotification
{
    [self dismissMoviePlayerViewControllerAnimated];

    MPMoviePlayerController* theMovie = [aNotification object];

    [[NSNotificationCenter defaultCenter]
     removeObserver: self
     name: MPMoviePlayerPlaybackDidFinishNotification
     object: theMovie];
    // Release the movie instance created in playMovieAtURL:
}
*/


@end
