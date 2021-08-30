/*
 * 6m antenna matching coil
 */
$fn=75;

gap=0.2;
pipe_id=38.2;
pipe_od=42;
bottom_thickness=1.5;
wall_height=8;
wall_thickness=3;
screw_dia=3;
so239_side=25.5+gap;
so239_conn=16+gap;
so239_hole=4+gap;
so239_plate=2;
so239_spacing=21.5-so239_hole;
// 28.8-3.5

// Model of the SO-239 connector
module so239() {
  difference() {
    union() {
      // Plate
      translate([-(so239_side/2), -(so239_side/2), 0])
        cube([so239_side, so239_side, 2]);
      // Connector surround
      cylinder(d=11, h=4);
      // Center contact
      cylinder(d=4, h=10);
      // Main threaded connector body
      translate([0, 0, -16]) cylinder(d=so239_conn, h=16);
    }

    // Drill the holes
    translate([so239_spacing/2, so239_spacing/2, -1]) cylinder(d=so239_hole, h=4);
    translate([-so239_spacing/2, so239_spacing/2, -1]) cylinder(d=so239_hole, h=4);
    translate([-so239_spacing/2, -so239_spacing/2, -1]) cylinder(d=so239_hole, h=4);
    translate([so239_spacing/2, -so239_spacing/2, -1]) cylinder(d=so239_hole, h=4);
  }
}

// Place to mount the SO-239 connector
module so239_mount() {
  // Recess to mount the connector plate
  translate([-(so239_side/2), -(so239_side/2), 0]) cube([so239_side, so239_side, so239_side]);

  // Main connector access
  translate([0, 0, -2]) cylinder(d=so239_conn, h=wall_height);

  // Screw holes
  translate([so239_spacing/2, so239_spacing/2, -2]) cylinder(d=so239_hole, h=wall_height);
  translate([-so239_spacing/2, so239_spacing/2, -2]) cylinder(d=so239_hole, h=wall_height);
  translate([-so239_spacing/2, -so239_spacing/2, -2]) cylinder(d=so239_hole, h=wall_height);
  translate([so239_spacing/2, -so239_spacing/2, -2]) cylinder(d=so239_hole, h=wall_height);

  // Extra space around screw holes for access
  translate([so239_spacing/2, so239_spacing/2, 2]) cylinder(d=12,h=wall_height);
  translate([-so239_spacing/2, so239_spacing/2, 2]) cylinder(d=12,h=wall_height);
  translate([-so239_spacing/2, -so239_spacing/2, 2]) cylinder(d=12,h=wall_height);
  translate([so239_spacing/2, -so239_spacing/2, 2]) cylinder(d=12,h=wall_height);
}

difference() {
  union() {
    // The "plug" shape to fit in the pipe
    cylinder(d=pipe_od, h=bottom_thickness+so239_plate);
    cylinder(d=pipe_id, h=wall_height);
  }

  // Connector sits 1mm above the bottom
  translate([0,0,bottom_thickness]) so239_mount();

  // Add horizontal mounting holes to screw in to pipe
  translate([0,0,(wall_height/2)+1]) rotate([90,0,0]) cylinder(d=screw_dia,h=pipe_od,center=true);
  translate([0,0,(wall_height/2)+1]) rotate([0,90,0]) cylinder(d=screw_dia,h=pipe_od,center=true);
}

// Visualize the SO-239 itself
// #translate([0,0,1]) so239();
