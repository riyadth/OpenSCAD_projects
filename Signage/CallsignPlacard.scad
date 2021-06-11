/*
  Print out a placard with a callsign on it 
 */
 $fn=75;

CALL="KB7YWE";
FONT="Nimbus Mono PS:style=Regular";
// FONT="URW Bookman";
// FONT="C059";
// FONT="P052";
// FONT="Hack";
// FONT="Liberation Sans";
// FONT="DejaVu Mono";
WIDTH=120;
LENGTH=50;
THICKNESS=3;
RADIUS=1;
TEXT_THICKNESS=2;
TEXT_SIZE=20;

module baseplate(w=WIDTH, l=LENGTH, h=THICKNESS) {
    translate([RADIUS,RADIUS,RADIUS]) minkowski() {
        cube([w-(2 * RADIUS),l-(2 * RADIUS),h-(2 * RADIUS)]);
        sphere(r=RADIUS);
    }
}

module callsign(call=CALL) {
    translate([WIDTH/2,(2*LENGTH/3),THICKNESS]) {
        linear_extrude(TEXT_THICKNESS) {
            text(call, font=FONT, spacing=1.0, halign="center", valign="center", size=TEXT_SIZE, $fn=75);
        }
    }
}

module name(n) {
    translate([WIDTH/2,(LENGTH/4),THICKNESS]) {
        linear_extrude(TEXT_THICKNESS) {
            text(n, font=FONT, spacing=1.0, halign="center", valign="center", size=TEXT_SIZE/2, $fn=75);
        }
    }
}

color("black") baseplate();

color("white") callsign(CALL);

color("red") name("Riyadth");
