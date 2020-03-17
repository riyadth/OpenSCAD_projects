/* PC Board Standoffs */

$fn=100;

hole_diameter=3;
tape_width=15;
standoff_height=8;
board_thickness=2;

base_thickness=2;
post_length=standoff_height-base_thickness;
pin_length=3;

base_side=tape_width;
post_dia=hole_diameter+2;
pin_dia=hole_diameter-0.5;

/* A square base to stick to an enclosure with double sided tape
*/
module base(side_length, thickness) {
    linear_extrude(height=thickness)
        square([side_length, side_length], center=true);
}

/* A post for the PCB to rest on. Should be slightly wider
   than the hole on the PCB
*/
module post(diameter, length) {
    linear_extrude(height=length)
        circle(d=diameter);
}

/* A pin on top to set the PCB onto. Can be melted or glued to secure.
   TODO: form a clip by splitting the pin, and giving it a bulge
*/
module pin(diameter, length) {
    /* Make the first part of the pin an exact fit */
    linear_extrude(height=board_thickness) {
        difference() {
            circle(d=diameter);
            square([0.5, diameter], center=true);
        }
    }
    /* TODO: Make the next part with a small bulge... */
    translate([0,0,board_thickness]) {
        linear_extrude(height=length-board_thickness) {
            difference() {
                circle(d=diameter);
                square([0.5, diameter], center=true);
            }
        }
    }
    /* Musings...
    translate([0,0,board_thickness]) {
        hull() {
            linear_extrude(height=length-board_thickness) {
                difference() {
                    circle(d=diameter);
                    square([0.5, diameter], center=true);
                }
            }
            translate([0,0,board_thickness/2])
            linear_extrude(height=0.1)
                difference() {
                    circle(d=diameter+0.5);
                    square([0.5, diameter+0.5], center=true);
                }
        }
    }
    */
}

/* The completed standoff */
module standoff(base_side_length, post_diameter, pin_diameter) {
    base(base_side_length, base_thickness);
    translate([0,0,base_thickness])
        post(post_diameter, post_length);
    translate([0,0,base_thickness+post_length])
        pin(pin_diameter, pin_length);
}

standoff(base_side, post_dia, pin_dia);