//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Steven on 4/8/14.
//  Copyright (c) 2014 Steven. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CalculatorBrain : NSObject
- (void)pushOperand : (id)operand;
- (double)peformOperation;
- (void)clearAllDigitStackAndOperation;

@property (readonly) id program;
+ (double)runProgram:(id) program;
+ (NSString *)descriptionProgram:(id) program;
@end
