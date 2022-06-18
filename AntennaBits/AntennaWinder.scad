/*
 * Wire antenna winder
 *
 * TODO:
 *   Location for 9:1 or 49:1 transformer
 *   Strain relief
 *   Holes for hanging/mounting/minimizing material
 *   Chamfering edges
 */
$fn=75;

finger_r=10;
saddle_r=15;
winder_angle=50;
ext_len=20;
body_h=25;
thickness=5;

v_point_x=(finger_r/sin(winder_angle/2));
saddle_ctr_x=(finger_r+saddle_r)/sin(winder_angle/2);
finger_ctr_x=(ext_len+(finger_r+saddle_r)/tan(winder_angle/2));

// A single "finger" of the winder
module finger(angle) {
  hull() {
    circle(r=finger_r);
    rotate([0,0,angle]) {
      translate([finger_ctr_x, 0]) {
        circle(r=finger_r);
      }
    }
  }
}

// Filling out the V shape
module center_fill() {
  hull() {
    translate([v_point_x, 0]) {
      circle(r=(1));
    }
    translate([saddle_ctr_x, 0]) {
      circle(r=saddle_r);
    }
  }
}

// The square top and bottom segments
module body(side) {
  hull() {
    circle(r=finger_r);
    translate([0, side * (body_h-finger_r)]) circle(r=finger_r);
    x = (body_h-finger_r) / tan(winder_angle/2);
    translate([x, side * (body_h-finger_r)]) circle(r=finger_r);
  }
}

// One side of the 2d shape
module right_side()
{
  difference() {
    union() {
      finger(winder_angle/2);
      finger(-winder_angle/2);
      center_fill();
      body(1);
      body(-1);
    }
    translate([saddle_ctr_x, 0]) {
      circle(r=saddle_r);
    }
  }
}

// Make the 3d object
linear_extrude(height=thickness) {
  union() {
    right_side();
    mirror([1,0,0]) right_side();
  }
}
