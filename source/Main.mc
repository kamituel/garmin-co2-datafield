using Toybox.Application;
using Toybox.WatchUi;
using Toybox.System;

// TODO: use weight unit set in the system settings.

class CO2DataField extends WatchUi.SimpleDataField
{
  function initialize ()
  {
    SimpleDataField.initialize();
    label = WatchUi.loadResource(Rez.Strings.WidgetLabel);
  }

  function compute (info)
  {
    if (info.elapsedDistance == null) {
      return 0d;
    }

    var gramsPerKilometer = Application.getApp().getProperty(Settings.CAR_EMISSIONS);

    if (gramsPerKilometer == null) {
      gramsPerKilometer = 190d;
    }

    // System.println("" + info.elapsedDistance + " m, " + gramsPerKilometer + " g/km");

    return (info.elapsedDistance / 1000) * (gramsPerKilometer.toDouble() / 1000);
  }
}

class CO2App extends Application.AppBase
{
  function initialize () {
    AppBase.initialize();
  }

  function getInitialView ()
  {
    return [
      new CO2DataField()
    ];
  }

  function getSettingsView ()
  {
    return getSettingsView2();
  }
}
