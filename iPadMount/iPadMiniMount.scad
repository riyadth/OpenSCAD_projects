/*
  iPadMiniMount.scad
  
  A bracket to mount the iPad Mini onto a microphone stand
  that had a full-sized iPad bracket. The old metal bracket
  was removed from the mounting system, and this print is
  designed to attach to that mount (replacing the metal
  iPad bracket).
*/

$fn=75;

/* Measured dimensions from Pyle microphone stand mount */
SHAFT_DIA=15;
SHAFT_LEN=25;
FLANGE_DIA=33;
FLANGE_THICKNESS=3.5;
FLANGE_RECESS=FLANGE_THICKNESS + 0.5;
SCREW_SEPARATION=24;
SCREW_DIA=2.8;

/* 5 is too thin, 10 is too thick
 * 4mm is used for the mount plate (flange), probably 3 or
 * 4 would be good for strength (4 fits screw best) */
MOUNT_THICKNESS=FLANGE_RECESS + 4;

/* iPad Mini 4 dimensions */
IPAD_WIDTH=203.20;
IPAD_HEIGHT=134.80;
IPAD_THICKNESS=6.10;
IPAD_RADIUS=9;

/* A (simple) model of the iPad Mini 4 (not part of model) */
module ipad(adj=0) {
    translate([-(IPAD_WIDTH+adj)/2, -(IPAD_HEIGHT+adj)/2, 0]) {
        hull() {
            translate([IPAD_RADIUS, IPAD_RADIUS, 0]) {
                cylinder(r=IPAD_RADIUS, h=IPAD_THICKNESS);
            }
            translate([IPAD_RADIUS, (IPAD_HEIGHT+adj)-IPAD_RADIUS, 0]) {
                cylinder(r=IPAD_RADIUS, h=IPAD_THICKNESS);
            }
            translate([(IPAD_WIDTH+adj)-IPAD_RADIUS, IPAD_RADIUS, 0]) {
                cylinder(r=IPAD_RADIUS, h=IPAD_THICKNESS);
            }
            translate([(IPAD_WIDTH+adj)-IPAD_RADIUS, (IPAD_HEIGHT+adj)-IPAD_RADIUS, 0]) {
                cylinder(r=IPAD_RADIUS, h=IPAD_THICKNESS);
            }       
        }
    }
}

/* Mount from microphone stand, to attach to iPad mount.
 * This piece is subtracted from the resulting assembly in
 * order to enable attachment to the microphone stand. */
module mount(thickness) {
    // Main mount shape
    translate([0,0,-1]) cylinder(d=SHAFT_DIA+.5, h=thickness);
    translate([0,0,(thickness-FLANGE_THICKNESS-0.5)]) cylinder(d=FLANGE_DIA+.5, h=FLANGE_THICKNESS);
    translate([0,0,(thickness-0.5)]) cylinder(d1=FLANGE_DIA+0.5, d2=FLANGE_DIA+1, h=0.5);

    // Screw holes
    translate([SCREW_SEPARATION/2, 0, -1]) cylinder(d=SCREW_DIA+0.5, h=thickness);
    translate([-SCREW_SEPARATION/2, 0, -1]) cylinder(d=SCREW_DIA+0.5, h=thickness);

    // Bevels
    translate([0,0,(thickness-FLANGE_THICKNESS-1)]) {
        // Shaft to flange
        cylinder(d1=SHAFT_DIA+0.5, d2=SHAFT_DIA+1, h=0.5);
        // Screw holes
        translate([SCREW_SEPARATION/2, 0, 0]) cylinder(d1=SCREW_DIA+0.5, d2=SCREW_DIA+1, h=0.5);
        translate([-SCREW_SEPARATION/2, 0, 0]) cylinder(d1=SCREW_DIA+0.5, d2=SCREW_DIA+1, h=0.5);
    }

    // Back-side clearance
    translate([0,0,thickness]) cylinder(d=FLANGE_DIA+1, h=1, center=false);
}

/* The clip/rail that holds the tablet */
module clip(length=(IPAD_WIDTH/4),dia=3) {
    translate([-length/2,-dia,0]) difference() {
        minkowski() {
            translate([dia/2,dia/2,dia/2]) cube([length-dia, dia, MOUNT_THICKNESS + IPAD_THICKNESS]);
                sphere(d=dia);
        }
        translate([0, dia, MOUNT_THICKNESS]) {
            cube([length, dia, IPAD_THICKNESS+0.5]);
        }
    }
}

/* 2d outline of the basic frame (minus clips, mount point
 * To be linear-extruded to desired thickness, and then add
 * clips and subtract out mount point, etc. */
module outline(w=IPAD_WIDTH, h=IPAD_HEIGHT) {
    polygon(points=[[-20,0], [-20,h/2], [20,h/2], [20,0],
    [-((w/8)+10),-h/2], [-((w/8)+50),-h/2], [-20,0], // left
    [((w/8)+10),-h/2], [((w/8)+50),-h/2], [20,0]]);  // right

    // Add a ring around center to provide strength
    circle(d=FLANGE_DIA+25);
}

/* The mount assembly itself, minus the mounting point (where
 * the hardware attaches to) */
module y_shape(w=IPAD_WIDTH, h=IPAD_HEIGHT) {
    linear_extrude(height=MOUNT_THICKNESS) {
        outline(w, h);
    }
    translate([-((w/4)+3), -((h/2) + 0.5), 0]) clip((w/4),3);
    translate([((w/4)+3), -((h/2) + 0.5), 0]) clip((w/4),3);
    translate([0,((h/2) + 0.5),0]) rotate([0,0,180]) clip((w/4),3);
}

/* The entire assembly */
module assembly() {
    difference() {
        union() {
            y_shape();
        }
        mount(MOUNT_THICKNESS);
    }
}

// Execute!
assembly();
// Add iPad for visualization (turn off to render)
// translate([0,0,MOUNT_THICKNESS/*+0.5*/]) #ipad(0);
