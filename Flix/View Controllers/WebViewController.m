//
//  WebViewController.m
//  Flix
//
//  Created by Nikki Tran on 6/29/18.
//  Copyright © 2018 Nikki Tran. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()
@property (strong, nonatomic) IBOutlet WKWebView *webkitView;
@property (strong, nonatomic) NSString *trailerURLString;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTrailer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) fetchTrailer {
    NSString *getTrailerURLString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1", self.movieID];
    
    NSURL *apiURL = [NSURL URLWithString:getTrailerURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:apiURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
     {
        // error
        // runs when network request comes back
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        // success - returns initial response as dictionary
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *trailer = dataDictionary[@"results"][0];
            self.trailerURLString = [@"https://www.youtube.com/watch?v=" stringByAppendingString: trailer[@"key"]];
            
            NSURL *url = [NSURL URLWithString:self.trailerURLString];
            
            // Place the URL in a URL Request.
            NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                 timeoutInterval:10.0];
            // Load Request into WebView.
            [self.webkitView loadRequest:request];
        }
    }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
