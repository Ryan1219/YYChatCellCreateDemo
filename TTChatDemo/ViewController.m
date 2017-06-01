//
//  ViewController.m
//  TTChatDemo
//
//  Created by zhang liangwang on 17/2/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "ViewController.h"
#import "TTChatTableViewCell.h"
#import "TTMessageModel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *messageArray;

@end

@implementation ViewController


//MARK:-加载数据
- (NSArray *)messageArray {
    if (_messageArray == nil) {
        
        NSArray *messageArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"message" ofType:@"plist"]];
        NSMutableArray *tempArray = [NSMutableArray array];
        //记录上一下消息模型
        TTMessageModel *lastMessageModel = nil;
        for (NSDictionary *dict in messageArray) {
            TTMessageModel *messageModel = [TTMessageModel messageWithDict:dict];
            messageModel.hiddenTime = [messageModel.time isEqualToString:lastMessageModel.time];
            [tempArray addObject:messageModel];
            
            lastMessageModel = messageModel;
        }
        _messageArray = tempArray;
        
    }
    return _messageArray;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
//    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self configTableView];
    [self configBottomView];
    
    
    //处理键盘弹出和隐藏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//MARK:-dealloc
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//MARK:-聊天界面
- (void)configTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
}

//MARK:-底部输入框界面
- (void)configBottomView {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomView];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, ScreenWidth-80, 40)];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.borderStyle = UITextBorderStyleLine;
    [bottomView addSubview:textField];
}

//MARK:-键盘弹出和隐藏处理
- (void)keyBoardWillShow:(NSNotification *)note {
    
    //获取键盘弹窗的高度
    CGRect keyFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘弹窗的时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画时间
    [UIView animateWithDuration:duration animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, -keyFrame.size.height);
    }];
    
}

- (void)keyBoardWillHide:(NSNotification *)note {
    
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}


//- (void)keyBoardChangeFrame:(NSNotification *)note {
//    
//    CGRect keyFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    [UIView animateWithDuration:duration animations:^{
//        
//        CGFloat keyY = ScreenHeight - keyFrame.origin.y;
//        self.view.transform = CGAffineTransformMakeTranslation(0, -keyY);
//    }];
//}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:true];
}

//MARK:-UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTChatTableViewCell *cell = [TTChatTableViewCell cellWithTableView:tableView];
    
    cell.model= self.messageArray[indexPath.row];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTMessageModel *model = self.messageArray[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    TTMessageModel *model = self.messageArray[indexPath.row];
    NSLog(@"---%f---",model.cellHeight);
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end









































