//
//  CustomCell.h
//  jsontableviewdemo
//
//  Created by vidita on 10/27/13.
//  Copyright (c) 2013 vidita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *ratingLabel;
    IBOutlet UILabel *durationLabel;
    IBOutlet UIImageView *poster;
    //IBOutlet UILabel *titleLabel;
}
@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UILabel *ratingLabel;
@property (nonatomic,retain) IBOutlet UILabel *durationLabel;
@property (nonatomic,retain) IBOutlet UIImageView *poster;
@end
