/*
  A collar to anchor guy lines to a telescopic fiberglass mast
*/
$fn=75;

MAST_DIAMETER=30;
GUY_DIAMETER=15;
OFFSET=15;
THICKNESS=10;
GUY_CENTER=((MAST_DIAMETER+GUY_DIAMETER)/2)+OFFSET;
CORNER_RADIUS=(GUY_DIAMETER/2)+OFFSET;

difference() {
    hull() {
        for (angle = [0 : 120 : 360 ]) {
            rotate([0,0,angle]) translate([GUY_CENTER,0,0]) {
                union() {
                    translate([0,0,1]) cylinder(h=THICKNESS-2, r=CORNER_RADIUS);
                    cylinder(h=1,r1=CORNER_RADIUS-1,r2=CORNER_RADIUS);
                    translate([0,0,THICKNESS-1])                     cylinder(h=1,r1=CORNER_RADIUS,r2=CORNER_RADIUS-1);
                }
            }
        }
    }
    cylinder(h=THICKNESS, d=MAST_DIAMETER);
    for (angle = [0 : 120 : 360 ]) {
        rotate([0,0,angle]) translate([GUY_CENTER,0,0]) {
            union() {
                cylinder(h=THICKNESS, d=GUY_DIAMETER);
                cylinder(h=1,d1=GUY_DIAMETER+2,d2=GUY_DIAMETER);
                translate([0,0,THICKNESS-1])                 cylinder(h=1,d1=GUY_DIAMETER,d2=GUY_DIAMETER+2);

            }
        }
    }
}
