//
//  FirstViewController.h
//  ClimaPRO
//
//  Created by Douglas Camargo on 01/04/14.
//  Copyright (c) 2014 mdlsistemas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TempoCidadeViewController.h"

@interface FirstViewController : UIViewController <MKMapViewDelegate>
{
    MKMapView *mapView;
    NSDictionary *cidadeSelecionada;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) NSArray *arrayDeCidades;
@end
