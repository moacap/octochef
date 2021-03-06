//
//  RootViewController.m
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "RootViewController.h"

#import "DetailViewController.h"

#import "Recipe.h"

#import "UserSingleton.h"

@implementation RootViewController
		
@synthesize detailViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
}

		
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];        
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadRecipes];
}

- (void) loadRecipes {
    recipesArray = [[NSMutableArray alloc] init];
    NSString *user = [UserSingleton sharedUser].username;
    if(user) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:user];
        NSArray *repoDirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        if([repoDirs count] > 0) {
            for(NSString *repoDir in repoDirs) {
                NSString *repoPath = [path stringByAppendingPathComponent:repoDir];
                NSArray *recipeFilenames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:repoPath error:nil];
                for(NSString *recipeFilename in recipeFilenames) {
                    Recipe *aRecipe = [[Recipe alloc] init];
                    aRecipe.title = recipeFilename;
                    aRecipe.content = [[NSString alloc] initWithData:[[NSFileManager defaultManager] contentsAtPath:[repoPath stringByAppendingPathComponent:recipeFilename]] encoding:NSUTF8StringEncoding];
                    
                    [recipesArray addObject:aRecipe];
                    [aRecipe release];                    
                }
            }
            [self.tableView reloadData];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    		
}

		
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipesArray count];
    		
}

		
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    Recipe *aRecipe = [recipesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = aRecipe.title;
    		
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.detailViewController setDetailItem:[recipesArray objectAtIndex:indexPath.row]];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [detailViewController release];
    [super dealloc];
}

@end
