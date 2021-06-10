/*
  A collar to anchor guy lines to a telescopic fiberglass mast
*/
$fn=75;

MAST_DIAMETER=67;
GUY_DIAMETER=20;
THICKNESS=20;

difference() {
    hull() {
        for (angle = [0 : 120 : 360 ]) {
            rotate([0,0,angle]) translate([60,0,0]) cylinder(h=THICKNESS, d=GUY_DIAMETER+20);
        }
    }
    cylinder(h=THICKNESS, d=MAST_DIAMETER);
    for (angle = [0 : 120 : 360 ]) {
        rotate([0,0,angle]) translate([60,0,0]) cylinder(h=THICKNESS, d=GUY_DIAMETER);
    }
}
