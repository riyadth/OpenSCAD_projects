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

module t_slot() {
    translate([0,0,2]) hull() {
        cube([10.5,8.5,1], center=true);
        translate([0,0,2.75]) cube([4.5,8.5,1], center=true);
    }
    translate([0,0,1]) cube([4.5,8.5,2], center=true);
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

t_slot();
