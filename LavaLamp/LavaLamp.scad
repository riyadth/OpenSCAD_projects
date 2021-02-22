/*
 * Simulated lava lamp using detergent bottle
 */

$fn=75;

THREAD_DIA=50;
NECK_DIA=48;
NECK_HEIGHT=14.5;
THREAD_TO_THREAD=4; /* Maybe 3.9 */
BODY_DIA=54;


module thread_segment() {
    translate([0,-1,0]) hull() {
        cube([1,2,1]);
        translate([2,0,0]) cube([1,2,2]);
    }
}

module cap_thread(dia=THREAD_DIA, spacing=THREAD_TO_THREAD, rot=540) {
    // Translate the thread profile to where we want it (from the center)
    // Iterate rotating it and translating it upwards
    // Operate on children()?

    for (i=[0:3:rot]) {
        rotate(i) {
            translate([(dia/2)-2,0,(i/360)*spacing]) children();
        }
    }
}

module cap_body() {
    difference() {
        cylinder(h=NECK_HEIGHT+2,d=BODY_DIA);
        translate([0,0,2]) cylinder(h=NECK_HEIGHT,d=THREAD_DIA);
    }
}

union() {
    cap_body();
    translate([0,0,6]) cap_thread() thread_segment();
}
