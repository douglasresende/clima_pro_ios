//
//  SecondViewController.h
//  ClimaPRO
//
//  Created by Douglas Camargo on 01/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempoCidadeViewController.h"

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *cidadeSelecionada;
}
@property(nonatomic, retain) NSArray *arrayDeCidades;
@end
