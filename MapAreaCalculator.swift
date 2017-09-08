//
//  MapAreaCalculator.swift
//  frun
//
//  Created by Bastian Heinlein on 08.09.17.
//  Copyright © 2017 bahe. All rights reserved.
//
//  A simple class that calculates the shown region of a MKMapView based on an array of
//

import Foundation
import MapKit
import UIKit

class MapAreaCalculator {
    
    // Main function
    // @param points -> all the points that should be visible
    // @param MapView -> the MapView which region is to set
    func calculateAreaToShow(points:[CLLocation], MapView:MKMapView, frameSize:Double=0.05) {
        let extremePoints = findExtremePoints(points:points)
        
        let northWesternCoordinate = CLLocationCoordinate2D(latitude: extremePoints[0], longitude: extremePoints[3])
        let southEasternCoordinate = CLLocationCoordinate2D(latitude: extremePoints[2], longitude: extremePoints[1])
        
        var northWesternPoint = MKMapPointForCoordinate(northWesternCoordinate)
        let southEasternPoint = MKMapPointForCoordinate(southEasternCoordinate)
        
        let deltaX = southEasternPoint.x - northWesternPoint.x
        let deltaY = northWesternPoint.y - southEasternPoint.y
        
        northWesternPoint.x = northWesternPoint.x - abs(deltaX*frameSize)
        northWesternPoint.y = northWesternPoint.y - abs(deltaY*frameSize) // abs(deltyY*0.05) defines how big the distance between the points and the border of the UIMapView should be
        
        let size = MKMapSizeMake(abs(deltaX)*2*frameSize, abs(deltaY)*2*frameSize)
        
        let rectToDisplay = MKMapRectMake(northWesternPoint.x, northWesternPoint.y, size.width, size.height)
        let mapRegion = MKCoordinateRegionForMapRect(rectToDisplay)
        
        MapView.setRegion(mapRegion, animated: true)
        
    }
    
    // Helper function calculating the extreme points to make the main function clearer
    // @param points -> all the points that should be visible
    func findExtremePoints(points:[CLLocation]) -> [Double] {
        var mostEasternPoint:Double = -180.0
        var mostWesternPoint:Double = 180.0
        var mostNorthernPoint:Double = -90.0
        var mostSouthernPoint:Double = 90.0
        
        if points.count == 0 {
            return [89,179,-89,-179]
        }
        
        for point in points {
            let longitude = point.coordinate.longitude
            let latitude = point.coordinate.latitude
            
            if longitude > mostEasternPoint {
                mostEasternPoint = longitude
            }
            if longitude < mostWesternPoint {
                mostWesternPoint = longitude
            }
            if latitude > mostNorthernPoint {
                mostNorthernPoint = latitude
            }
            if latitude < mostSouthernPoint {
                mostSouthernPoint = latitude
            }
        }
        return [mostNorthernPoint, mostEasternPoint, mostSouthernPoint, mostWesternPoint]
    }
}
