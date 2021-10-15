//
//  CurrencyConversionViewController.h
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/14.
//

#import <UIKit/UIKit.h>
#import "CoolCurrency-Swift.h"
#import "ConvertCurrencyViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyConversionViewController : UIViewController

-(id) initWith:(ConvertCurrencyDataModel *)dataModel;
@property (strong, nonatomic) ConvertCurrencyViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
