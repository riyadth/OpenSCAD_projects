/*
 * Remix of Mini Iambic Magnetic Morse Paddle by ok1cdj
 * https://www.thingiverse.com/thing:1796850
 *
 * Creative Commons - Attribution - Non-Commercial license
 */

include <util.scad>;
include <params.scad>;

module base2d(filled) {
    module base_contour_outer()
    hull()
    {
        r=w1/2-pins_w/2;
        translate([ w1/2-r,-lb+r]) circle(r=r);
        translate([-w1/2+r,-lb+r]) circle(r=r);
        translate([-w1/2,-lb+r])
            square([w1,lt+lb+r]);
    };
    intersection() {
        difference() {
            base_contour_outer();
            if (!filled)
                offset(r=-outer_wall_t)
                    base_contour_outer();
        }
        square([100,lt*2],center=true);
    }
}

module base()
{
difference() {
union() {
    // Base slab
    linear_extrude(height=4)
        base2d(true);
}



// Drill a M3 hole for fixing.
translate([0,pos_mounting_hole1,0])
cylinder(r=m3hole_r,h=100,center=true);
translate([0,pos_mounting_hole2,0])
cylinder(r=m3hole_r,h=100,center=true);

#translate([0,pos_mounting_hole1,3])
cylinder(r=2.55,h=3,center=true);
#translate([0,pos_mounting_hole2,3])
cylinder(r=2.55,h=3,center=true);

//magnets
translate([0,pos_mounting_hole1+9,2.6])
cylinder(r=4.0,h=3.3,center=true);

translate([0,pos_mounting_hole1-9,2.6])
cylinder(r=4.0,h=3.3,center=true);


translate([0,pos_mounting_hole2+6,3.1])
#cylinder(r=2.5,h=2.3,center=true);

*translate([0,lt-5,0]) cylinder(r=m4hole_r,h=100,center=true);

// Drill 3 M3 holes into the base for fixing
*for (offset=[[0,lt-13],[w1/2-5,-lb+5],[-w1/2+5,-lb+5]])
    translate(offset)
    cylinder(d=3.1,h=100,center=true);



}
}

if (!complete)
    base();
