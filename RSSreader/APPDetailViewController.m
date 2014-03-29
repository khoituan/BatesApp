//
//  APPDetailViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPDetailViewController.h"
#import "APPMasterViewController.h"

@implementation APPDetailViewController


#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"Moving to story screen with link %@", _storyLink);
    [self textTitle].text=_storyTitle;
    [self textDescription].text=_storyDescription;
    [self textAuthor].text=_storyAuthor;
    [self textCategory].text=_storyCategory;
    [self textPubDate].text=_storyPubDate;
    [self textLink].text=_storyLink;
    NSLog(@"End setting up the story screen");
    
}

@end