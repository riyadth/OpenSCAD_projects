/*
 * Remix of Mini Iambic Magnetic Morse Paddle by ok1cdj
 * https://www.thingiverse.com/thing:1796850
 *
 * Creative Commons - Attribution - Non-Commercial license
 *
 * Vertical magnet placement rather than horizontal
 */

include <util.scad>;
include <params.scad>;

/*
 * Original paddle used magnets in a horizontal configuration,
 * such that as one magnet is moved over the other it will repel.
 * In addition to repulsion in the desired vector, the magnets
 * would also produce force in an up-and-down vector, which is
 * not useful for moving the paddles.
 *
 * This version moves the magnets to the vertical portion of the
 * paddle arm, and provides multiple locations where magnets might
 * be placed.
 */

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
          // Key points to intersect with paddle arm
          translate([pivot_radius-(paddle_thickness/2),
              pivot_radius+4]) {
            circle(d=paddle_thickness);
          }
        }
      }

      // Vertical part of paddle
      linear_extrude(height=paddle_height, convexity=4) {
        // Chained hull creates hull between each two items
        chainedHull() {
          // First two points should be dimensioned so they leave
          // magnet_spacing distance between the arms
          translate([((pivot_radius-(magnet_spacing/2)) + magnet_spacing)/2,
              0]) {
            circle(d=(pivot_radius-(magnet_spacing/2)));
          }
          translate([((pivot_radius-(magnet_spacing/2)) + magnet_spacing)/2,
              bearing_to_contact - (adjuster_y / 2) - 7]) {
            circle(d=(pivot_radius-(magnet_spacing/2)));
          }
          translate([(contact_spacing+paddle_thickness)/2,
              bearing_to_contact - (adjuster_y / 2) - 3]) {
            circle(d=paddle_thickness);
          }
          translate([(contact_spacing+paddle_thickness)/2,
              bearing_to_contact + (adjuster_y / 2) + 2]) {
            circle(d=paddle_thickness);
          }
          translate([(finger_spacing-paddle_thickness)/2,
              bearing_to_contact + (adjuster_y / 2) + 5]) {
            circle(d=paddle_thickness);
          }
          translate([(finger_spacing-paddle_thickness)/2,
              bearing_to_contact + (adjuster_y / 2) + 5 + fingerpiece_length]) {
            circle(d=paddle_thickness);
          }
        }
      }
    } // end union()

    // Clearance above the bearing
    translate([0,0,pivot_thickness]) {
      cylinder(r=pivot_radius+1,h=2*paddle_height);
    }

    // Hole for bearing to fit in
    translate([0,0,t_above_bearing]) {
      cylinder(r=bearing_r_outer,h=2*paddle_height);
    }
    // Lip for bearing to rest on at bottom of hole
    translate([0,0,-t_above_bearing]) {
      cylinder(r=bearing_r_outer-1,h=2*paddle_height);
    }

    // Indentations to attach magnets
    for (m=[14:magnet_d+0.2:28]) {
      translate([0,m,paddle_height/2]) {
        rotate([0,90,0])
        cylinder(r=magnet_r,h=(magnet_spacing/2)+magnet_h,center=false);
      }
    }

  } // end difference()
} // end module paddle()

if (!complete)
    paddle();
