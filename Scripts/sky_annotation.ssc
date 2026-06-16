// Sky annotation night timelapse | Script by Raihan Mohammad
// Use for Simulating 360 degree sky view alike using Allskycam with mono astro camera (e.g ZWO, QHY) - MONOCHROME VERSION.
// The script was created to simulate a single night. It starts at local sunset, progresses toward midnight, and ends at sunrise. The goal is to capture the night sky over the course of a full night, similar to an all-sky camera using a monochrome camera.
// NOTE: Convert This js. file to .ssc so it can be readed as script on Stellarium
//Toggle GUI and set Landscape e.g. to perform Allsky-like view in 360 degree view.
core.setGuiVisible(false);
LandscapeMgr.setFlagAtmosphere(true);
LandscapeMgr.setFlagFog(true);
LandscapeMgr.setFlagCardinalPoints(true);
LandscapeMgr.setFlagIllumination(true);
StarMgr.setFlagStars(true);

// Adjusted Star sizes are adjusted based on relative and absolute scales to account for the density assumed in the all-sky simulation. The same goes for the Milky Way).
StelSkyDrawer.setAbsoluteStarScale(1.85);
StelSkyDrawer.setRelativeStarScale(0.5);
MilkyWay.setIntensity(1.0);
MilkyWay.setSaturation(0.1);

// Get local date in Stellarium (based on Landscape time zone (UTC offset)).
var tgl = core.getDate("local").substring(0, 10);

//Draw visible text for technical information about sky view (time/date, location, lat/long, etc.)
function drawLabelSharp(teks, x, y, size, id) {
    var off = 5; // Offset, The higher the number, the thicker it is.
    var warnaBG = "#ffffff";

    // Shadow text for visibility in daylight
    LabelMgr.labelScreen(teks, x, y, true, size, warnaBG, false, 0, id + "_b1");
    LabelMgr.labelScreen(teks, x, y, true, size, warnaBG, false, 0, id + "_b2");
    
    // MAIN TEXT
    LabelMgr.labelScreen(teks, x, y, true, size, "#FFFFFF", false, 0, id);
}

  drawLabelSharp("AllSky-view Simulation | By Raihan Mohammad ", 100, 1200, 20, "L13");
    core.wait(0.0)

core.debug("AllSkyCam Simulation Started...");

// 2. Script Loop (don't change!)

while (true) {
    LabelMgr.deleteAllLabels();
   var infoSun = core.getObjectInfo("Sun");
    var sunAlt = infoSun.altitude;

core.setTimeRate(1) //1000x speed rate for timelapse

    //get technical information from landscape (note: the landscape must contain spesific location based on landscape and time zone).
    var waktuSekarang = core.getDate("local"); 
    var namaTempat = "Kebun Teh Taraju, Kabupaten Tasikmalaya, Jawa Barat";
    var infoLokasi = core.getObserverLocationInfo();
    var lat = infoLokasi["latitude"];
    var lon = infoLokasi["longitude"];
    var ele = infoLokasi["altitude"];
    var infoSun = core.getObjectInfo("Sun");
    var sunAlt = infoSun.altitude; 

    var statusLangit = "Daylight"; // night-time and twilight time information
if (sunAlt < 0) statusLangit = "Civil Twilight";
if (sunAlt < -6) statusLangit = "Nautical Twilight";
if (sunAlt < -12) statusLangit = "Astronomical Twilight";
if (sunAlt < -18) statusLangit = "True Night";

// Praying time schedule (based on sun altitude)
var jamMenit = core.getDate("local").substring(11, 16); // Ambil format HH:mm

// The interval between prayers notated as:
var shalat = "NANTIKAN WAKTU SHALAT";
var warnaShalat = "#FFFFFF"; // True white

// PRAYING TIMES CALCULATION
// SUBUH (Sun alt -20 derajat (fajr sadiq))
if (sunAlt < -0.1 && sunAlt > -20.5 && jamMenit < "06:00") {
    shalat = "WAKTU SUBUH";
    warnaShalat = "#ffffff";
} 
// ZUHUR (Culmination => transit time/max altitude, around 12:00 PM for tropical latitudes)
else if (sunAlt  <= 90 && sunAlt >= 70 && jamMenit > "11:30" && jamMenit < "12:30") {
    shalat = "WAKTU ZUHUR";
    warnaShalat = "#ffffff";
}
// ASAR (Sun alt around 40 to sunset time)
else if (sunAlt < 40 && sunAlt > 0 && jamMenit > "14:30" && jamMenit < "18:30") {
    shalat = "WAKTU ASAR";
    warnaShalat = "#ffffff";
}
// MAGHRIB (Sun altitude below horizon, the disk is fully set)
else if (sunAlt < -0.1 && sunAlt > -17.5 && jamMenit > "17:30" && jamMenit < "19:00") {
    shalat = "WAKTU MAGHRIB";
    warnaShalat = "#ffffff";
}
// ISYA (sun altitude < -18 degree to midnight)
else if (sunAlt < -17.5 && sunAlt > -90 && jamMenit > "19:00" && jamMenit < "23:59") {
    shalat = "WAKTU ISYA";
    warnaShalat = "#ffffff";
}

// SQM (SKY BRIGHTNESS) CALCULATIONS - BASED ON LANDSCAPE LIGHT POLLUTION INFORMATION.
var sqm = 0;
var sunInfo = core.getObjectInfo("Sun");
var sAlt = sunInfo.altitude;

//GET SKY BRIGHTNESS/BORTLE SCALE INFORMATION FROM LANDSCAPE (see: landscape.ini)
    var sqm = 0;
    var bIndex = StelSkyDrawer.getBortleScaleIndex();
    var sqmMax = 22.00; //Theoritical max sky brightness/darkest on earth.

    //LOGIC
    if (bIndex == 1) sqmMax = 21.99-22.00; // Bortle 1
    else if (bIndex == 2) sqmMax = 21.99; // Bortle 2
    else if (bIndex == 3) sqmMax = 21.71; // Bortle 3 => you can change it based on your sqm reading. Here's mine.
    else if (bIndex == 4) sqmMax = 21.69; // Bortle 4
    else if (bIndex == 5) sqmMax = 20.49; // Bortle 5
    else if (bIndex == 6) sqmMax = 19.50; // Bortle 6
    else if (bIndex == 7) sqmMax = 18.94; // Bortle 7
    else if (bIndex == 8) sqmMax = 18.39; // Bortle 8
    else if (bIndex == 9) sqmMax = 17.00; // Bortle 9
    // Some people combine Bortle 8 and 9 together in one scale, but here they are listed according to the numerical scale used for light pollution standards by Stellarium (i.e., a 9-point scale).
    //The SQM index, when converted to the Bortle scale, follows the method described by Trevor Jones. However, the author defines Bortle 9 as having a brightness of less than 17.50 to align with the numerical scale recognized by Stellarium.

    // SQM (Sky Brightness) calculation and fluctuation based on sun altitude and moonlight interference.

    if (sAlt > -0.8) {
        sqm = 0.00;
    } else if (sAlt <= -0.8 && sAlt > -18) {

        // Calculating Changes in the SQM of the night sky based on the sun's altitude.
        var faktorTransisi = Math.abs(sAlt + 0.8) / 17.2; 
        sqm = faktorTransisi * sqmMax;
    } else {
        sqm = sqmMax;
    }

    // Moonlight calculating effect to SQM index
    var moonAlt = core.getObjectInfo("Moon").altitude;
    if (moonAlt > 0 && sAlt < -12) {
        sqm = sqm - (moonAlt / 20);
    }
    
    if (sqm < 0) sqm = 0; // Safety check

drawLabelSharp("SQM: " + sqm.toFixed(2) + " mag/arcsec²", 20, 265, 20, "L8");

// BORTLE SCALE INTERPRETATION (if sunrise/daylight => N/A)
var bortle = "";
if (sqm >= 21.99) { bortle = "Class 1 (Excellent)"; }
else if (sqm >= 21.89) { bortle = "Class 2 (Dark Sky)"; }
else if (sqm >= 21.69) { bortle = "Class 3 (Rural)"; }
else if (sqm >= 21.49) { bortle = "Class 4 (Rural Transition)"; }
else if (sqm >= 19.50) { bortle = "Class 5 (Suburban)"; }
else if (sqm >= 18.94) { bortle = "Class 6 (Bright Suburban)"; }
else if (sqm >= 18.38) { bortle = "Class 7 (Suburban Transition)"; }
else if (sqm >= 10.00) { bortle = "Class 8/9 (City/Inner City)"; }
else { bortle = "N/A"; }

// MOON INFORMATION (PHASE, ILLUMINATION)
var infoSun = core.getObjectInfo("Sun");
var infoMoon = core.getObjectInfo("Moon");
var moonPhase = (infoMoon["illumination"]).toFixed(1); // phase in percent (0-100%)
var moonAge = infoMoon["phase-name"]; // e.g full moon, etc.

// STARGAZING/OBSERVATONAL CONDITION (depends on Moonlight affecting the sky and twilight).
var sunAlt2 = core.getObjectInfo("Sun").altitude;
var moonAlt2 = core.getObjectInfo("Moon").altitude;
var moonIllum2 = (core.getObjectInfo("Moon")["illumination"]); // Persentase cahaya bulan

// 2. Tentukan Kondisi Langit (Sky Condition)
var kondisiLangit = "SIANG HARI";
var warnaKondisi = "#FFFFFF"; // Putih (Siang)

if (sunAlt2 < -18) {
    // true night if sun altitude below 18 degrees
    if (moonAlt2 > 15 && moonIllum2 > 10) { 
        // if moon altitude more than 15 degree and phase more than 10%, sky get affected by moonlight.
        kondisiLangit = "MOONLIGHT INTERFERENCE";
        warnaKondisi = "#ffffff";
    } else {
        kondisiLangit = "DARK NIGHT (OBSERVATION)";
        warnaKondisi = "#ffffff";
    }
} else if (sunAlt < 0) {
    kondisiLangit = "TWILIGHT / DAWN";
    warnaKondisi = "#ffffff";
}

    // draw all technical labels
    drawLabelSharp("ALLSKY-VIEW | " + waktuSekarang + " WIB", 20, 20, 20, "L1");
    drawLabelSharp(infoLokasi.location, 20, 55, 20, "L2");
    drawLabelSharp("Latitude(deg): " + lat.toFixed(4),  20, 90, 20, "L3");
    drawLabelSharp("Longitude(deg): " + lon.toFixed(4),  20, 125, 20, "L4");
    drawLabelSharp("Elevation: " + Math.round(ele) + "mdpl", 20, 160, 20, "L5");
    drawLabelSharp("Sun Alt: " + sunAlt.toFixed(2) + "° (" + statusLangit + ")", 20, 195, 20, "L6");
    drawLabelSharp("Waktu Shalat: " + shalat, 20, 230, 20, "L7");
    drawLabelSharp("Bortle: " + bortle, 20, 300, 20, "L8");
    drawLabelSharp("Phase: " + moonPhase + " %" + " (" + moonAge + ")", 20, 330, 20, "L12");
    drawLabelSharp("Condition: " + kondisiLangit, 20, 360, 20, "L13");
      
    core.wait(0.1); // for smooth text visibility 
}

// COPYRIGHT RAIHAN MOHAMMAD - FREE TO USE
