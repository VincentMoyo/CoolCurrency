//
//  CurrencyConversionViewController.m
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/14.
//

#import "CurrencyConversionViewController.h"

@interface CurrencyConversionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currencyValueInsert;
@property (weak, nonatomic) IBOutlet UILabel *currencyValueDisplay;
@property (weak, nonatomic) IBOutlet UILabel *leftCurrencyCode;
@property (weak, nonatomic) IBOutlet UIView *rightCurrencyCode;
@property (weak, nonatomic) IBOutlet UILabel *displayLeftCurrencyToRightCurrency;
@property (weak, nonatomic) IBOutlet UILabel *displayRightCurrencyToLeftCurrency;

@end

@implementation CurrencyConversionViewController

-(id) initWith:(ConvertCurrencyDataModel *)dataModel {
    self.viewModel.dataModel = dataModel;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)ConvertCurrencyPressed:(UIButton *)sender {
    self.displayLeftCurrencyToRightCurrency.text = self.viewModel.dataModel.primaryCurrencyName;
}

- (IBAction)SwapCurrency:(UIButton *)sender {
    self.displayLeftCurrencyToRightCurrency.text = self.viewModel.dataModel.primaryCurrencyName;
}

@end
