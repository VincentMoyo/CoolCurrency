//
//  ConversionCurrencyViewModel.m
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/18.
//

#import "ConversionCurrencyViewModel.h"

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

- (NSString *)multiplyCurrencyBy: (double)multipler {
    double multipliedCurrency = multipler * _dataModel.secondCurrency;
    return [NSString stringWithFormat: @"%f", multipliedCurrency];
}

- (NSString *)primaryCurrencyValueComparison {
    return [NSString stringWithFormat: @"1 %@ = %f %@",_dataModel.primaryCurrencyName, _dataModel.secondCurrency, _dataModel.secondCurrencyName];
}

- (NSString *)secondaryCurrencyValueComparison {
    double convertedCurrency = 1 / _dataModel.secondCurrency;
    return [NSString stringWithFormat: @"%f %@ = 1 %@",convertedCurrency,_dataModel.primaryCurrencyName,_dataModel.secondCurrencyName];
}

@end
