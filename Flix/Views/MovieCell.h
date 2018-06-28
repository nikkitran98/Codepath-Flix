//
//  MovieCell.h
//  Flix
//
//  Created by Nikki Tran on 6/28/18.
//  Copyright © 2018 Nikki Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

// configures these properties in code
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
