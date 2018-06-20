//
//  MediaUploadViewController.m
//  SQL'in
//
//  Created by Ethan Hess on 4/17/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "MediaUploadViewController.h"
@import AVKit;

@interface MediaUploadViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *blanketView;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImageView *displayUploadImageView;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *videoButton;

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *theLayer;

@end

@implementation MediaUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
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
    self.blanketView.alpha = 0;
    
    [self addBlurToBlanketView];
    
    [self addSubviewsToBlanketView];
    
    [self.view addSubview:self.blanketView];
    
    [UIView animateWithDuration:1 animations:^{
        self.blanketView.alpha = 0.85;
    }];
}

- (void)addBlurToBlanketView {
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.blanketView.bounds;
    [self.blanketView addSubview:visualEffectView];
}

- (void)addSubviewsToBlanketView {
    
    CGFloat xCoord = self.view.frame.size.width / 10;
    
    CGRect finalFrameI = CGRectMake(xCoord, xCoord * 4, xCoord * 2, xCoord * 2);
    CGRect finalFrameV = CGRectMake(xCoord * 6, xCoord * 4, xCoord * 2, xCoord * 2);
    
    self.imageButton = [[UIButton alloc]initWithFrame:CGRectMake(xCoord * 2, xCoord * 5, 0, 0)];
    [self.imageButton setTitle:@"Image" forState:UIControlStateNormal];
    self.imageButton.backgroundColor = [UIColor blackColor];
    [self.imageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.imageButton.layer.masksToBounds = YES;
    [self.blanketView addSubview:self.imageButton];
    
    self.videoButton = [[UIButton alloc]initWithFrame:CGRectMake(xCoord * 7, xCoord * 5, 0, 0)];
    [self.videoButton setTitle:@"Video" forState:UIControlStateNormal];
    self.videoButton.backgroundColor = [UIColor blackColor];
    [self.videoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.videoButton.layer.masksToBounds = YES;
    [self.blanketView addSubview:self.videoButton];
    
    [UIView animateWithDuration:2 animations:^{
        self.imageButton.layer.cornerRadius = xCoord;
        self.imageButton.frame = finalFrameI;
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.videoButton.layer.cornerRadius = xCoord;
        self.videoButton.frame = finalFrameV;
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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
