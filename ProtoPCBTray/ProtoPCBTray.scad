/*
 * Protective "tray" for prototype PC board
 */

PCB_X=60;
PCB_Y=40;
PCB_Z=1.5;
PCB_BUFFER=1;
HOLE_D=2;
HOLE_INSET=2;
WALL_THICKNESS=3;
GAP=4;
HEIGHT=WALL_THICKNESS+GAP+PCB_Z;

$fn=100;

module board_space() {
    translate([0, 0, WALL_THICKNESS]) {
        linear_extrude(height=HEIGHT) {
            square([PCB_X+PCB_BUFFER,PCB_Y+PCB_BUFFER], center=true);
        }
    }
}

module face() {
    minkowski() {
        square([PCB_X,PCB_Y], center=true);
        circle(d=WALL_THICKNESS*2);
    }
}

module support(x, y) {
    translate([x,y,WALL_THICKNESS]) {
        cylinder(h=GAP, d=HOLE_D*4);
        cylinder(h=GAP+PCB_Z+1, d=HOLE_D);
    }
}

module tray() {
    difference() {
        linear_extrude(height=HEIGHT) face();
        board_space();
    }
    support(HOLE_INSET-PCB_X/2,HOLE_INSET-PCB_Y/2);
    support(HOLE_INSET-PCB_X/2,PCB_Y/2-HOLE_INSET);
    support(PCB_X/2-HOLE_INSET,PCB_Y/2-HOLE_INSET);
    support(PCB_X/2-HOLE_INSET,HOLE_INSET-PCB_Y/2);
}

module lid() {

}

tray();
//lid();