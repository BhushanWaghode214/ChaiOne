//
//  DetailCell.h
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgDisplay;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@end
