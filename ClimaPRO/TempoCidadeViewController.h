//
//  TempoCidadeViewController.h
//  ClimaPRO
//
//  Created by Douglas Camargo on 01/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface TempoCidadeViewController : UIViewController
@property(nonatomic, retain) NSDictionary *cidadeSelecionada;
@property(nonatomic, retain) ASIHTTPRequest *requestAtual;
@end
