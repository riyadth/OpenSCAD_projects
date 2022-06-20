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
winder_length=200;
winder_width=100;
winder_height=10;
winder_thickness=4;
notch_length=120;

// Compute parameters to make the shape
finger_r=finger_d/2;
half_l=(winder_length/2)-finger_d;
half_w=(winder_width/2)-finger_d;
winder_angle=atan(half_w/half_l);
saddle_r=(finger_r - ((notch_length/2) * sin(winder_angle))) /
         (sin(winder_angle) - 1);
saddle_x=(notch_length/2) + saddle_r;
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
  x_pos=(notch_length/2)+saddle_r-(saddle_r*sin(winder_angle));
  y_pos=(saddle_r * cos(winder_angle));
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

// The 3d shape made from two mirrored halves
module antenna_winder(thickness) {
  difference() {
    linear_extrude(height=thickness) {
      full_shape();
    }
    // Subtract out a smaller version to produce a 3d effect
    translate([0,0,winder_thickness]) linear_extrude(height=thickness) {
      offset(r=-winder_thickness) full_shape();
    }
  }
}

antenna_winder(winder_height);
