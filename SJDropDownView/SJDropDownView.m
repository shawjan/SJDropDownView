//
//  SJDropDownView.m
//  SJDropDownViewDemo
//
//  Created by shawjan on 16/3/30.
//  Copyright © 2016年 shawjan. All rights reserved.
//

#import "SJDropDownView.h"

@interface SJDropDownView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *postfixArr;
@property(nonatomic, strong) NSMutableArray *postfixMutalArr;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UITextField *inputField;
@property(nonatomic, strong) NSString *prefix;

@end

@implementation SJDropDownView

NSInteger rowheight = 30;

-(NSArray *)postfixArr
{
    return @[@"@163.com", @"@126.com", @"@188.com", @"@yeah.net", @"@vip.163.com", @"@vip.126.com"];
}

-(NSMutableArray*)postfixMutalArr
{
    if(!_postfixMutalArr){
        _postfixMutalArr = [[NSMutableArray alloc] init];
    }
    return _postfixMutalArr;
}

-(UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 + rowheight, self.frame.size.width, 0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 5;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor grayColor];
        [self addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SJDropDownViewCellIdentifier"];
    }
    return _tableView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, rowheight)];
        self.inputField.placeholder = @"邮箱";
        self.inputField.borderStyle = UITextBorderStyleLine;
        [self addSubview:self.inputField];
    }
    return self;
}

-(void)changeTableViewValues
{
    NSRange range = [self.inputField.text localizedStandardRangeOfString:@"@"];
    if(range.location != NSNotFound){
        self.prefix = [self.inputField.text substringToIndex:range.location];
        NSString *postifx = [self.inputField.text substringFromIndex:range.location];
        [self.postfixMutalArr removeAllObjects];
        for (NSString *str in self.postfixArr) {
            if([str isEqualToString:postifx] || (str.length > postifx.length && [str hasPrefix: postifx]) )
            {
                [self.postfixMutalArr addObject:str];
            }
        }
    }else{
        self.prefix = self.inputField.text;
        [self.postfixMutalArr removeAllObjects];
        for (NSString *str in self.postfixArr) {
            [self.postfixMutalArr addObject:str];
        }
    }
    if([self.prefix isEqualToString:@""]){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.tableView.frame = CGRectMake(0, 20 + rowheight, self.frame.size.width, 0);
        [UIView commitAnimations];
    }else{
        [self.tableView reloadData];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.tableView.frame = CGRectMake(0, 20 + rowheight, self.frame.size.width, rowheight * [self.postfixMutalArr count]);
        [UIView commitAnimations];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.postfixMutalArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowheight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SJDropDownViewCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", self.prefix, [self.postfixMutalArr objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.inputField.text = [NSString stringWithFormat:@"%@%@", self.inputField.text, [self.postfixMutalArr objectAtIndex:indexPath.row]];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.tableView.frame = CGRectMake(0, 20 + rowheight, self.frame.size.width, 0);
    [UIView commitAnimations];
};

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
