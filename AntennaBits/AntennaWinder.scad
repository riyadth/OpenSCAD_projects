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
finger_d=20;
winder_length=200;
winder_width=120;
winder_thickness=7;
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
  hull() {
    circle(d=finger_d);
    translate([x,y]) {
      circle(d=finger_d);
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
  echo("saddle_r = ", saddle_r);
}

// One side of the 2d shape
module right_side()
{
  union() {
    finger(half_l, half_w);
    finger(half_l, -half_w);
    v_fill();
  }
}

// The 3d shape made from two mirrored halves
module antenna_winder(thickness) {
  linear_extrude(height=thickness) {
    union() {
      right_side();
      mirror([1,0,0]) right_side();
    }
  }
}

antenna_winder(winder_thickness);
