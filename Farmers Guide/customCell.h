//
//  customCell.h
//  Farmers Guide
//
//  Created by Alex Bechmann on 28/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *BMImageView;
@property (weak, nonatomic) IBOutlet UILabel *BMTitle;
@property (weak, nonatomic) IBOutlet UITextView *BMArticlePreview;


@end
