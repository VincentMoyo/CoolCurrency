//
//  TestingViewController.h
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/15.
//

#import <UIKit/UIKit.h>
@class ConvertCurrencyDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyConversionsViewController : UIViewController <UITextFieldDelegate>

- (void)set:(ConvertCurrencyDataModel *)currencyConversion;

@end

NS_ASSUME_NONNULL_END
