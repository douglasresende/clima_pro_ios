//
//  TempoCidadeViewController.m
//  ClimaPRO
//
//  Created by Douglas Camargo on 01/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import "TempoCidadeViewController.h"
#define TAG_TEMP_CURRENT 1
#define TAG_TEMP_MIN 2
#define TAG_TEMP_MAX 3

@interface TempoCidadeViewController ()

@end

@implementation TempoCidadeViewController
@synthesize cidadeSelecionada, requestAtual;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated
{
    [ProgressHUD show:@"Aguarde"];
    [self findData];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.requestAtual cancel];
}

-(void) findData
{
    NSString *lat = [cidadeSelecionada valueForKey:@"latitude"];
    NSString *lon = [cidadeSelecionada valueForKey:@"longitude"];
    NSString *url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%1$@&lon=%2$@&units=metric", lat, lon];

    ASIFormDataRequest *request =
    [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    
    //    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //    [request addRequestHeader:@"Accept" value:@"application/json"];
    
    [request setRequestMethod:@"GET"];
//    [request setDelegate:self];
//    [request setPostValue:@"-22.91" forKey:@"lat"];
//    [request setPostValue:@"-43.18" forKey:@"lon"];
//    [request setPostValue:@"metric" forKey:@"units"];
    
    [request setCompletionBlock:^{
        [ProgressHUD dismiss];
        
        if (request.responseStatusCode == 200) {
            NSString *responseString = [request responseString];
            NSError *error;
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *results = [[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] objectForKey:@"main"];
            
            UILabel *labelTempCurrent = (UILabel *) [self.view viewWithTag:TAG_TEMP_CURRENT];
            NSInteger integerTempCurrent = (NSInteger*)[(NSNumber*)[results objectForKey:@"temp"] integerValue];
            NSString *tempCurrent = [NSString stringWithFormat: @"%d", integerTempCurrent];
            labelTempCurrent.text = tempCurrent;
            
            UILabel *labelTempMin = (UILabel *) [self.view viewWithTag:TAG_TEMP_MIN];
            NSString *tempMin = [(NSNumber*)[results objectForKey:@"temp_min"] stringValue];
            labelTempMin.text = [tempMin stringByAppendingString:@" min"];
            
            UILabel *labelTempMax = (UILabel *) [self.view viewWithTag:TAG_TEMP_MAX];
            NSString *tempMax = [(NSNumber*)[results objectForKey:@"temp_max"] stringValue];
            labelTempMax.text = [tempMax stringByAppendingString:@" max"];
        }else{
            [ProgressHUD showError:@"Presto Nao"];
        }
    }];
    
    [request setFailedBlock:^{
        [ProgressHUD showError:@"Erro de conexão!"];
    }];
    
    [ProgressHUD show:@"Carregando"];
    self.requestAtual = request;
    //  RODAR EM UMA THREAD SEPARADA
    [request startAsynchronous];
}


/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
     self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
     if (self) {
     // Custom initialization
    }
     return self;
 }
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
