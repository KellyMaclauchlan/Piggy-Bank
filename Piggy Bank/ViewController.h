//
//  ViewController.h
//  Piggy Bank
//
//  Created by Kelly Maclauchlan on 2016-07-07.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coin.h"
@interface ViewController : UIViewController
//data
@property (strong,nonatomic)NSMutableArray<Coin *> *money;// list of money value coin objects
@property (strong,nonatomic)NSMutableArray<Coin *> *last;//for undo

//ui
@property (strong,nonatomic)IBOutlet UIButton *button1;//.01 
@property (strong,nonatomic)IBOutlet UIButton *button2;//.05
@property (strong,nonatomic)IBOutlet UIButton *button3;//.10
@property (strong,nonatomic)IBOutlet UIButton *button4;//.25
@property (strong,nonatomic)IBOutlet UIButton *button5;//1
@property (strong,nonatomic)IBOutlet UIButton *button6;//2
@property (strong,nonatomic)IBOutlet UIButton *button7;//5
@property (strong,nonatomic)IBOutlet UIButton *button8;//10
@property (strong,nonatomic)IBOutlet UIButton *button9;//20
@property (strong,nonatomic)IBOutlet UIButton *button10;//50
@property (strong,nonatomic)IBOutlet UIButton *button11;//100
@property (strong,nonatomic)IBOutlet UIButton *undo;//20
@property (strong,nonatomic)IBOutlet UIButton *clear;//50
@property (strong,nonatomic)IBOutlet UIButton *amount;//100

@property (strong,nonatomic)NSMutableArray *coins;//buttons
@property (strong,nonatomic)NSMutableArray *labels;//buttons

@property(strong,nonatomic)IBOutlet UILabel *totalText;
@property (strong,nonatomic)IBOutlet UILabel *label1;//.01
@property (strong,nonatomic)IBOutlet UILabel *label2;//.05
@property (strong,nonatomic)IBOutlet UILabel *label3;//.10
@property (strong,nonatomic)IBOutlet UILabel *label4;//.25
@property (strong,nonatomic)IBOutlet UILabel *label5;//1
@property (strong,nonatomic)IBOutlet UILabel *label6;//2
@property (strong,nonatomic)IBOutlet UILabel *label7;//5
@property (strong,nonatomic)IBOutlet UILabel *label8;//10
@property (strong,nonatomic)IBOutlet UILabel *label9;//20
@property (strong,nonatomic)IBOutlet UILabel *label10;//50
@property (strong,nonatomic)IBOutlet UILabel *label11;//100
-(IBAction)buttonHit:(id)sender;
-(IBAction)undoHit:(id)sender;
-(IBAction)clearHit:(id)sender;
-(IBAction)ammountHit:(id)sender;

@end

