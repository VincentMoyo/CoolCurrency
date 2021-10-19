//
//  TestingViewController.m
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/15.
//

#import "CurrencyConversionsViewController.h"
#import "ConversionCurrencyViewModel.h"

@interface CurrencyConversionsViewController () {
    
    ConversionCurrencyViewModel * _viewModel;
    IBOutlet UITextField *currencyValueInsert;
    IBOutlet UILabel *leftCurrencyCode;
    IBOutlet UILabel *rightCurrencyCode;
    IBOutlet UILabel *currencyValueDisplay;
    IBOutlet UILabel *primaryCurrencyComparison;
    IBOutlet UILabel *secondaryCurrencyComparison;
    
}
@end

@implementation CurrencyConversionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCurrencyCodeLabels];
    currencyValueInsert.delegate = self;
}

- (void)set:(ConvertCurrencyDataModel *)currencyConversion {
    [self setupViewModel];
    [_viewModel set:currencyConversion];
}

- (void)setupViewModel {
    if (!_viewModel) {
        _viewModel = [[ConversionCurrencyViewModel alloc] init];
    }
}

- (void) setupCurrencyCodeLabels {
    leftCurrencyCode.text = _viewModel.primaryCurrencyName;
    rightCurrencyCode.text = _viewModel.secondaryCurrencyName;
    primaryCurrencyComparison.text = [_viewModel primaryCurrencyValueComparison];
    secondaryCurrencyComparison.text = [_viewModel secondaryCurrencyValueComparison];
}

- (IBAction)ConvertCurrencyPressed:(UIButton *)sender {
    currencyValueDisplay.text = [_viewModel multiplyCurrencyBy: [currencyValueInsert.text doubleValue]];
}

- (IBAction)SwapCurrency:(UIButton *)sender {
    NSString *temporaryCurrencyName = leftCurrencyCode.text;
    leftCurrencyCode.text = rightCurrencyCode.text;
    rightCurrencyCode.text = temporaryCurrencyName;
}

@end
