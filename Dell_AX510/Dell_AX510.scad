/* Dell AX510 soundbar/speaker mount
 *
 * Enable mounting the Dell AX510 speaker in places other than a Dell monitor.
 */
$fn=100;

// translate([-100,0,0]) cube([200,2.3,20]);

// translate([-100,2.3,0]) rotate([90,0,0]) linear_extrude(height=2.3) square([200,20]);

rounding_d=4;

// Hidden with a *
// Transparent with a %
// Highlight/debug with a #
// Show only with a !


/* The clip is the part that hangs the structure from the top of the TV */
module clip(width) {
    rotate([0, 90,0]) linear_extrude(height=width) {
        // Trace the outline of the clip we want for the TV
        // This is for a Vizio M220MV TV
        polygon([[0,2.3],[0,-26],[-20,-26],[-20,-24],[-4,-24],
                [-4,-16],[-20,0],[-30,0],[-30,2.3]]);
    }
}

/* The bracket is the assembly with the mounting features for the speaker,
 * and the clips to attach to the top of the TV */
module bracket() {
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

            // Add the mounting clips, with a 25mm width
            translate([62,0,0]) clip(25);
            translate([-(50+25+12),0,0]) clip(25);
        }

        // Remove a window for the speaker latch
        translate([-83,0,5]) cube([6,3,10]);
        // Hollow out the boxes for the speaker clips
        translate([-62,0,3]) cube([12,5,10]);
        translate([50,0,3]) cube([12,5,10]);
    }
}

// Add clips to hang from
// Original style
// translate([62,-28,0]) cube([25,28,5]);
// translate([62,-31,0]) cube([25,3,20]);  // Upright
//
// translate([-(50+25+12),-28,0]) cube([25,28,5]);
// translate([-(50+25+12),-31,0]) cube([25,3,20]); // Upright

// intersection() {
    bracket();
    // translate([-95,-35,-10]) cube([50,50,50]);
// }
