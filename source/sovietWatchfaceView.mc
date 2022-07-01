import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

var gsecondary_color = 0xFF0000;
var garc_color = 0x555555;

var made_evolve16_font as FontResource;
var made_evolve48_font as FontResource;

class sovietWatchfaceView extends WatchUi.WatchFace {

    private var cccp_gost as BitmapResource;
    private var myShapes;

    function initialize() {
        WatchFace.initialize();
        myShapes = new Rez.Drawables.shapes();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        centerX = dc.getWidth()/2;
    	centerY = dc.getHeight()/2;
        // setScreenDimensions(dc);
        made_evolve16_font = WatchUi.loadResource(Rez.Fonts.made_evolve16);
        made_evolve48_font = WatchUi.loadResource(Rez.Fonts.made_evolve48);
        cccp_gost = WatchUi.loadResource(Rez.Drawables.CccpGost);
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

        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Update the view
        var timeView = View.findDrawableById("TimeLabel") as Text;
        timeView.setColor(getApp().getProperty("ForegroundColor") as Number);
        timeView.setFont(made_evolve48_font);
        timeView.setText(timeString);
        // view.setLocation(screenWidth/2 - view.width/2, screenHeight/2 - view.height/2);

        var titleView = View.findDrawableById("PageHeading") as Text;
        titleView.setFont(made_evolve16_font);
        titleView.setText("CCCP");
        var titleViewWidth = dc.getTextWidthInPixels("CCCP", made_evolve16_font);
        var titleCenter = (dc.getWidth() - titleViewWidth) / 2;
        titleView.setLocation(titleCenter, 77);

        // Draw the layout and then run your own custom drawing
        View.onUpdate(dc);

        // dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
        var cccpWidth = cccp_gost.getWidth();
        var cccpCenterHoriz = (dc.getWidth() - cccpWidth) / 2;
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.drawBitmap(cccpCenterHoriz, 3, cccp_gost);

        // cccp_gost.draw(dc);
        var dateEllipseView = View.findDrawableById("dateEllipse");
        dateEllipseView.draw(dc);
        
        myShapes.draw(dc);
        var myShapesX = myShapes.locX;
        System.println( "myShapesX: " + myShapesX );
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

}
