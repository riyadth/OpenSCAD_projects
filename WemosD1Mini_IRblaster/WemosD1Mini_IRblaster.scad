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

*rotate_extrude() {
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


STANDOFF_H=4;
BOARD_W=26;
BOARD_L=34;
BOARD_H=19;
FRAME_THICKNESS=1;
BASE_H=3;
BASE_DIA=55;
COVER_T=2;
IR_LED_D=5.3;
USB_W=12;
USB_H=8;
SCREW_D=3;
SCREW_OFFSET=BASE_DIA/2 - (BASE_DIA/2-BOARD_W/2)/2;

module frame(T=FRAME_THICKNESS) {
    difference() {
        translate([0,0,BOARD_H/2]) cube([BOARD_W+(2*T),BOARD_L+(2*T),BOARD_H], center=true);
    }
}


module cutout() {
    difference() {
        translate([0,0,BOARD_H/2]) cube([BOARD_W,BOARD_L,BOARD_H], center=true);
        union() {
            // Standoffs for board
            translate([-BOARD_W/2,-BOARD_L/2,0]) cylinder(h=STANDOFF_H,r=4);
            translate([BOARD_W/2,-BOARD_L/2,0]) cylinder(h=STANDOFF_H,r=4);
            translate([-BOARD_W/2,BOARD_L/2,0]) cylinder(h=STANDOFF_H,r=4);
            translate([BOARD_W/2,BOARD_L/2,0]) cylinder(h=STANDOFF_H,r=4);
        }
    }
}

/* Bottom part */

module base() {
    difference() {
        union() {
            cylinder(h=BASE_H, d=BASE_DIA);
            translate([0,0,BASE_H]) frame(FRAME_THICKNESS);
        }
        translate([0,0,BASE_H]) cutout();
        // USB port
        translate([-USB_W/2,-(BOARD_L/2 + FRAME_THICKNESS+1),BASE_H]) cube([USB_W,FRAME_THICKNESS*2,USB_H]);
        // Screw holes
        translate([SCREW_OFFSET,0,-1]) cylinder(h=BASE_H+2,d=SCREW_D+1);
        translate([-SCREW_OFFSET,0,-1]) cylinder(h=BASE_H+2,d=SCREW_D+1);
    }
    
    #translate([0,0,BASE_H+STANDOFF_H+1]) WemosD1M(pins=0, atorg=0);
}



/* Top part */

module top() {
    difference() {
        union() {
            cylinder(h=4,d1=BASE_DIA-8, d2=BASE_DIA);
            translate([0,0,4]) cylinder(h=BOARD_H+COVER_T-4, d=BASE_DIA);
        }
        translate([0,0,COVER_T+1]) frame(FRAME_THICKNESS+0.5);
        translate([0,0,-1]) cylinder(h=COVER_T+3, d=IR_LED_D);
        // USB port
        translate([-USB_W/2,-(BOARD_L/2 + FRAME_THICKNESS*6),BOARD_H+COVER_T-USB_H]) cube([USB_W,FRAME_THICKNESS*5,USB_H]);
        // Screw holes
        translate([SCREW_OFFSET,0,5]) cylinder(h=BOARD_H+COVER_T,d=SCREW_D);
        translate([-SCREW_OFFSET,0,5]) cylinder(h=BOARD_H+COVER_T,d=SCREW_D);
    }
}

translate([-(BASE_DIA/2+3),0,0]) base();
translate([BASE_DIA/2+3,0,0]) top();