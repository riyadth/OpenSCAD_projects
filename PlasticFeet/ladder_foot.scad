/*
 * Foot for stepladder
 *
 * As printed it is slightly loose for the stepladder leg, but it perfectly
 * fits a penny at the bottom to distribute the weight. Insert penny, add
 * hot glue, and stick on the ladder leg.
 */

$fn=75;

leg_outer_d=19.5;
leg_inner_d=15;
foot_d=25;
foot_h=20;
foot_t=4;

union() {
    difference() {
        union() {
            cylinder(d1=foot_d-2, d2=foot_d, h=1);
            translate([0, 0, 1]) cylinder(d=foot_d, h=foot_h-2);
            translate([0, 0, foot_h-1]) cylinder(d1=foot_d, d2=foot_d-2, h=1);
        }
        translate([0, 0, foot_t])
            cylinder(d1=leg_outer_d-0.5, d2=leg_outer_d+1, h=foot_h);
    }
}
