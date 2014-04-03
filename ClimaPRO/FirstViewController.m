//
//  FirstViewController.m
//  ClimaPRO
//
//  Created by Douglas Camargo on 01/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize mapView, arrayDeCidades;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self carregarDados];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    self.title = @"Mapa";
}
-(void) carregarDados
{
    arrayDeCidades = [NSArray arrayWithContentsOfFile:[
                                                       [NSBundle mainBundle] pathForResource:@"cidades" ofType:@"plist"]
                      ];
    mapView.showsUserLocation = YES;
//    mapView.delegate = self;
//    CLLocationCoordinate2D annotationCoord;
//    annotationCoord.latitude = -22.91;
//    annotationCoord.longitude = -43.18;
//    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
//    annotationPoint.coordinate = annotationCoord;
//    annotationPoint.title = @"Goiania";
//    annotationPoint.subtitle = @"Goias";
//    [mapView addAnnotation:annotationPoint];
    
    for (NSDictionary *row in arrayDeCidades) {
        NSNumber *latitude = [row valueForKey:@"latitude"];
        NSNumber *longitude = [row valueForKey:@"longitude"];
        NSString *description = @"Ver Clima";
        NSString *title = [row valueForKey:@"nome"];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate;
        point.title = title;
        point.subtitle = description;
        [mapView addAnnotation:point];
//        MyLocation *annotation = [[MyLocation alloc] initWithName:description address:title coordinate:coordinate];
//        [mapView addAnnotation:annotation];
	}
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    for (NSDictionary *row in arrayDeCidades)
    {
        if([[row valueForKey:@"nome"] isEqualToString:view.annotation.title])
        {
            NSLog(@"%@", [row valueForKeyPath:@"nome"]);
            cidadeSelecionada = row;
        }
    }
    
    [self performSegueWithIdentifier:@"segueTempoCidade" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TempoCidadeViewController *segueTempoCidade = segue.destinationViewController;
    segueTempoCidade.title = [cidadeSelecionada valueForKey:@"nome"];
    segueTempoCidade.cidadeSelecionada = cidadeSelecionada;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    static NSString *identifier = @"MyLocation";
//    if ([annotation isKindOfClass:[MyLocation class]]) {
//        
//        MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//        if (annotationView == nil) {
//            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//            annotationView.enabled = YES;
//            annotationView.canShowCallout = YES;
//            annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
//        } else {
//            annotationView.annotation = annotation;
//        }
//        
//        return annotationView;
//    }
    
    return nil;
}

//- (void)mapView:(MKMapView *)mapView
//didUpdateUserLocation:
//(MKUserLocation *)userLocation
//{
//    self.mapView.centerCoordinate =
//    userLocation.location.coordinate;
//}

@end
