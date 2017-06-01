//
//  TTChatTableViewCell.m
//  TTChatDemo
//
//  Created by zhang liangwang on 17/2/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTChatTableViewCell.h"

// define this constant if you want to use Masony without the 'mas_' prefix
#define MAS_SHORTHAND
// define this constant if you want to enable auto_boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

@interface TTChatTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UIImageView *otherHeadImageView;
@property (strong, nonatomic) IBOutlet UIButton *otherTextBtn;

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UIButton *textBtn;


@end

@implementation TTChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textBtn.titleLabel.numberOfLines = 0;
    self.otherTextBtn.titleLabel.numberOfLines = 0;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *TTChatTableViewCellIdentifier = @"ChatTableViewCellIdentifier";
    TTChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TTChatTableViewCellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    
    cell.selected = false;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}


- (void)setModel:(TTMessageModel *)model {
    
    _model = model;
    
    self.timeLabel.text = model.time;
    
    if (model.hiddenTime) {
        self.timeLabel.hidden = true;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    } else {
        self.timeLabel.hidden = false;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(16);
        }];
    }
    
    if (model.type == TTMessageModelType_Me) {
        
        [self configShowText:self.textBtn showImageView:self.headImageView hiddenText:self.otherTextBtn hiddenImageView:self.otherHeadImageView messageModel:model];
        
    } else if (model.type == TTMessageModelType_Other){
        
        [self configShowText:self.otherTextBtn showImageView:self.otherHeadImageView hiddenText:self.textBtn hiddenImageView:self.headImageView messageModel:model];
    }
}


- (void)configShowText:(UIButton *)showText showImageView:(UIImageView *)showImageView hiddenText:(UIButton *)hiddenText hiddenImageView:(UIImageView *)hiddenImageView messageModel:(TTMessageModel *)messageModel{
    
    showText.hidden = false;
    showImageView.hidden = false;
    
    hiddenText.hidden = true;
    hiddenImageView.hidden = true;
    
    [showText setTitle:messageModel.text forState:UIControlStateNormal];
    
    [self layoutIfNeeded];

    [showText updateConstraints:^(MASConstraintMaker *make) {
        
        CGFloat btnH = showText.titleLabel.frame.size.height + 30;
        make.height.equalTo(btnH);
        
    }];
    
    [self layoutIfNeeded];
    
    
    //拿到按钮的最大高度
    CGFloat btnMaxY = CGRectGetMaxY(showText.frame);
    //拿到头像的最大高度
    CGFloat headImageViewMaxY = CGRectGetMaxY(showImageView.frame);
    
    messageModel.cellHeight = MAX(btnMaxY, headImageViewMaxY) + 10;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end






































