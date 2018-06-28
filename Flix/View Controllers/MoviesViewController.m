//
//  MoviesViewController.m
//  Flix
//
//  Created by Nikki Tran on 6/27/18.
//  Copyright © 2018 Nikki Tran. All rights reserved.
//

#import "MoviesViewController.h"

//the class MoviesViewController implements the protocols UITableViewDataSource and UITableViewDelegate
@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// creates private instance variable under hood as _movies with setter and getter
@property (nonatomic, strong) NSArray *movies;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableview expects data source and calls MoviesController object
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // error
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        // success - returns initial response as dictionary
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            // %@ specifies object
            NSLog(@"%@", dataDictionary);
            
            self.movies = dataDictionary[@"results"];
            for (NSDictionary *movie in self.movies) {
                NSLog(@"%@", movie[@"title"]);
            }
            
            // call dataSource methods again because of changed data
            [self.tableView reloadData];
            
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
        }
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns number of rows I have
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

// returns cell based on indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    // associates movie with row
    NSDictionary *movie = self.movies[indexPath.row];
    cell.textLabel.text = movie[@"title"];
    
    return cell;
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
