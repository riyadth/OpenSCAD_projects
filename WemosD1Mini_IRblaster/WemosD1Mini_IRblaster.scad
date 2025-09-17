/*
 * Enclosure for Wemos D1 Mini as IR blaster
 */
 
$fn=75;

ID=28;
WALL_TH=2;
RADIUS=(ID / 2) + WALL_TH;
LED_D=5;
LED_R=(LED_D / 2);
LED_BEVEL=1;
HEIGHT=22;
ROUNDOVER=4;


use <../../openscad-esp-models/ESPModels.scad>
 
use <MCAD/boxes.scad>
$fa=1;
$fs=0.4;
//roundedBox(size=[50,50,15],radius=20,sidesonly=true);


// WemosD1M and daughter boards locator functions test
// From ESPModels library example
WD1MOPOS = 0;
*rotate([0, 180, 0]) {
    WemosD1M(pins=0, atorg=WD1MOPOS);
    // USB connector locator function
    // Can be used to cut a hole for the USB connector
    translate([0, -6/2,0])
        WemosD1M_USBLocate(atorg=WD1MOPOS)
            translate([0, 6/2, 0])
                #cube([6.87+2, 6, 1.85+2], center=true);
    // Push Button locator function
    // Can be used to cut a hole for access
    WemosD1M_PBLocate(atorg=WD1MOPOS)
        translate([0, 10/2, 0])
            #cube([2, 10, 2], center=true);
}

// translate([0,-3,11.6]) cube([26,30,22], center=true);

*difference() {
    cylinder(h=HEIGHT, d=OD);
    translate([0,0,HEIGHT-5]) cylinder(h=5.1, d1=LED_D, d2=LED_D+3);
}

rotate_extrude() {
difference() {
  union() {
    polygon([ [LED_R+LED_BEVEL,HEIGHT], [RADIUS-ROUNDOVER,HEIGHT],
          // arc is below
          for(a=[180:5:270]) [(RADIUS - ROUNDOVER) - (ROUNDOVER * cos(a)), (HEIGHT - ROUNDOVER) - (ROUNDOVER * sin(a))],
          // arc is above    
          [RADIUS,HEIGHT-ROUNDOVER], [RADIUS,0], [RADIUS-WALL_TH,0],
          [RADIUS-WALL_TH,HEIGHT-ROUNDOVER], [LED_R,HEIGHT-ROUNDOVER],
          [LED_R, HEIGHT-LED_BEVEL] ]);
    *translate([RADIUS-ROUNDOVER, HEIGHT-ROUNDOVER]) circle(ROUNDOVER);
  }
  *translate([RADIUS-WALL_TH-(2*ROUNDOVER), HEIGHT-(3*ROUNDOVER)]) square(ROUNDOVER*2);
}
}