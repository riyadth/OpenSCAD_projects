/*
 * Remix of Mini Iambic Magnetic Morse Paddle by ok1cdj
 * https://www.thingiverse.com/thing:1796850
 *
 * Creative Commons - Attribution - Non-Commercial license
 */

include <util.scad>;
include <params.scad>;

// Two-dimensional model of the base, optionally filled or empty
module base2d(filled) {
  module base_contour_outer() {
    hull()
    {
      // TODO: What is w1? What is pins_w?
      r=w1/2-pins_w/2;
      translate([ w1/2-r,-lb+r]) circle(r=r);
      translate([-w1/2+r,-lb+r]) circle(r=r);
      translate([-w1/2,-lb+r]) square([w1,lt+lb+r]);
    };
  }
  intersection() {
    difference() {
      base_contour_outer();
      if (!filled)
        offset(r=-outer_wall_t)
          base_contour_outer();
    }
    // TODO: What is lt?
    square([100,lt*2],center=true);
  }
}

// The complete base for mounting the paddles
module base()
{
  difference() {
    union() {
      // Base slab
      linear_extrude(height=thickness_bottom) {
        base2d(true);
      }
      // Vertical wall around the box
      linear_extrude(height=paddle_height+thickness_bottom3+2*bearing_to_bearing_offset) {
        base2d(false);
      }

      // Center raised bar for rigidity?
      *translate([-m4hole_r-thickness_bottom,0,0]) {
        cube([m4hole_d+2*thickness_bottom,lt,5]);
      }

      // Standoff for the bearings axis.
      cylinder(d1=m4hole_d+thickness_bottom*2+2,d2=m4hole_d+thickness_bottom*2,h=m4hole_l);
      /*
      *multicone([
          [m4hole_d+thickness_bottom*2+2,thickness_bottom-0.0001],
          [m4hole_d+thickness_bottom*2,m4hole_l-thickness_bottom],
          [m4hole_d+thickness_bottom*2,m4hole_l]]);
      */

      // Standoff for the mounting hole
      // Disabled for development
      *for (offset=[[0,pos_mounting_hole1-4],[0,pos_mounting_hole2]]) {
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

      // Standoff for the bearings axis.
      // NOT USED
      *translate([0,lt-m3hole_r-thickness_bottom,0]) {
        multicone([
          [m3hole_d+thickness_bottom*2,thickness_bottom-0.0001],
          [m3hole_d+thickness_bottom*2,m4hole_l-1.2],
          [m3hole_d+4*0.4,thickness_bottom3-1],
          [m3hole_d+4*0.4,thickness_bottom3]]);
      }

      // Standoff for the center contact
      // NOT USED
      *union() {
        x=lt-m3hole_r-thickness_bottom;
        l=15;
        w=1.5;
        h=m4hole_l;
        translate([-thickness-w/2,lt-thickness*2-l])
        cube([thickness*2+w,thickness*2+l,h],center=false);
        translate([0,lt-thickness*2])
        cylinder(d=3,h=10);
      }

      // Side flanges for spacing adjustment
      // TODO: Make these track the bearing size so no interference
      // Actually, make the paddle spacings/thicknesses constant...
      // TODO: Spacing from main bearing to contact should be in params
      *translate([0,lt-m3hole_d-2*thickness_bottom])
      {
        for (offset=[[w1/2-m3hole_l,0],[-w1/2,0]]) translate(offset) {
          cube([m3hole_l,m3hole_d+2*thickness_bottom,m3hole_h],center=false);
          translate([0,m3hole_r+thickness_bottom,m3hole_h])
          rotate([0,90,0])
          cylinder(r=m3hole_r+thickness_bottom,h=m3hole_l);
        }
        translate([-w1/2,0]) cube([w1,m3hole_d+2*thickness_bottom,thickness_bottom2]);
      }

      // Make a block for the contact and spacing adjustment screws
      translate([0,bearing_to_contact,15]) rotate([0,90,0])
      cylinder(r=m3hole_r+thickness_bottom,h=w1,center=true);
      translate([0,bearing_to_contact,15/2]) cube([w1,(m3hole_r+thickness_bottom)*2,15],center=true);

    } // end union()

    // The following are subtracted to make holes etc.
    translate([0,bearing_to_contact,15/2+6]) cube([w1-6,(m3hole_r+thickness_bottom)*2+1,15],center=true);

    // Drill a M4 hole for the bearing axis.
    cylinder(r=m4hole_r,h=100,center=true);

    // Drill a M3 hole for fixing.
    // Disabled for development
    *translate([0,pos_mounting_hole1,0])
      cylinder(r=m3hole_r,h=100,center=true);
    *translate([0,pos_mounting_hole2,0])
      cylinder(r=m3hole_r,h=100,center=true);

    // Drill an M3 hole for the contact pin
    translate([0,lt-m3hole_r-thickness_bottom]) {
      cylinder(r=m3hole_r,h=100,center=true);
      //cylinder(d=5.1,h=2.2,center=false);
    }

    // Drill the holes for the end stop screws.
    // Horizontal holes.
    translate([0,lt-m3hole_r-thickness_bottom,m3hole_h])
      rotate([0,90,0])
        cylinder(r=m25hole_r,h=100,center=true);

    // Drill a hole for the connector
    // Disabled for development. Prefer a captive wire anyway.
    *translate([-pins_w/2,-lb-pins_depth, thickness_bottom])
      cube([pins_w,pins_depth*2, pins_h]);

    // NOT USED
    *translate([0,lt-5,0]) cylinder(r=m4hole_r,h=100,center=true);

    // Drill 3 M3 holes into the base for fixing
    // NOT USED
    *for (offset=[[0,lt-13],[w1/2-5,-lb+5],[-w1/2+5,-lb+5]])
        translate(offset)
        cylinder(d=3.1,h=100,center=true);

  } // end difference()
} // end module base()

if (!complete)
    base();
