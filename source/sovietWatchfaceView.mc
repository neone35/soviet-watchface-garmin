import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

var made_evolve16_font as FontResource;
var made_evolve48_font as FontResource;
var made_evolve10_font as FontResource;

var centerOfScreenX = 0;
var centerOfScreenY = 0;

var mainClockBgWidth = 180;
var mainClockBgHeight = 57;
var mainClockBgStartX = 0;
var mainClockBgStartY = 0;

class sovietWatchfaceView extends WatchUi.WatchFace {

    private var cccp_gost as BitmapResource;
    private var kilowatt_clock_string as String; 
    private var gost6570_string as String; 

    function initialize() {
        WatchFace.initialize();
        //mainClockBg = new Rez.Drawables.mainClockShapes();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        centerOfScreenX = dc.getWidth()/2;
    	centerOfScreenY = dc.getHeight()/2;
        mainClockBgStartX = centerOfScreenX - mainClockBgWidth/2;
        mainClockBgStartY = centerOfScreenY - mainClockBgHeight/2;
        made_evolve16_font = WatchUi.loadResource(Rez.Fonts.made_evolve16);
        made_evolve48_font = WatchUi.loadResource(Rez.Fonts.made_evolve48);
        made_evolve10_font = WatchUi.loadResource(Rez.Fonts.made_evolve10);
        cccp_gost = WatchUi.loadResource(Rez.Drawables.CccpGost) as BitmapResource;
        kilowatt_clock_string = WatchUi.loadResource($.Rez.Strings.KilowattClock) as String;
        gost6570_string = WatchUi.loadResource($.Rez.Strings.Gost6570) as String;
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    //! @param dc Device context
    function onUpdate(dc as Dc) as Void {
        var backgroundView = View.findDrawableById("background");
        backgroundView.draw(dc);
        drawKiloAndGostTexts(dc);

        var dateEllipseView = View.findDrawableById("dateEllipse");
        dateEllipseView.draw(dc);
        
        var mainClockView = View.findDrawableById("mainClock");
        mainClockView.draw(dc);

        // Draw the layout and then run your own custom drawing
        View.onUpdate(dc);

        // draw soviet logo
        var cccpWidth = cccp_gost.getWidth();
        var cccpStartX = (dc.getWidth() / 2) - (cccpWidth / 2);
        dc.drawBitmap(cccpStartX, 3, cccp_gost);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    private function drawKiloAndGostTexts(dc as Dc) {
    	// draw КИЛОВАТТ-ЧАСЫ text
        var kilowattClock = View.findDrawableById("kilowattClock") as Text;
        kilowattClock.setFont(made_evolve16_font);
        kilowattClock.setText(kilowatt_clock_string);
        var kilowattClockDimensions = dc.getTextDimensions(kilowatt_clock_string, made_evolve16_font);
        var heightOfKilowattClock = kilowattClockDimensions[1];
        kilowattClock.setLocation(mainClockBgStartX, mainClockBgStartY-heightOfKilowattClock);
        // draw ГОСТ6570-60 text
        var gost6570 = View.findDrawableById("gost6570") as Text;
        gost6570.setFont(made_evolve10_font);
        gost6570.setText(gost6570_string);
        var gost6570Dimensions = dc.getTextDimensions(gost6570_string, made_evolve10_font);
        var heightOfGost6570 = gost6570Dimensions[1];
        gost6570.setLocation(mainClockBgStartX, mainClockBgStartY-heightOfKilowattClock-heightOfGost6570);
    }

}
