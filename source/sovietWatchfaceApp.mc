import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class sovietWatchfaceApp extends Application.AppBase {

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
        return [ new sovietWatchfaceView() ] as Array<Views or InputDelegates>;
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

}

function getApp() as sovietWatchfaceApp {
    return Application.getApp() as sovietWatchfaceApp;
}