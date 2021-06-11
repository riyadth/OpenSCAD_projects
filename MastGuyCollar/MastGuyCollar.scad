/*
  A collar to anchor guy lines to a telescopic fiberglass mast
*/
$fn=75;

MAST_DIAMETER=30;
GUY_DIAMETER=15;
OFFSET=20;
THICKNESS=10;
GUY_CENTER=(MAST_DIAMETER+OFFSET+GUY_DIAMETER)/2;

difference() {
    hull() {
        for (angle = [0 : 120 : 360 ]) {
            rotate([0,0,angle]) translate([GUY_CENTER,0,0]) cylinder(h=THICKNESS, d=GUY_DIAMETER+OFFSET);
        }
    }
    cylinder(h=THICKNESS, d=MAST_DIAMETER);
    for (angle = [0 : 120 : 360 ]) {
        rotate([0,0,angle]) translate([GUY_CENTER,0,0]) cylinder(h=THICKNESS, d=GUY_DIAMETER);
    }
}
