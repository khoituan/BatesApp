//
//  APPMenuOfDay.h
//  RSSreader
//
//  Created by Khoi Tuan Nguyen on 4/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPMenuOfDay : UIViewController

//declare method to get the name of the day
- (NSString *) getDays:(NSInteger) indexOfArray;

@property NSMutableArray *ans;
@property NSInteger daySelected;


@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
