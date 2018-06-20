//
//  MainFeedViewController.m
//  SQL'in
//
//  Created by Ethan Hess on 1/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "MainFeedViewController.h"
#import "MediaUploadViewController.h"

@interface MainFeedViewController () <ScrollContainerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

//Custom
@property (nonatomic, strong) ScrollContainerView *scrollContainer;

//Apple
@property (nonatomic, strong) UIBarButtonItem *rightUploadButton;
@property (nonatomic, strong) NSMutableArray *storiesArray;
@property (nonatomic, strong) NSMutableArray *postArray;

@end

@implementation MainFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setUpViews];
    [self setUpBarButton];
}

- (void)setUpBarButton {
    self.rightUploadButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(presentMediaUpload)];
    self.tabBarController.navigationItem.rightBarButtonItem = self.rightUploadButton;
}

- (void)presentMediaUpload {
    MediaUploadViewController *mediaUploadVC = [[MediaUploadViewController alloc]init];
    [self presentViewController:mediaUploadVC animated:YES completion:nil];
}

- (void)setUpViews {
    //frames
    CGRect scrollFrame = CGRectMake(0, 64, self.view.frame.size.width, 100);

    //scroll container
    if (self.scrollContainer == nil) {
        self.scrollContainer = [[ScrollContainerView alloc]initWithFrame:scrollFrame];
    }
    
    self.scrollContainer.backgroundColor = [UIColor colorWithRed:63.0f/255.0f green:56.0f/255.0f blue:244.0f/255.0f alpha:1.0];
    self.scrollContainer.delegate = self;

    [self storiesArrayCheck];
    [self.view addSubview:self.scrollContainer];
}

- (void)storiesArrayCheck {
    if (self.storiesArray != nil) {
        [self.scrollContainer setUpScrollViewWithArray:@[@"", @"", @"", @"", @""]];
    } else {
        self.storiesArray = [[NSMutableArray alloc]init];
        [self.scrollContainer setUpScrollViewWithArray:@[@"", @"", @"", @"", @""]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Scroll delegate, passing selected index

- (void)scrollIndexSelected:(NSInteger)index {
    NSDictionary* userInfo = @{@"index": [NSString stringWithFormat:@"%ld", (long)index]};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"viewTapped" object:nil userInfo:userInfo];
}

#pragma Collection View

//TODO: ADD LAYOUT

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postArray != nil ? self.postArray.count : 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES]; 
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
