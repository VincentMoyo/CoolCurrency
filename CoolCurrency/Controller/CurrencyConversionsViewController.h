//
//  TestingViewController.h
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/15.
//

#import <UIKit/UIKit.h>
#import "ConvertCurrencyViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyConversionsViewController : UIViewController

- (instancetype)initWith:(ConvertCurrencyDataModel *)dataModel;
@property (strong, nonatomic) ConvertCurrencyViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
