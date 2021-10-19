//
//  ConversionCurrencyViewModel.h
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/18.
//

#import <Foundation/Foundation.h>
#import "CoolCurrency-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversionCurrencyViewModel : NSObject

- (void)set:(ConvertCurrencyDataModel *)currencyConversion;
- (NSString *)primaryCurrencyName;
- (NSString *)secondaryCurrencyName;
- (NSString *)primaryFlagName;
- (NSString *)secondaryFlagName;
- (NSString *)secondaryCurrency;
- (void)setSecondaryCurrency: (double) newSecondaryCurrency;
- (NSString *)multiplyCurrencyBy: (double)multipler;
- (NSString *)primaryCurrencyValueComparison;
- (NSString *)secondaryCurrencyValueComparison;

@end

NS_ASSUME_NONNULL_END
