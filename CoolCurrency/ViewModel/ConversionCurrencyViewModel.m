//
//  ConversionCurrencyViewModel.m
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/18.
//

#import "ConversionCurrencyViewModel.h"
#import "CoolCurrency-Swift.h"

@implementation ConversionCurrencyViewModel

ConvertCurrencyDataModel *_dataModel;

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)set:(ConvertCurrencyDataModel *)currencyConversion {
    _dataModel = currencyConversion;
}

- (NSString *)primaryCurrencyName {
    return _dataModel.primaryCurrencyName;
}

- (NSString *)secondaryCurrencyName {
    return _dataModel.secondCurrencyName;
}

- (NSString *)secondaryCurrency {
    return [NSString stringWithFormat: @"%f", _dataModel.secondCurrency];
}

- (void)setSecondaryCurrency: (double) newSecondaryCurrency {
    _dataModel.secondCurrency = newSecondaryCurrency;
}

- (NSString *)primaryFlagName {
    return _dataModel.primaryCurrencyFlagName;
}

- (NSString *)secondaryFlagName {
    return _dataModel.secondaryCurrencyFlagName;
}

- (NSString *)multiplyCurrencyBy: (double)multipler {
    double multipliedCurrency = multipler * _dataModel.secondCurrency;
    return roundToTwo(multipliedCurrency);
}

NSString* roundToTwo(double number) {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    formatter.roundingMode = NSNumberFormatterRoundUp;
    
    return [formatter stringFromNumber:@(number)];
}

- (NSString *)primaryCurrencyValueComparison {
    return [NSString stringWithFormat: @"1 %@ = %f %@",_dataModel.primaryCurrencyName, _dataModel.secondCurrency, _dataModel.secondCurrencyName];
}

- (NSString *)secondaryCurrencyValueComparison {
    double convertedCurrency = 1 / _dataModel.secondCurrency;
    return [NSString stringWithFormat: @"%f %@ = 1 %@",convertedCurrency,_dataModel.primaryCurrencyName,_dataModel.secondCurrencyName];
}

@end
