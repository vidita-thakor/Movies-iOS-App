//
//  TheatreShowTimeTableCell.h
//  MovieBuzz
//
//  Created by Abhishek Desai on 12/8/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheatreShowTimeTableCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *posterImageView;
@property (retain, nonatomic) IBOutlet UILabel *movieTitle;
@property (retain, nonatomic) IBOutlet UILabel *movieShowTime;
@property (retain, nonatomic) IBOutlet UIButton *playTrailer;

@end
