//
//  ViewController.m
//  Piggy Bank
//
//  Created by Kelly Maclauchlan on 2016-07-07.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//
#import "Coin.h"
#import "ViewController.h"

@interface ViewController (){
    Boolean amountBool;
    NSFileManager *filemgr;
    NSArray *dirPaths;
    NSString *docsDir;
}


@end

@implementation ViewController
//coins and bills
@synthesize button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11;
@synthesize label1,label2,label3,label4,label5,label6,label7,label8,label9,label10,label11;
//other ui
@synthesize undo,clear,amount,totalText;
//lists
@synthesize money,last,coins,labels;

- (void)setUp {
    // calls the other set ups
    [self setupMoney];
    [self setupUIComponents];
    filemgr=[NSFileManager defaultManager];
    dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir=dirPaths[0];
    [self readSaveData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUIComponents{
    //set up buttons
    coins=[[NSMutableArray alloc]init];
    [coins addObject:button1];
    [coins addObject:button2];
    [coins addObject:button3];
    [coins addObject:button4];
    [coins addObject:button5];
    [coins addObject:button6];
    [coins addObject:button7];
    [coins addObject:button8];
    [coins addObject:button9];
    [coins addObject:button10];
    [coins addObject:button11];
    
    //set up labels
    labels=[[NSMutableArray alloc]init];
    [labels addObject:label1];
    [labels addObject:label2];
    [labels addObject:label3];
    [labels addObject:label4];
    [labels addObject:label5];
    [labels addObject:label6];
    [labels addObject:label7];
    [labels addObject:label8];
    [labels addObject:label9];
    [labels addObject:label10];
    [labels addObject:label11];
    
    amountBool=false;
    for (UILabel  *label in labels) {
        [label setHidden:true];
    }
    
    
}
-(void)setupMoney{
    last=[[NSMutableArray alloc]init];
    money=[[NSMutableArray alloc]init];
    [money addObject:[[Coin alloc]init: 0.01]];
    [money addObject:[[Coin alloc]init: 0.05]];
    [money addObject:[[Coin alloc]init: 0.10]];
    [money addObject:[[Coin alloc]init: 0.25]];
    [money addObject:[[Coin alloc]init: 1.00]];
    [money addObject:[[Coin alloc]init: 2.00]];
    [money addObject:[[Coin alloc]init: 5.00]];
    [money addObject:[[Coin alloc]init: 10.00]];
    [money addObject:[[Coin alloc]init: 25.00]];
    [money addObject:[[Coin alloc]init: 50.00]];
    [money addObject:[[Coin alloc]init: 100.00]];
}

-(void)showTotal{
    [self setTotal];
    for (UILabel  *label in labels) {
        [label setHidden:false];
    }
}
-(void)showCount{
    for (UILabel  *label in labels) {
        [label setHidden:true];
    }
    [[coins objectAtIndex:0]setTitle:@"1¢" forState:UIControlStateNormal];
    [[coins objectAtIndex:1]setTitle:@"5¢" forState:UIControlStateNormal];
    [[coins objectAtIndex:2]setTitle:@"10¢" forState:UIControlStateNormal];
    [[coins objectAtIndex:3]setTitle:@"25¢" forState:UIControlStateNormal];
    [[coins objectAtIndex:4]setTitle:@"$1" forState:UIControlStateNormal];
    [[coins objectAtIndex:5]setTitle:@"$2" forState:UIControlStateNormal];
    [[coins objectAtIndex:6]setTitle:@"$5" forState:UIControlStateNormal];
    [[coins objectAtIndex:7]setTitle:@"$10" forState:UIControlStateNormal];
    [[coins objectAtIndex:8]setTitle:@"$20" forState:UIControlStateNormal];
    [[coins objectAtIndex:9]setTitle:@"$50" forState:UIControlStateNormal];
    [[coins objectAtIndex:10]setTitle:@"$100" forState:UIControlStateNormal];
    
}
-(void)changes{
    if(amountBool){
        amountBool=false;
        [self showCount];
    }else{
        amountBool=true;
        [self showTotal];
    }
    [self update];
    
}

- (void)setTotal {
    double total=0;
    for (Coin *c in money) {
        total+=[c total];
    }
    NSString *tot=[NSString stringWithFormat:@"Total: $%.2f",total];
    [totalText setText:tot];
}

-(void)update{
    [self setTotal];
    if(amountBool){
        for (int i=0; i<[coins count]; i++) {
            [[coins objectAtIndex:i] setTitle:@""];
            [[coins objectAtIndex:i] setTitle:[[money objectAtIndex:i] getCount] forState:UIControlStateNormal];
        }
    }
    if ([last count]>0) {
        [undo setHidden:false];
    }else{
        [undo setHidden:true];
    }
}

-(void)clearAll{
    for (Coin *c in money) {
        [c reset];
    }
    [last removeAllObjects];
    [self update];
}

-(void)undoAction{
    if([last count]>0){
        [(Coin *)[last lastObject] undo];
        [last removeLastObject];
        [self update];
    }
    
}

-(void)readSaveData{
    NSString *filePath=[docsDir stringByAppendingString:@"textfile.txt"];
    NSData *dataBuffer;
    NSFileHandle *file=[NSFileHandle fileHandleForWritingAtPath:filePath];
    if(file==nil){
        NSLog(@"failed to open file");
        return;
    }
    dataBuffer =[file readDataToEndOfFile];
    [file closeFile];
    //string of file contents
    NSString *dataString=[[NSString alloc]initWithData:dataBuffer encoding:NSASCIIStringEncoding];
    
    NSArray *split=[dataString componentsSeparatedByString:@" "];
    for (int i=0; i<[split count]; i++) {
        for (int j=0; j<[money count]; j++) {
            if([[money objectAtIndex:j] getValue]==[split[i] doubleValue] ){
                i++;
                [[money objectAtIndex:j]setCount:(int)[split[i] integerValue]];
                break;
            }
        }
    }
    [self update];
    
}
-(void)saveFile{
    //string to be saved
    NSString *saveData=@"";
    for (Coin *c in money) {
        [saveData stringByAppendingString:[c getString]];
    }
    
    NSString *filePath=[docsDir stringByAppendingString:@"textfile.txt"];
    NSData *dataBuffer=[@"PREFIX: " dataUsingEncoding:NSASCIIStringEncoding];
    [filemgr createFileAtPath:filePath contents:dataBuffer attributes:nil];
    
    NSFileHandle *file=[NSFileHandle fileHandleForWritingAtPath:filePath];
    if(file==nil){
        NSLog(@"failed to open file");
        return;
    }
    
    NSMutableData *data =[NSMutableData dataWithData:[saveData dataUsingEncoding:NSASCIIStringEncoding]];
    
    [file writeData:data];
    [file closeFile];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self saveFile];
}
-(IBAction)buttonHit:(id)sender{
    for (int i=0; i<[money count]; i++) {
        if([[coins objectAtIndex:i] isEqual:sender]){
            [[money objectAtIndex:i] add];
            [last addObject:[money objectAtIndex:i]];
            [self update];
        }
    }
}
-(IBAction)undoHit:(id)sender{
    [self undoAction];
}
-(IBAction)clearHit:(id)sender{
    [self clearAll];
}
-(IBAction)ammountHit:(id)sender{
    [self changes];
}

@end
