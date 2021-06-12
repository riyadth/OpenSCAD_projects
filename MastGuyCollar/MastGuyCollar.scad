/*
  A collar to anchor guy lines to a telescopic fiberglass mast
*/
$fn=75;

// Tunable parameters
// MAST_DIAMETER=31.6; // 3rd section ~ 11 feet up
MAST_DIAMETER=34.6; // 2nd section ~ 7 feet up
NUM_GUYS=6;
THICKNESS=10;

// Constants
GUY_DIAMETER=10;
OFFSET=10;
CORNER_RADIUS=(GUY_DIAMETER/2)+OFFSET;

module chamfered_cylinder(height, radius) {
    union() {
        translate([0,0,1]) cylinder(h=height-2, r=radius);
        cylinder(h=1,r1=radius-1,r2=radius);
        translate([0,0,height-1]) cylinder(h=1,r1=radius,r2=radius-1);
    }
}

module chamfered_hole(height, diameter) {
    union() {
        cylinder(h=height, d=diameter);
        cylinder(h=1,d1=diameter+2,d2=diameter);
        translate([0,0,height-1]) cylinder(h=1,d1=diameter,d2=diameter+2);
    }
}

module guy_plate(num_guys, thickness, center_dia) {
    guy_center=((center_dia+GUY_DIAMETER)/2)+(OFFSET*.5);
    difference() {
        union() {
            chamfered_cylinder(thickness, guy_center);
            for (angle = [0 : 360/num_guys : 360 ]) {
                rotate([0,0,angle]) translate([guy_center,0,0]) {
                    chamfered_cylinder(thickness, CORNER_RADIUS);
                }
            }
        }
        cylinder(h=thickness, d=center_dia);
        for (angle = [0 : 360/num_guys : 360 ]) {
            rotate([0,0,angle]) translate([guy_center,0,0]) {
                chamfered_hole(thickness, GUY_DIAMETER);
            }
        }
    }
}

intersection() {
    guy_plate(NUM_GUYS, THICKNESS, MAST_DIAMETER);
    // Uncomment the line below to print only mast section
    // cylinder(h=THICKNESS, d=MAST_DIAMETER+10);
}
