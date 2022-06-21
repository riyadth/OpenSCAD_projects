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

// Configurable parameters
finger_d=15;
finger_hole=7;
finger_len=0;
winder_length=190;
winder_width=90;
winder_height=7;
winder_thickness=2;
edge_thickness=5;

// Compute parameters to make the shape
finger_r=finger_d/2;
half_l=(winder_length-finger_d)/2;
half_w=(winder_width-finger_d)/2;
winder_angle=atan(half_w/half_l);
finger_end_x=(half_l + (finger_r * sin(winder_angle)));
saddle_chord_x=(finger_end_x - (finger_len * cos(winder_angle)));
v_point_x=(finger_r / sin(winder_angle));
saddle_chord_y=((saddle_chord_x - v_point_x) * tan(winder_angle));
saddle_r=(saddle_chord_y / cos(winder_angle));
saddle_x=(saddle_chord_y * tan(winder_angle)) + saddle_chord_x;
saddle_y=0;

// A single "finger" of the winder
module finger(x, y) {
  difference() {
    hull() {
      circle(d=finger_d);
      translate([x,y]) {
        circle(d=finger_d);
      }
    }
    translate([x,y]) {
      circle(d=finger_hole);
    }
  }
}

// The curved fill in the V notch, along with the top and bottom edges
module v_fill() {
  x_pos=saddle_chord_x;
  y_pos=saddle_chord_y;
  difference() {
    polygon(points=[[0,y_pos], [x_pos,y_pos], [x_pos,-y_pos], [0,-y_pos]]);
    translate([saddle_x, saddle_y]) {
      circle(r=saddle_r);
    }
  }
}

// One side of the 2d shape
module right_side() {
  union() {
    finger(half_l, half_w);
    finger(half_l, -half_w);
    v_fill();
  }
}

// Combine both halves into a single 2d shape
module full_shape() {
  union() {
    right_side();
    mirror([1,0,0]) right_side();
  }
}

module antenna_winder_solid(thickness) {
  linear_extrude(height=thickness) {
    difference() {
      full_shape();
      // Remove an oval in the center
      scale([(saddle_x-saddle_r),saddle_chord_y]) {
        circle(d=1.3);    // "Scaling factor" for oval
      }
    }
  }
}

// The 3d shape made from two mirrored halves
module antenna_winder(thickness) {
  difference() {
    antenna_winder_solid(thickness);
    // Subtract out a smaller version to produce a 3d effect
    translate([0,0,winder_thickness]) linear_extrude(height=thickness) {
      offset(r=-edge_thickness) full_shape();
    }
  }
}

module antenna_winder_for_pdf() {
  rotate([0,0,90]) {
    full_shape();
  }
}

antenna_winder_solid(winder_height);
// antenna_winder(winder_height);
// antenna_winder_for_pdf(); // Rotated for printing on 2d printer
