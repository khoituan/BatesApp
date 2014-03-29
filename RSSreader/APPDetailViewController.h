//
//  APPDetailViewController.h
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APPMasterViewController.h"
@interface APPDetailViewController : UIViewController

@property (weak, nonatomic)          NSString *storyTitle;
@property (weak, nonatomic)          NSString *storyDescription;
@property (weak, nonatomic)          NSString *storyAuthor;
@property (weak, nonatomic)          NSString *storyCategory;
@property (weak, nonatomic)          NSString *storyPubDate;
@property (weak, nonatomic)          NSString *storyLink;
@property (strong, nonatomic) IBOutlet UITextField *textTitle;
@property (strong, nonatomic) IBOutlet UITextField *textDescription;
@property (strong, nonatomic) IBOutlet UITextField *textAuthor;
@property (strong, nonatomic) IBOutlet UITextField *textCategory;
@property (strong, nonatomic) IBOutlet UITextField *textPubDate;
@property (strong, nonatomic) IBOutlet UITextField *textLink;

@end
