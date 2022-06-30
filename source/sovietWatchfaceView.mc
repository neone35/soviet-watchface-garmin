import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

class sovietWatchfaceView extends WatchUi.WatchFace {

    private var cccp_gost as BitmapResource;
    private var made_evolve16_font as FontResource;
    private var made_evolve48_font as FontResource;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        // setScreenDimensions(dc);
        setLayout(Rez.Layouts.WatchFace(dc));
        made_evolve16_font = WatchUi.loadResource(Rez.Fonts.made_evolve16);
        made_evolve48_font = WatchUi.loadResource(Rez.Fonts.made_evolve48);
        cccp_gost = WatchUi.loadResource(Rez.Drawables.CccpGost);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    //! @param dc Device context
    function onUpdate(dc as Dc) as Void {
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
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setColor(getApp().getProperty("ForegroundColor") as Number);
        view.setFont(made_evolve48_font);
        view.setText(timeString);
        // view.setLocation(screenWidth/2 - view.width/2, screenHeight/2 - view.height/2);

        var view2 = View.findDrawableById("PageHeading") as Text;
        view2.setFont(made_evolve16_font);
        view2.setText("CCCP");

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        // dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
        var cccpWidth = cccp_gost.getWidth();
        var cccpCenterHoriz = (dc.getWidth() - cccpWidth) / 2;
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.drawBitmap(cccpCenterHoriz, 3, cccp_gost);

        // cccp_gost.draw(dc);

        var dateEllipseView = View.findDrawableById("DateEllipse") as Bitmap;
        //draw filled ellipse to represent date
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.fillEllipse(50, 50, 25, 10);
        // dateEllipseShape.draw(dc);
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dateString = Lang.format("$1$/$2$", [today.month,today.day]);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(50, 50, made_evolve16_font, dateString, Graphics.TEXT_JUSTIFY_CENTER);

        
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
