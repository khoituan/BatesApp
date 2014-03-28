//
//  APPMasterViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPMasterViewController.h"
#import "APPListOfCategoriesViewController.h"
#import "APPDetailViewController.h"

@interface APPMasterViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *description;
    NSMutableString *author;
    NSMutableString *category;
    NSMutableString *pubDate;
    NSMutableString *link;
    NSString *element;
    NSURL *url;
}
@end

@implementation APPMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void) setUrlText:(NSString *)urlText
{
    _urlText = urlText;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    feeds = [[NSMutableArray alloc] init];
    
    url = [NSURL URLWithString: _urlText];
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Set up the cell
    int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
    NSString *cellLabel = [[feeds objectAtIndex: storyIndex] objectForKey: @"title"];
    NSString *cellLabel2 =[[feeds objectAtIndex: storyIndex] objectForKey: @"link"];
    NSLog(@"The link to %@ is: %@", cellLabel, cellLabel2);
    //cell.textLabel.text=[[cellLabel stringByAppendingString:@" "] stringByAppendingString: cellLabel2];
    cell.textLabel.text = cellLabel;
    
    return cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    return cell;
}
*/

/*
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic
 
 int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
 
 NSString *storyLink = [[feeds objectAtIndex: storyIndex] objectForKey: @"link"];
 //NSLog(@"%@",feeds);
 // clean up the link - get rid of spaces, returns, and tabs...
 storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
 storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
 storyLink = [storyLink stringByReplacingOccurrencesOfString:@"    " withString:@""];
 //[self setUrlToNextScreen:storyLink];
 NSLog(@"----DKFJSDLKFJSDKF:LSD-%@",_urlToNextScreen);
 
 // open in Safari
 //[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]];
 }
 */

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"found file and started parsing");
}



- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
    NSLog(@"error parsing XML: %@", errorString);
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        author = [[NSMutableString alloc] init];
        category = [[NSMutableString alloc] init];
        pubDate = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //Check for element name "item"
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:description forKey:@"description"];
        [item setObject:author forKey:@"author"];
        [item setObject:category forKey:@"category"];
        [item setObject:pubDate forKey: @"pubDate"];
        [item setObject:link forKey:@"link"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"])
    {
        [title appendString:string];
        NSLog(@"This is the title: %@", string);
    }
    else if ([element isEqualToString:@"description"])
    {
        [description appendString:string];
        NSLog(@"This is the DESCRIPTION: %@", string);
    }
    else if ([element isEqualToString:@"author"])
    {
        [author appendString:string];
        NSLog(@"This is the AUTHOR: %@", string);
    }
    else if ([element isEqualToString:@"category"])
    {
        [category appendString:string];
        NSLog(@"This is the CATEGORY: %@", string);
    }
    else if ([element isEqualToString:@"pubDate"])
    {
        [pubDate appendString:string];
        NSLog(@"This is the PUBDATE: %@", string);
    }
    else if ([element isEqualToString:@"link"])
    {
        [link appendString:string];
        NSLog(@"This is the LINK: %@", string);
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"LDSKJFLKDSJFSDKLFJSLDKFSDF");
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSLog(@"HELLLDOSDOFJSDOFSDJFJSDFOSDFOSDJFOJSDFLJSDLJFLS");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableString *string = [feeds[indexPath.row] objectForKey: @"link"];
        NSLog(string);
        [[segue destinationViewController] setUrl:string];
    }
        
}

@end
