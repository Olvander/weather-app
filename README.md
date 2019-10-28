# weather-app

Weather-app is an iOS app made as a school project
for the course Mobile Programming 2. The coding language is Apple's Swift
and it has been made using Apple's XCode software.

The app has functionalities for adding and removing a city for which
to fetch weather data from the API of openweathermap.org,
and for using the mobile device's GPS location for that purpose as well.

On the first tab the app displays the current weather for a location
and a 5 day weather forecast on the second tab.

On the third tab the user can add, remove and select a city
or select the current GPS location.
The GPS is selected by default when the app launches.

If you get a domain error with code = 0 "(null)" in the debug view
and you're using Xcode simulator,
Try using a custom location in the debug menu of the
Simulator and hitting ok once done, then it should work.
