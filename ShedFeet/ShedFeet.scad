/*
 * Leveling feet for a cheap wooden shed
 */

FOOT_X=35;
FOOT_Y=24;
FOOT_Z=30;
//FOOT_THICKNESS=11;
//FOOT_THICKNESS=5.5;
FOOT_THICKNESS=3;
FOOT_BUFFER=1.5;
WALL_THICKNESS=5;
GAP=4;

$fn=12;

module drain_hole(foot_thickness) {
    /*
    translate([-1.5, FOOT_Y/2, foot_thickness]) {
        cube([3, FOOT_Y, 3], center=false);
    }
    */
    translate([0, WALL_THICKNESS/2, foot_thickness]) {
        rotate([-90,0,0]) {
            cylinder(h=FOOT_Y + FOOT_BUFFER + WALL_THICKNESS, r1=0.5, r2=2, center=true);
        }
    }
}

module wood_foot(foot_thickness) {
    translate([0, 0, foot_thickness]) {
        linear_extrude(height=FOOT_Z) {
            square([FOOT_X+FOOT_BUFFER,FOOT_Y+FOOT_BUFFER], center=true);
        }
    }
}

module face() {
    minkowski() {
        square([FOOT_X,FOOT_Y], center=true);
        circle(d=WALL_THICKNESS*2);
    }
}

module foot() {
    difference() {
        hull() {
            linear_extrude(height=FOOT_Z-2) face();
            linear_extrude(height=FOOT_Z) square([FOOT_X+4, FOOT_Y+4], center=true);
        }
        // Subtrtact out the space where the wood foot goes
        wood_foot(FOOT_THICKNESS);
        drain_hole(FOOT_THICKNESS);
    }
}


foot();
