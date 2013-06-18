//
//  ViewController.m
//  Animated Table
//
//  Created by Santosh Gupta on 18/06/13.
//

#import "ViewController.h"
#import "AnimatedTableCell.h"
#import "AnimatedTableView.h"
#define tableViewCellHeight 50

@interface ViewController ()

@end

@implementation ViewController
@synthesize table = _table;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    for ( int i = 0 ; i < 10 ; i++) {
        [dataArray addObject:[NSString stringWithFormat:@"Tilte %d", i]];
    }
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    _table = [[AnimatedTableView alloc] initWithFrame:CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_table];
    //[self.table reloadDataWithAnimation:@"left" :@"right"];

    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTable)];
    self.navigationItem.rightBarButtonItem = editBtn;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark TableView DataSource Methods


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableViewCellHeight;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    AnimatedTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[AnimatedTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell configureCellWithTable:self.table width:self.table.frame.size.width height:tableViewCellHeight color:[UIColor whiteColor]];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"subtitle";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


-(void)editTable {
    if ([self.table getEditing]) {
        [self.table setEditing:NO];
        dataArray = [self.table editingDoneWithArray:dataArray];
        UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTable)];
        self.navigationItem.rightBarButtonItem = editBtn;
    }
    else {
        [self.table setEditing:YES];
        UIBarButtonItem *donebtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(editTable)];
        self.navigationItem.rightBarButtonItem = donebtn;
        
    }
    [self.table reloadDataWithAnimation:@"left" :@"right"];
}



#pragma mark -
#pragma mark TableView Delegate Methods



@end


