/*
 * Remix of Mini Iambic Magnetic Morse Paddle by ok1cdj
 * https://www.thingiverse.com/thing:1796850
 *
 * Creative Commons - Attribution - Non-Commercial license
 */

include <util.scad>;
include <params.scad>;

// Two-dimensional model of the base, optionally filled or empty
// XY origin is location for main bearing
module base2d(filled) {
  module base_contour_outer() {
    hull()
    {
      translate([-((base_width/2)-base_radius),base_radius-base_length2])
        circle(r=base_radius);
      translate([((base_width/2)-base_radius),base_radius-base_length2])
        circle(r=base_radius);
      translate([0,-((2*base_radius)-base_length1)])
        square([base_width,base_length1+base_length2], center=true);
    };
  }
  intersection() {
    // Note that the offset() will leave a closed end on the box (which will be removed later)
    difference() {
      offset(r=outer_wall_t) base_contour_outer();
      if (!filled)
        base_contour_outer();
    }
  }
}

// The complete base for mounting the paddles
module base() {
  difference() {
    union() {
      // Base slab
      linear_extrude(height=thickness_bottom) {
        base2d(true);
      }
      // Vertical wall around the box
      // Height of wall = paddle height + height of paddle off base + room for screw & lid
      linear_extrude(height=paddle_height+base_to_paddle+5 /* TODO: Define extra space */) {
        base2d(false);
      }

      // TODO:
      // Separator for wiring area - add some holes for wire to go through?
      *translate([-((base_width+outer_wall_t)/2), -(bearing_r_outer+thickness+2), 0]) {
        cube([base_width+outer_wall_t,1,paddle_height+base_to_paddle]);
      }

      // Center raised bar for rigidity
      translate([-m4hole_r-thickness,0,0]) {
        cube([m4hole_d+2*thickness,bearing_to_contact,h_mounting_hole]);
      }

      // Standoff for the bearings axis.
      cylinder(d1=m4hole_d+thickness_bottom*2+2,d2=m4hole_d+thickness_bottom*2,h=base_to_paddle+t_above_bearing);

      // Standoff for the mounting hole
      // Disabled for development
      for (offset=[[0,pos_mounting_hole1-4],[0,pos_mounting_hole2]]) {
        hull() {
          translate(offset)
          multicone([
            [m3hole_d+thickness_bottom*2+2,thickness_bottom-0.0001],
            [m3hole_d+thickness_bottom*2,h_mounting_hole]]);
          translate(offset+[0,4])
          multicone([
            [m3hole_d+thickness_bottom*2+2,thickness_bottom-0.0001],
            [m3hole_d+thickness_bottom*2,h_mounting_hole]]);
        }
      }

      // Side flanges for spacing adjustment
      // Make a block for the contact and spacing adjustment screws
      translate([0,bearing_to_contact,adjuster_height]) rotate([0,90,0])
        cylinder(r=adjuster_y,h=base_width,center=true);
      translate([0,bearing_to_contact,adjuster_height/2])
        cube([base_width,(m3hole_r+thickness_bottom)*2,adjuster_height],center=true);

    } // end union()

    // The following are subtracted to make holes etc.
    // Cleanly chop off the end of the box
    translate([-(base_width/2)-(2*outer_wall_t),bearing_to_contact+(m3hole_r+thickness_bottom),-1])
      cube([base_width+(4*outer_wall_t),40,50]);

    // Chop out the area around the contact and adjustment holes
    translate([0,bearing_to_contact,(h_mounting_hole+(15/2))])
      cube([(2 * paddle_thickness)+contact_spacing,(m3hole_r+thickness_bottom)*2+1,15],center=true);

    // Drill a M4 hole for the bearing axis.
    cylinder(r=m4hole_r,h=100,center=true);

    // Drill a M3 hole for fixing. With countersink.
    // Disabled for development
    translate([0,pos_mounting_hole1,0]) {
      cylinder(r=m3hole_r,h=100,center=true);
      translate([0,0,h_mounting_hole-2])
        cylinder(r=m3hole_r*2,h=100);
    }
    translate([0,pos_mounting_hole2,0]) {
      cylinder(r=m3hole_r,h=100,center=true);
      translate([0,0,h_mounting_hole-2])
        cylinder(r=m3hole_r*2,h=100);
    }

    // Drill an M3 hole for the contact pin
    translate([0,bearing_to_contact]) {
      cylinder(r=m3hole_r,h=100,center=true);
    }

    // Drill the holes for the end stop screws.
    // Horizontal holes.
    translate([0,bearing_to_contact,adjuster_height]) {
      rotate([0,90,0]) {
        cylinder(r=m3hole_r,h=base_width,center=true);
      }
    }

    // Drill a hole for the wire to exit the enclosure
    translate([0, -(base_length2+(outer_wall_t/2)), thickness_bottom+(wire_diameter/2)]) {
      rotate([90,0,0]) {
        cylinder(d=wire_diameter,h=(outer_wall_t*2),center=true);
      }
    }
  } // end difference()
} // end module base()

if (!complete)
    base();
