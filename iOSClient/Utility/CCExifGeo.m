//
//  CCExifGeo.m
//  Crypto Cloud Technology Nextcloud
//
//  Created by Marino Faggiana on 03/02/16.
//  Copyright (c) 2014 TWS. All rights reserved.
//
//  Author Marino Faggiana <m.faggiana@twsweb.it>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "CCExifGeo.h"

@implementation CCExifGeo

+ (void)setExifLocalTableFileID:(CCMetadata *)metadata directoryUser:(NSString *)directoryUser activeAccount:(NSString *)activeAccount
{
    NSString *stringLatitude;
    NSString *stringLongitude;
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", directoryUser, metadata.fileID]];
    
    CGImageSourceRef originalSource =  CGImageSourceCreateWithURL((CFURLRef) url, NULL);
    
    NSDictionary *structExif =(__bridge NSDictionary*) CGImageSourceCopyPropertiesAtIndex(originalSource, 0, NULL);
    
    NSDictionary *tiff = [structExif objectForKey:@"{TIFF}"];
    NSString *dateTime = [tiff objectForKey:@"DateTime"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
    
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:dateTime];
    if (!date) date = metadata.date;
    
    NSDictionary *gps = [structExif objectForKey:@"{GPS}"];
    double latitude = [[gps objectForKey:@"Latitude"] doubleValue];
    double longitude = [[gps objectForKey:@"Longitude"] doubleValue];
    
    NSString *latitudeRef = [gps objectForKey:@"LatitudeRef"];
    NSString *longitudeRef = [gps objectForKey:@"LongitudeRef"];

    // conversion 4 decimal +N -S
    // The latitude in degrees. Positive values indicate latitudes north of the equator. Negative values indicate latitudes south of the equator.
    if ([latitudeRef isEqualToString:@"N"])
        stringLatitude = [NSString stringWithFormat:@"+%.4f", latitude];
    else
        stringLatitude = [NSString stringWithFormat:@"-%.4f", latitude];
    
    // conversion 4 decimal +E -W
    // The longitude in degrees. Measurements are relative to the zero meridian, with positive values extending east of the meridian
    // and negative values extending west of the meridian.
    if ([longitudeRef isEqualToString:@"E"])
        stringLongitude = [NSString stringWithFormat:@"+%.4f", longitude];
    else
        stringLongitude = [NSString stringWithFormat:@"-%.4f", longitude];

    if (latitude == 0 || longitude == 0){
        
        stringLatitude = @"0";
        stringLongitude = @"0";
    }
    
    // Wite data EXIF in TableLocalFile
    [CCCoreData setGeoInformationLocalFromFileID:metadata.fileID exifDate:date exifLatitude:stringLatitude exifLongitude:stringLongitude activeAccount:activeAccount];
}

+ (void)setGeocoderFileID:(NSString *)fileID exifDate:(NSDate *)exifDate latitude:(NSString*)latitude longitude:(NSString*)longitude
{
    // If exists already geocoder data in TableGPS exit
    if ([CCCoreData getLocationFromGeoLatitude:latitude longitude:longitude]) return;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        //DDLogInfo(@"[LOG] Found placemarks: %@, error: %@", placemarks, error);
        
        if (error == nil && [placemarks count] > 0) {
            
            CLPlacemark *placemark = [placemarks lastObject];
            
            NSString *thoroughfare = @"";
            NSString *postalCode = @"";
            NSString *locality = @"";
            NSString *administrativeArea = @"";
            NSString *country = @"";
            
            if (placemark.thoroughfare) thoroughfare = placemark.thoroughfare;
            if (placemark.postalCode) postalCode = placemark.postalCode;
            if (placemark.locality) locality = placemark.locality;
            if (placemark.administrativeArea) administrativeArea = placemark.administrativeArea;
            if (placemark.country) country = placemark.country;
            
            NSString *location = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", thoroughfare, postalCode, locality, administrativeArea, country];
            location = [location stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            // GPS
            if ([location length] > 0) {
                
                [CCCoreData setGeocoderLocation:location placemarkAdministrativeArea:placemark.administrativeArea placemarkCountry:placemark.country placemarkLocality:placemark.locality placemarkPostalCode:placemark.postalCode placemarkThoroughfare:placemark.thoroughfare latitude:latitude longitude:longitude];
                
                NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:exifDate, fileID, nil];
                
                // Notify for CCDetail
                [[NSNotificationCenter defaultCenter] postNotificationName:@"insertGeocoderLocation" object:nil userInfo:dictionary];
            }
        } else {
            //NSLog(@"[LOG] setGeocoderFileID : %@", error.debugDescription);
        }
    }];
}

@end
