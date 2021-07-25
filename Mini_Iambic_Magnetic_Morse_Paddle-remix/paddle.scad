/*
 * Remix of Mini Iambic Magnetic Morse Paddle by ok1cdj
 * https://www.thingiverse.com/thing:1796850
 *
 * Creative Commons - Attribution - Non-Commercial license
 */

include <util.scad>;
include <params.scad>;

// TODO: Add wiring channel, contact point

module paddle() {
  pivot_thickness=bearing_h+t_above_bearing;
  pivot_radius=bearing_r_outer + thickness;
  pivot_diameter=pivot_radius * 2;
  difference() {
    union() {
      // Horizontal part of paddle
      linear_extrude(height=pivot_thickness, convexity=4) {
        hull() {
          // Surround for main bearing
          circle(r=pivot_radius);
          // Surrount for magnet
          translate([-magnet_off_axis_dist,-magnet_axis_dist])
            circle(r=magnet_r+thickness);
          // Key points to intersect with paddle arm
          translate([(pivot_diameter-paddle_thickness)/2,lt-15])
            circle(d=paddle_thickness);
          translate([(contact_spacing+paddle_thickness)/2,lt-10])
            circle(d=paddle_thickness);
        }
      }

      // Vertical part of paddle
      linear_extrude(height=paddle_height, convexity=4) {
        // Chained hull creates hull between each two items
        chainedHull() {
          // First two points are aligned with the pivot_diameter
          translate([(pivot_diameter-1)/2,pivot_radius])
            circle(d=1); // Small circle for thin wall at pivot end
          translate([(pivot_diameter-paddle_thickness)/2,lt-15])
            circle(d=paddle_thickness);
          // Remaining points are from parameters for spacing
          // TODO: What is lt?
          // TODO: Compute spacing based on bearing-to-contact length,
          // then add fingerpiece length beyond that
          translate([(contact_spacing+paddle_thickness)/2,lt-10])
            circle(d=paddle_thickness);
          translate([(contact_spacing+paddle_thickness)/2,lt+1])
            circle(d=paddle_thickness);
          translate([(finger_spacing-paddle_thickness)/2,lt+5])
            circle(d=paddle_thickness);
          translate([(finger_spacing-paddle_thickness)/2,
              paddle_length-(paddle_thickness/2)])
            circle(d=paddle_thickness);
        }
      }
    } // end union()

    // Hole for bearing to fit in
    translate([0,0,t_above_bearing]) {
      cylinder(r=bearing_r_outer,h=2*paddle_height);
    }
    // Lip for bearing to rest on at bottom of hole
    translate([0,0,-t_above_bearing]) {
      cylinder(r=bearing_r_outer-1,h=2*paddle_height);
    }
    // Indentation to attach magnet
    translate([-magnet_off_axis_dist,-magnet_axis_dist,bearing_h+t_above_bearing-magnet_h]) {
      cylinder(r=magnet_r,h=magnet_h*2,center=false);
    }

    // Remove vertical extension towards magnet & bearing to clear other paddle
    hull() {
      translate([0,0,pivot_thickness]) {
        cylinder(d=pivot_diameter+7,h=1);
      }
      translate([pivot_radius,pivot_radius,paddle_height]) {
        cylinder(d=pivot_diameter+4,h=1);
      }
    }
  } // end difference()
} // end module paddle()

if (!complete) 
    paddle();
