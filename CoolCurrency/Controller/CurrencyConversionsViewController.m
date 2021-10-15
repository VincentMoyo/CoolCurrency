//
//  TestingViewController.m
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/15.
//

#import "CurrencyConversionsViewController.h"

@interface CurrencyConversionsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currencyValueInsert;
@property (weak, nonatomic) IBOutlet UILabel *currencyValueDisplay;
@property (weak, nonatomic) IBOutlet UILabel *leftCurrencyCode;
@property (weak, nonatomic) IBOutlet UIView *rightCurrencyCode;
@property (weak, nonatomic) IBOutlet UILabel *displayLeftCurrencyToRightCurrency;
@property (weak, nonatomic) IBOutlet UILabel *displayRightCurrencyToLeftCurrency;

@property (strong, nonatomic) ConvertCurrencyDataModel *dataModels;

@end

@implementation CurrencyConversionsViewController

- (instancetype)initWith:(ConvertCurrencyDataModel *)dataModel {
    if ((self = [super init])) {
        self.viewModel.dataModel = dataModel;
        self.dataModels = dataModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)ConvertCurrencyPressed:(UIButton *)sender {
    self.currencyValueDisplay.text = self.dataModels.primaryCurrencyName;
}

- (IBAction)SwapCurrency:(UIButton *)sender {
    self.displayLeftCurrencyToRightCurrency.text = self.viewModel.dataModel.primaryCurrencyName;
}

@end
