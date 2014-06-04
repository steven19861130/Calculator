//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Steven on 4/8/14.
//  Copyright (c) 2014 Steven. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain();
@property (nonatomic,strong) NSMutableArray *programStack;
@property (nonatomic,strong) NSArray *operationStoredArray;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;
@synthesize operationStoredArray = _operationStoredArray;


- (NSArray *)operationStoredArray{
    if(_operationStoredArray == nil){
        _operationStoredArray = [NSArray arrayWithObjects:@"+", @"-",@"*",@"/", nil];
    }
    return _operationStoredArray;
}
- (NSMutableArray *) programStack{
    if (_programStack == nil){
        _programStack = [ [NSMutableArray alloc] init];
    }
    return _programStack;
}


-(void) clearAllDigitStackAndOperation{
    self.programStack = nil;
}

-(id) popOperand{
    
    NSNumber *lastOperand = [[self programStack] lastObject];
    if(lastOperand){
        [self.programStack removeLastObject];
    }
    return lastOperand;
}

- (void)pushOperand : (id)operand{
    if([operand isKindOfClass:[NSString class]]){
        [[self programStack] addObject:(NSString *)operand];
    }
    else if ([operand isKindOfClass:[NSNumber class]]){
        [[self programStack] addObject:(NSNumber *)operand];

    }
}
- (double)peformOperation {
    [CalculatorBrain adjustStackPlace:self.programStack];
    double result = [CalculatorBrain runProgram:self.program];
    [self clearAllDigitStackAndOperation];
    return result;
}

- (id)program{
    return [self.programStack copy];
}

+ (void)adjustStackPlace:(NSMutableArray *)stack{
    if(stack.count == 3){
    NSNumber *number = stack.lastObject;
    [stack removeLastObject];
    NSString *operation = stack.lastObject;
    [stack removeLastObject];
    [stack addObject:number];
    [stack addObject:operation];
    }
}

+ (NSString *)descriptionProgram:(id)program{
    return @"assignment 2";
}

+ (double)runProgram:(id)program{
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]){
        stack = [program mutableCopy];
    }
    return [self operationResult:stack];
}
+ (double)operationResult:(NSMutableArray *)stack{
    NSString *operation;
    id lastObject = [stack lastObject];
    if(lastObject){
        [stack removeLastObject];
    }
    
    if([lastObject isKindOfClass:[NSString class]]){
        operation = lastObject;
    }
    else if ([lastObject isKindOfClass:[NSNumber class]]){
        NSNumber *operNumber = lastObject;
        return [operNumber doubleValue];
    }
    if([operation isEqualToString:@"*"]){
        return [self operationResult:stack] * [self operationResult:stack];
    }
    else if ([operation isEqualToString:@"/"]){
        double previousNumber = [self operationResult:stack];
        return[self operationResult:stack] / previousNumber;
    }
    else if ([operation isEqualToString:@"-"]){
        double previousNumber = [self operationResult:stack];
        return[self operationResult:stack] - previousNumber;;
    }
    else if ([operation isEqualToString:@"+"]){
        return[self operationResult:stack] + [self operationResult:stack];
    }
    else if ([operation isEqualToString:@"Sin"]){
        return sin([self operationResult:stack]);
    }
    else if ([operation isEqualToString:@"Cos"]){
        return cos([self operationResult:stack]);
    }
    else if ([operation isEqualToString:@"Sqr"]){
        return sqrt([self operationResult:stack]);
    }
    return 0;
    
}





@end
