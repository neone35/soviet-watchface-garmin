using Toybox.Application;
using Toybox.Lang;
using Toybox.WatchUi;
using Toybox.Math;

var centerX;
var centerY;

function degreesToRadians(degrees) {
	return degrees * Math.PI / 180;
}  

function radiansToDegrees(radians) {
	return radians * 180 / Math.PI;
}  

function convertCoorX(radians, radius) {
	return centerX + radius*Math.cos(radians);
}

function convertCoorY(radians, radius) {
	return centerY + radius*Math.sin(radians);
}

class sovietWatchfaceApp extends Application.AppBase {

    var mView;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        System.println( "Hello Monkey C!" );
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        System.println( "initial view has been set up" );
        mView = new sovietWatchfaceView();
        return [mView];
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

}

function getApp() as sovietWatchfaceApp {
    return Application.getApp() as sovietWatchfaceApp;
}