# Calculating Map Areas
## When to use this code
Whenever you have a list of CLLocations and would like to display all of them in an MKMapView, this class is exactly right for you! 
It does all the math for you and even allows you to to set a frame around your points, i. e. when you want to display MKPointAnnotation.
## How to use this code
Just include it in your code and use it like this:
```
let Calculator = MapAreaCalculator()
Calculator.calculateAreaToShow(points:[your points here], MapView: [your MKMapView here], frameSize[your custom frame size here])
```
> If you use this code it'd be nice if you'd notify me about it, so I can see in which awesome projects it is used.
