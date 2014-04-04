//
//  SecondViewController.m
//  ClimaPRO
//
//  Created by Douglas Camargo on 01/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import "SecondViewController.h"
#define TAG_NOME_CIDADE 1

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize arrayDeCidades;

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayDeCidades = [NSArray arrayWithContentsOfFile:[
                                                      [NSBundle mainBundle] pathForResource:@"cidades" ofType:@"plist"]
                     ];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"LISTA DE CIDADES";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayDeCidades.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"listaCidades"];
    
    UILabel *labelNome = (UILabel *) [myCell viewWithTag:TAG_NOME_CIDADE];
    NSDictionary *cidade = [arrayDeCidades objectAtIndex:[indexPath row]];
    labelNome.text = [cidade valueForKey:@"nome"];
    return myCell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cidade = [arrayDeCidades objectAtIndex:[indexPath row]];
    cidadeSelecionada = cidade;
    
    [self performSegueWithIdentifier:@"segueTempoCidade" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.title = @"Cidades";
    TempoCidadeViewController *segueTempoCidade = segue.destinationViewController;
    segueTempoCidade.title = [cidadeSelecionada valueForKey:@"nome"];
    segueTempoCidade.cidadeSelecionada = cidadeSelecionada;
}

@end
