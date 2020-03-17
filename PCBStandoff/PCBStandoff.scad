/* PC Board Standoffs */

$fn=100;

hole_diameter=3;
tape_width=15;
standoff_height=8;

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
    linear_extrude(height=length)
        circle(d=diameter);
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