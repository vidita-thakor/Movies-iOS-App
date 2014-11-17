//
//  TheatreShowTimeTableCell.m
//  MovieBuzz
//
//  Created by Abhishek Desai on 12/8/13.
//  Copyright (c) 2013 IOS Frenzy. All rights reserved.
//

#import "TheatreShowTimeTableCell.h"

@implementation TheatreShowTimeTableCell
@synthesize posterImageView, movieShowTime,movieTitle, playTrailer;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [posterImageView release];
    [movieTitle release];
    [movieShowTime release];
    [playTrailer release];
    [super dealloc];
}


@end
