$fn=75;

CALL="KB7YWE";
FONT="Hack";
WIDTH=280;
LENGTH=100;
THICKNESS=10;
RADIUS=2;
TEXT_THICKNESS=3;
TEXT_SIZE=40;

module baseplate(w=WIDTH, l=LENGTH, h=THICKNESS) {
    translate([RADIUS,RADIUS,RADIUS]) minkowski() {
        cube([w-(2 * RADIUS),l-(2 * RADIUS),h-(2 * RADIUS)]);
        sphere(r=RADIUS);
    }
}

module callsign(call=CALL) {
    translate([WIDTH/2,LENGTH/2,THICKNESS]) {
        linear_extrude(TEXT_THICKNESS) {
            text(call, font=FONT, spacing=1.05, halign="center", valign="center", size=TEXT_SIZE, $fn=75);
        }
    }
}

color("black") baseplate();

color("white") callsign(CALL);