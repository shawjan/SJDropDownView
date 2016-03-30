//
//  ViewController.m
//  SJDropDownViewDemo
//
//  Created by shawjan on 16/3/30.
//  Copyright © 2016年 shawjan. All rights reserved.
//

#import "ViewController.h"
#import "SJDropDownView.h"

@interface ViewController ()
@property(nonatomic, strong) SJDropDownView *dropView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dropView = [[SJDropDownView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.dropView];
    [[NSNotificationCenter defaultCenter] addObserver:self.dropView selector:@selector(changeTableViewValues) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.dropView name:UITextFieldTextDidChangeNotification object:nil];
}

@end
