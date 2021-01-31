/* ClipperToHose.scad
 *
 * Clipper to Hose Adapter
 * Adapt between flexible hose and hair clipper
 */

$fn=75;

HOSE_ID=39;
HOSE_LEN=30;
HOSE_THICKNESS=2;
COLLAR_OD=(HOSE_ID+7);
COLLAR_LEN=6;
COLLAR_THICKNESS=2;
PORT_W=40;
PORT_H=16;
PORT_L=30;
PORT_THICKNESS=2;
SUPPORT_W=28;
SUPPORT_H=6;
SUPPORT_L=40;

RIDGE=5;

BRIDGE=7;

module hose_end(length=HOSE_LEN, dia=HOSE_ID) {
    difference() {
        union() {
            cylinder(h=3, d1=dia-2, d2=dia);
            translate([0,0,3]) cylinder(h=length-3, d=dia);
            translate([0,0,length]) cylinder(h=(COLLAR_LEN/2), d1=dia, d2=COLLAR_OD);
            translate([0,0,length+(COLLAR_LEN/2)]) cylinder(h=(COLLAR_LEN/2), d=COLLAR_OD);
        }
        union() {
            cylinder(h=(length), d=(dia-(HOSE_THICKNESS*2)));
            translate([0,0,length]) cylinder(h=(COLLAR_LEN/2), d1=(dia-(HOSE_THICKNESS*2)), d2=(COLLAR_OD-(HOSE_THICKNESS*2)));
            translate([0,0,length+(COLLAR_LEN/2)]) cylinder(h=(COLLAR_LEN/2), d=COLLAR_OD-(HOSE_THICKNESS*2));
        }
    }
}

module nozzle_outline(w=PORT_W, h=PORT_H) {
    polygon(points=[[0,2], [2,0], [w-2,0], [w,2], [w, h], [0,h]]);
}

module nozzle(w=PORT_W, h=PORT_H) {
    difference() {
        union() {
            linear_extrude(height=20) {
                nozzle_outline(w=w, h=h);
            }
            translate([2,-2,17]) cube([w-4,2,3]);
        }
        linear_extrude(height=20) {
            translate([2,2]) nozzle_outline(w=w-4, h=h-4);
        }
    }
}

module nozzle_interface(w=PORT_W, h=PORT_H) {
    difference() {
        linear_extrude(height=1) {
            nozzle_outline(w=w,h=h);
        }
        linear_extrude(height=1) {
            translate([2,2]) nozzle_outline(w=w-4, h=h-4);
        }
    }
}

module interface() {
    TOTAL_HEIGHT=31+20;
    BUMP_CENTER=TOTAL_HEIGHT-40;
    difference() {
        hull() {
            cylinder(h=1,d=COLLAR_OD);
            translate([-(PORT_W/2),(COLLAR_OD/2)-PORT_H,30])
            {
                nozzle_interface(w=PORT_W,h=PORT_H);
            }
        }
        hull() {
            cylinder(h=1,d=COLLAR_OD-(HOSE_THICKNESS*2));
            translate([-((PORT_W/2)-PORT_THICKNESS),(COLLAR_OD/2)-(PORT_H-PORT_THICKNESS),30]) {
                // cube([PORT_W-(2*PORT_THICKNESS),PORT_H-(2*PORT_THICKNESS),PORT_L]);
                nozzle_interface(w=PORT_W-(2*PORT_THICKNESS),h=PORT_H-(2*PORT_THICKNESS));
            }
        }
    }
    translate([-(PORT_W/2),(COLLAR_OD/2)-PORT_H,31]) nozzle(w=PORT_W, h=PORT_H);
    hull() {
        translate([-8,(COLLAR_OD/2)-1,BUMP_CENTER]) cube([16,6,3]);
        translate([0,(COLLAR_OD/2)-1,2]) sphere(r=1);
        // translate([0,(COLLAR_OD/2)-1,BUMP_CENTER+8]) sphere(r=1);
    }
}

module support(angle=26.5) {
    difference() {
        translate([-(SUPPORT_W/2),(COLLAR_OD)-SUPPORT_H,0]) rotate([angle,0,0]) cube([SUPPORT_W, SUPPORT_H, SUPPORT_L]);
        translate([0,0,-100]) cube([200,200,200], center=true);
    }
}


module adapter() {
    union() {
        hose_end();
        translate([0,0,HOSE_LEN+COLLAR_LEN]) interface();
    }
}

adapter();
// #support();
// hose_end();
// interface();
// nozzle_interface();
