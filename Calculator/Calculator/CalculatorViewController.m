//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Steven on 4/7/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL isUserInTheMiddleOrBeginning;
@property (nonatomic) BOOL isDigitContainADot;
@property (nonatomic,strong) CalculatorBrain *brain;
@property (nonatomic) BOOL isNotAtBeginning;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize isUserInTheMiddleOrBeginning = _isUserInTheMiddleOrBeginning;
@synthesize isDigitContainADot = _isDigitContainADot;
@synthesize brain = _brain;
@synthesize historyDisplay = _historyDisplay;
@synthesize isNotAtBeginning = _isNotAtBeginning;
- (CalculatorBrain *) brain{
    if (!_brain){
        _brain = [CalculatorBrain alloc];
    }
    return _brain;
}
- (IBAction)clear {
    [self.brain clearAllDigitStackAndOperation];
    extern int testExternVariable;
    
    self.display.text = @"0";
    self.historyDisplay.text = @"0";
    self.isUserInTheMiddleOrBeginning = NO;
    self.isNotAtBeginning = NO;
    
}
- (IBAction)pressFunction:(UIButton *)sender {
    [self addHistoryDisplayData:self.display.text];
    [self.brain pushOperand:[NSNumber numberWithDouble:[self.display.text doubleValue]]];
    NSString *functionType = [sender currentTitle];
    [self.brain pushOperand:functionType];
    self.display.text= [NSString stringWithFormat:@"%g",[self.brain peformOperation]];
    [self addHistoryDisplayData:[sender currentTitle]];
    [self addHistoryDisplayData:@"="];
    self.isUserInTheMiddleOrBeginning = NO;

}

- (IBAction)pressDot{
    if(_isUserInTheMiddleOrBeginning &&
       !_isDigitContainADot){
        [self.display setText:[_display.text stringByAppendingString:@"."]];
        _isDigitContainADot = YES;
    }
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (_isUserInTheMiddleOrBeginning) {
    [self.display setText:([self.display.text stringByAppendingString:digit ])];
    }else{
        self.display.text = digit;
        _isUserInTheMiddleOrBeginning = YES;
    }

}
- (IBAction)operation:(UIButton *)sender{
    [self.brain pushOperand:[NSNumber numberWithDouble:[self.display.text doubleValue]]];
    [self.brain pushOperand:[sender currentTitle]];
    [self addHistoryDisplayData:self.display.text];
    [self addHistoryDisplayData:[sender currentTitle]];
    _isUserInTheMiddleOrBeginning = NO;
    _isDigitContainADot = NO;
}

- (IBAction)enterPress{
    [self.brain pushOperand:[NSNumber numberWithDouble:[self.display.text doubleValue]]];
    [self addHistoryDisplayData:self.display.text];
    self.display.text= [NSString stringWithFormat:@"%g",[self.brain peformOperation]];
    if(([self.display.text rangeOfString:@"."]).location == NSNotFound){
        _isDigitContainADot = NO;
    }
    [self addHistoryDisplayData:@"="];
    self.isUserInTheMiddleOrBeginning = NO;
}

- (void)addHistoryDisplayData:(NSString *) inputData{
    NSString *currentText = self.historyDisplay.text;
    if(_isNotAtBeginning){
    self.historyDisplay.text = [[currentText stringByAppendingString:@" "] stringByAppendingString:inputData];
    }else{
        self.historyDisplay.text = self.display.text;
        _isNotAtBeginning = YES;
    }
}
@end
