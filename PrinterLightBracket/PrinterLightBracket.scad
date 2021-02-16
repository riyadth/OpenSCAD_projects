/*
  PrinterLightBracket.scad

  A bracket to mount a light bar on top of the Ender 3
  printer. Adapts the 2020 extrusion to metal clips
  that hold the light.
*/

$fn=75;

/* Measured dimensions of extrusion */
EXT_WIDTH=20;
EXT_SLOT=6.2;
EXT_DEPTH=4.3;
EXT_THICK=1.5;

/* Measured dimensions of light clip */
CLIP_LEN=25.6;
CLIP_WIDTH=14.7;
CLIP_THICKNESS=9;
CLIP_MAX_WIDTH=23;
CLIP_HOLE_DIA=3.75;
CLIP_TOP_OFFSET=((CLIP_LEN/2)-5.8-(CLIP_HOLE_DIA/2));

T_GAP=3;
T_WIDTH=4;
T_FLANGE=10.5;
T_TIP_WIDTH=4;
T_TIP_DEPTH=3.75;

TOP_LEN=50;
BACK_LEN=8.5;
THICKNESS=3;


/* Model of the light clip */
module clip_hull() {
    hull() {
        translate([0,0,CLIP_THICKNESS-0.5]) cube([CLIP_LEN, CLIP_WIDTH, 1], center=true);
        translate([0,0,0.5]) cube([CLIP_LEN, CLIP_MAX_WIDTH, 1], center=true);
    }
}

module clip() {
    difference() {
        clip_hull();
        scale([1,0.95,0.93]) clip_hull();
        translate([CLIP_TOP_OFFSET,0,0]) cylinder(h=CLIP_THICKNESS+1, d=CLIP_HOLE_DIA);
        translate([0,0,2]) rotate([60,0,0]) cylinder(h=CLIP_THICKNESS+10, d=CLIP_HOLE_DIA);
    }
}

/* Model of 2020 extrusion */
module extrusion() {
}

module t_slot(l=CLIP_LEN) {
    translate([0,0,l/2]) rotate([-90,0,0]) {
        translate([0,0,T_GAP]) hull() {
            cube([T_FLANGE,l,1], center=true);
            translate([0,0,T_TIP_DEPTH-1]) cube([T_TIP_WIDTH,l,1], center=true);
        }
        translate([0,0,(T_GAP/2)]) cube([T_WIDTH,l,T_GAP], center=true);
    }
}

module rear_profile(l=CLIP_LEN) {
    // # translate([-((4.5+7+3)-(4.5/2)),-3,0])
    PROFILE_RADIUS=1.5;
    hull() {
        translate([0,2,0]) cube([T_WIDTH+BACK_LEN+THICKNESS,1,l]);
        linear_extrude(height=l) {
            translate([PROFILE_RADIUS,PROFILE_RADIUS]) circle(r=PROFILE_RADIUS);
            translate([T_WIDTH+BACK_LEN+THICKNESS-PROFILE_RADIUS,PROFILE_RADIUS]) circle(r=PROFILE_RADIUS);
        }
    }
}

module top_profile(l=CLIP_LEN) {
    cube([THICKNESS,TOP_LEN,l]);
    translate([THICKNESS/2,TOP_LEN,0]) cylinder(d=THICKNESS, h=l);
}

module bracket(l=CLIP_LEN) {
    t_slot(l=l);
    translate([-((T_WIDTH+BACK_LEN+THICKNESS)-(T_WIDTH/2)),-THICKNESS,0]) rear_profile(l);
    translate([-((T_WIDTH+BACK_LEN+THICKNESS)-(T_WIDTH/2)),0,0]) top_profile(l);
}
// clip();
// linear_extrude(height=20, twist=90, slices=100)
/*
difference() {
    offset(delta=10,chamfer=true) square([10,10], center=true);
    offset(r=8) square([10,10], center=true);
}
difference() {
    square([10,10], center=true);
    offset(r=-1) square([10,10], center=true);
}
*/

bracket(2);
