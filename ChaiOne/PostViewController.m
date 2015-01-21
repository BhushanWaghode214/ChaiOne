//
//  ViewController.m
//  ChaiOne
//
//  Created by synerzip on 19/01/15.
//  Copyright (c) 2015 synerzip.com. All rights reserved.
//

#import "PostViewController.h"
#import "PostCell.h"
#import "Post.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kID_WebViewController = @"ID_WebViewController";

#define kCELLHEIGHT_IPHONE_PORTRAIT 300;
#define kCELLHEIGHT_IPHONE_LANDSCAPE 250;
#define kMIN_CELLHEIGHT 50.0
#define KMIN_EXPECTED_CELLHEIGHT 100.0

#define kIMAGE_CORNER_RADIUS 15

static NSString *const kNO_DATA = @"No data available. Please pull down to refresh or Check Internet connection.";
static NSString *const kFETCHING_DATA = @"Please wait. Data is loading";

#define kMSG_FONT [UIFont fontWithName:@"Palatino-Italic" size:20]

@interface PostViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UILabel *msglbl;
@end

@implementation PostViewController

#pragma mark - View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    [self requestForPostsFromServer];
    
}

- (BOOL)isLandscapeOrientation {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}

#pragma mark - Setup Methods
-(void)setUpView{
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(requestForPostsFromServer)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    
    // Display a message when the table is empty
    self.msglbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    // Check Rechability
    [SharedManager defaultManager].webServiceManager.reachabilityChangedHandler = ^(NetworkStatus newStatus) {
        switch (newStatus) {
            case NotReachable:
                self.msglbl.text = kNO_DATA;
                break;
            default:
                self.msglbl.text = kFETCHING_DATA;
                break;
        }
    };
    
    self.msglbl.numberOfLines = 0;
    self.msglbl.textAlignment = NSTextAlignmentCenter;
    self.msglbl.font = kMSG_FONT;
    [self.msglbl sizeToFit];
    
    self.tableView.backgroundView = self.msglbl;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

-(void)requestForPostsFromServer{
    [[[SharedManager defaultManager] postsManager] fetchPostsFromServerWithSuccessBlock:^(id parsedObjects)
     {
         self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
         [self.tableView reloadData];
         [self.refreshControl endRefreshing];
         
     } andErrorBlock:^(NSError *error) {
         
         DebugLog(@"ERROR %@",error);
         [self.tableView reloadData];
         [self.refreshControl endRefreshing];
     }];
}

-(PostCell *)configureCell:(PostCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    Post *postInfo = (Post *)[[[[SharedManager defaultManager] postsManager] serverPostsData] objectAtIndex:indexPath.row];
    
    [cell.lblName setText:postInfo.creatorName];
    
    cell.lblMessage.text = postInfo.content;
    
    cell.imgDisplay.layer.cornerRadius = kIMAGE_CORNER_RADIUS;
    cell.imgDisplay.clipsToBounds = YES;
    
    [cell.imgDisplay sd_setImageWithURL:postInfo.avatarImageUrl];

    return cell;
}


#pragma mark - UITableViewDataSource And UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isLandscapeOrientation]) {
        return kCELLHEIGHT_IPHONE_LANDSCAPE;
    } else {
        return kCELLHEIGHT_IPHONE_PORTRAIT;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     PostCell *cell = (PostCell *)[self.tableView dequeueReusableCellWithIdentifier:kCELL];
     cell = [self configureCell:cell forIndexPath:indexPath];
     
     if(cell.lblMessage.text != nil){
         [cell.lblMessage sizeToFit];
     }
     
     int cellHeight = cell.lblMessage.frame.size.height + kMIN_CELLHEIGHT;
     
     if (cellHeight < KMIN_EXPECTED_CELLHEIGHT){
         cellHeight = KMIN_EXPECTED_CELLHEIGHT;
     }
     
     return cellHeight;
 }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[SharedManager defaultManager] postsManager] serverPostsData].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:kCELL];
   
    cell = [self configureCell:cell forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
