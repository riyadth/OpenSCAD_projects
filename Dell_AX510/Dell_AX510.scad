/* Dell AX510 soundbar/speaker mount
 *
 * Enable mounting the Dell AX510 speaker in places other than a Dell monitor.
 */
$fn=100;

// translate([-100,0,0]) cube([200,2.3,20]);

// translate([-100,2.3,0]) rotate([90,0,0]) linear_extrude(height=2.3) square([200,20]);

rounding_d=4;

difference() {
    union() {
        // The "backplane" of the sliding connector
        // Move the backplane into position
        translate([-100+(rounding_d/2), 2.3, (rounding_d/2)]) {
            // Fix orientation
            rotate([90,0,0])
            // Rounded rectangle extruded to desired thickness
            linear_extrude(height=2.3) {
                // Rounded rectangle
                minkowski() {
                    square([200-rounding_d,20-rounding_d]);
                    circle(d=rounding_d);
                }
            }
        }

        // Add 'boxes' for clips, to be hollowed out below
        translate([-62,0,2]) cube([14,5+2.3,13]);
        translate([50,0,2]) cube([14,5+2.3,13]);
    }

    // Remove a window for the latch
    translate([-83,0,5]) cube([6,2.3,10]);
    // Hollow out the boxes for the clips
    translate([-62,0,3]) cube([12,5,10]);
    translate([50,0,3]) cube([12,5,10]);
}


