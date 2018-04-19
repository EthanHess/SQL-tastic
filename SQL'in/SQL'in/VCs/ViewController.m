//
//  ViewController.m
//  SQL'in
//
//  Created by Ethan Hess on 8/12/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

#import "ViewController.h"
#import "MainFeedViewController.h"
#import "BlocksViewController.h"

//subviews
#import "AnimatingImageView.h"

//helper
#import "GlobalFunctions.h"

//controller
#import "DatabaseManager.h"

//models
#import "User.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate> //For login

@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) AnimatingImageView *profileImageView;

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIButton *proceedButton;
@property (nonatomic, strong) UIStackView *containerStack;
@property (nonatomic, strong) NSString *textString;

@property (nonatomic, strong) UIImage *chosenImage;
@property (nonatomic, strong) UISwitch *toggleSwitch;

@property (nonatomic) BOOL createNewUser;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.createNewUser = YES;
    
    [self becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor darkGrayColor]; //TODO, have custom colors extension
    
    [self addStackView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self enterApp];
}


- (void)addStackView { //TODO set anchors
    
    CGFloat sidePadding = 10;
    CGFloat topPadding = self.view.frame.size.width / 2;
    CGFloat height = topPadding;
    CGFloat width = self.view.frame.size.width - 20;
    
    CGFloat imageViewX = self.view.frame.size.width / 3;
    
    self.profileImageView = [[AnimatingImageView alloc]initWithFrame:CGRectMake(imageViewX, 80, imageViewX, imageViewX)];
    [self.view addSubview:self.profileImageView];
    
    self.containerStack = [[UIStackView alloc]initWithFrame:CGRectMake(sidePadding, topPadding + imageViewX, width, height)];
    self.containerStack.axis = UILayoutConstraintAxisVertical;
    self.containerStack.distribution = UIStackViewDistributionEqualSpacing;
    self.containerStack.alignment = UIStackViewAlignmentCenter;
    self.containerStack.spacing = 20;
    self.containerStack.layer.cornerRadius = 3;
    self.containerStack.layer.masksToBounds = YES;
    self.containerStack.layer.borderWidth = 1;
    self.containerStack.layer.borderColor = [[UIColor lightGrayColor]CGColor];

    [self configureButtonsAndFields];
    
    [self.view addSubview:self.containerStack];
    //TODO add to subview plus configure stack view's subviews
    
    //[GlobalFunctions animateBorderWidth:self.profileImageView fromValue:@(0) toValue:@(1) andDuration:0.5];
}


- (void)configureButtonsAndFields {
    
    self.usernameField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.containerStack.frame.size.width - 20, 40)];
    self.usernameField.backgroundColor = [UIColor whiteColor];
    self.usernameField.placeholder = @"Username";
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameField.delegate = self;
    
    [self.containerStack addSubview:self.usernameField];
    
    self.passwordField = [[UITextField alloc]initWithFrame:CGRectMake(10, 60, self.containerStack.frame.size.width - 20, 40)];
    self.passwordField.secureTextEntry = YES; //Dots!
    self.passwordField.backgroundColor = [UIColor whiteColor];
    self.passwordField.placeholder = @"Password";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.delegate = self;
    
    [self.containerStack addSubview:self.passwordField];
    
    CGRect buttonFrame = CGRectMake(50, 110, self.containerStack.frame.size.width - 100, 40);
    
    self.proceedButton = [[UIButton alloc]initWithFrame:buttonFrame];
    [self.proceedButton addTarget:self action:@selector(handleProceed) forControlEvents:UIControlEventTouchUpInside];
    self.proceedButton.layer.cornerRadius = 10;
    self.proceedButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.proceedButton.layer.masksToBounds = YES;
    self.proceedButton.backgroundColor = [UIColor lightGrayColor];
    self.proceedButton.titleLabel.textColor = [UIColor whiteColor];
    [self.proceedButton setTitle:@"Proceed" forState:UIControlStateNormal];
    [self.containerStack addSubview:self.proceedButton];
}

- (BOOL)fieldsEmpty {
    return self.usernameField.text == nil && self.passwordField.text == nil;
}

- (void)handleProceed {
    
    if ([self fieldsEmpty] == YES) {
        [GlobalFunctions presentAlertWithTitle:@"You seem to be missing something" andText:@"Please check that you have a username and a password" fromVC:self];
    } else {
    if (self.createNewUser == YES) {
        
        User *theUser;
        
        theUser = nil;
        theUser = [[DatabaseManager sharedInstance]getUserDataByUsername:self.usernameField.text];
        if (theUser != nil) {
            [GlobalFunctions presentAlertWithTitle:@"This username already exists" andText:@"" fromVC:self];
        } else {
            
            theUser = [[User alloc] init];
            theUser.username = self.usernameField.text;
            theUser.password = self.passwordField.text;
            theUser.userPermissions = Permission_User;

            if (self.chosenImage) {
                [theUser setProfileImage:self.chosenImage]; //optional for now
            }
            
            BOOL newUserSuccess = [[DatabaseManager sharedInstance]insertUserData:theUser];
            
            if (newUserSuccess == YES) {
                
            } else {
                //Error
            }
        }
    } else {
        //Handle login
    }
    }
}

- (void)imagePickerSetup {
    if (self.imagePicker == nil) {
        self.imagePicker = [[UIImagePickerController alloc]init];
    }
    
    //TODO Check if available
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)enterApp {
    [self setUpTabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTabBarController {

    MainFeedViewController *mainVC = [MainFeedViewController new];
    BlocksViewController *blocksVC = [BlocksViewController new];

    mainVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"SQL" image:nil tag:0];
    blocksVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Blocks" image:nil tag:1];

    UITabBarController  *tabBarController = [[UITabBarController alloc]init];
    tabBarController.viewControllers = @[mainVC, blocksVC];

    [self.navigationController pushViewController:tabBarController animated:YES];
}

#pragma Delegates

//Image picker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
}

//Text field

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; 
    return YES;
}


@end
