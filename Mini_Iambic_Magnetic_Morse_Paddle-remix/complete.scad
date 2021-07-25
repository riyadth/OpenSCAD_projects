/*
 * Remix of Mini Iambic Magnetic Morse Paddle by ok1cdj
 * https://www.thingiverse.com/thing:1796850
 *
 * Creative Commons - Attribution - Non-Commercial license
 */

include <util.scad>;
include <params.scad>;

complete=true;
include <paddle.scad>;
include <base.scad>;

render_all=1;
if (render_all) {
//intersection() {
color([1,0,0]) base();
translate([0,0,thickness_bottom3]) {
  color([0,1,0]) paddle();
  translate([0,0,paddle_height]) {
    rotate([0,180,0]) {
      color([0,0,1]) paddle();
    }
  }
}

//}
}
else {
  paddle();
}
