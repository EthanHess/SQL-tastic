//
//  MediaUploadViewController.m
//  SQL'in
//
//  Created by Ethan Hess on 4/17/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "MediaUploadViewController.h"

@interface MediaUploadViewController ()

@property (nonatomic, strong) UIView *blanketView;

@end

@implementation MediaUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configureBlanketView];
}

//TODO: subclass

- (void)configureBlanketView {
    
    CGRect viewFrame = CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 20);
    
    self.blanketView = [[UIView alloc]initWithFrame:viewFrame];
    self.blanketView.layer.cornerRadius = 10;
    self.blanketView.layer.masksToBounds = YES;
    self.blanketView.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.blanketView.layer.borderWidth = 1;
    
    [self addSubviewsToBlanketView];
    
    [self.view addSubview:self.blanketView];
}

- (void)addSubviewsToBlanketView {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
