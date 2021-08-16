/*
 * Plastic foot for Weber kettle grill
 */
$fn=75;

leg_d=25.4;     // mm
leg_angle=24;   // degrees

adjustment=0.5;

foot_d=32;
foot_height=32;
wall_thickness=4;

module leg(dia,height) {
  translate([0,0,9]) rotate([0,leg_angle,0]) {
    cylinder(d=dia,h=height);
  }
}

difference() {
  hull() {
    cylinder(d=foot_d-4);
    translate([0,0,2]) cylinder(d=foot_d,h=(foot_height/2)-2);
    leg(leg_d+(2*wall_thickness),foot_height);
  }
  leg(leg_d+adjustment,foot_height+1);
}

