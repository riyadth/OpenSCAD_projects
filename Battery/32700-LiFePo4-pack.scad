/*
 * Battery holder for Lithium cells
 *
 * 4S LiFePo4 32700 cells
 *
 * TODO:
 * Top plate (holes to access cells for wire attachment?)
 * Routing of balance wire out of bottom pockets.
 * Mounting arrangement for BMS?
 * Deepen zip tie channel on one side to fully seat clip?
 * Channel along bottom for zip tie to rest in? (Supports?)
 * Rounded corner for zip tie across from "buckle"?
 * Holes instead of zip tie channels?
 *
 * Zip tie buckle likely should be on top.
 *
 * Zip tie not too important if outer wrap shrink is used
 */
$fn=75;

num_cells=4;
gap=4;
cell_d=32.5;
cell_r=cell_d/2;
tolerance=0.6;
edge=3;
notch=15;
base_w=cell_d+(2*edge);
// base_l=(cell_d*4)+(2*edge)+gap;
base_h=10;
base_thick=3;
zip_tie=4;

/* Make a rectange at a given angle, center point can be placed on pocket */
module wire_path(w,l,angle) {
  translate ([0,0,base_thick]) linear_extrude(base_h)
  rotate([0,0,angle]) {
    translate([0,-w/2,0]) {
      square([l,w]);
    }
  }
}

module top_plate() {
  difference() {
    minkowski() {
      hull() {
        // Two cylinders at opposite ends
        translate([cell_r+edge,base_w/2,0]) {
          cylinder(h=base_h,r=cell_r+edge);
        }
        // Account for a gap every 2 cells
        translate([((num_cells*2)-1)*cell_r+edge+(ceil(num_cells/2)-1)*gap,base_w/2,0]) {
          cylinder(h=base_h,r=cell_r+edge);
        }
      }
      sphere(r=1);        // Round the edges
    }
    // Subtract out the cell pockets
    for (n = [1:num_cells]) {
      translate([(((n*2)-1)*cell_r+edge)+(floor((n-1)/2)*gap),(cell_r+edge),base_thick]) {
        cylinder(h=base_h,d=cell_d + tolerance);
      }
    }
    // Cut-outs for upper connections
    /*
    for (n = [1:2:num_cells]) {
      translate([n*cell_d+edge-(notch/2)+(floor((n-1)/2)*gap),cell_r+edge-(notch/2),base_thick]) {
        cube([notch,notch,notch]);
      }
    }
    */
    translate([2*cell_d+edge-(notch/2),cell_r+edge-(notch/2),base_thick]) {
      cube([notch,notch,notch]);
    }
    // Custom wire paths
    translate([cell_r+edge,base_w/2,0]) {
      wire_path(8,cell_r+3,45);
    }
    translate([5*cell_r+edge+gap,base_w/2,0]) {
      wire_path(8,cell_r+3,-145);
    }
    translate([7*cell_r+edge+gap,base_w/2,0]) {
      wire_path(8,cell_r+3,135);
    }
    // Zip tie notches
    /*
    incr=cell_d+gap/2;
    for (x = [0:incr:3*cell_d]) {
      translate([edge+cell_d-zip_tie/2+x,-3,-1]) cube([zip_tie,zip_tie,base_h+2]);
      translate([edge+cell_d-zip_tie/2+x,base_w-(zip_tie-3),-1]) cube([zip_tie,zip_tie,base_h+2]);
    }
    */
  }
}

module bottom_plate() {
  difference() {
    minkowski() {
      hull() {
        // Two cylinders at opposite ends
        translate([cell_r+edge,base_w/2,0]) {
          cylinder(h=base_h,r=cell_r+edge);
        }
        // Account for a gap every 2 cells
        translate([((num_cells*2)-1)*cell_r+edge+(ceil(num_cells/2)-1)*gap,base_w/2,0]) {
          cylinder(h=base_h,r=cell_r+edge);
        }
      }
      sphere(r=1);        // Round the edges
    }
    // Subtract out the cell pockets
    for (n = [1:num_cells]) {
      translate([(((n*2)-1)*cell_r+edge)+(floor((n-1)/2)*gap),(cell_r+edge),base_thick]) {
        cylinder(h=base_h,d=cell_d + tolerance);
      }
    }
    // Cut-outs for lower connections
    for (n = [1:2:num_cells]) {
      translate([n*cell_d+edge-(notch/2)+(floor((n-1)/2)*gap),cell_r+edge-(notch/2),base_thick]) {
        cube([notch,notch,notch]);
      }
    }
    // Custom wire paths
    translate([3*cell_r+edge,base_w/2,0]) {
      wire_path(8,cell_r+2,-45);
    }
    translate([7*cell_r+edge+gap,base_w/2,0]) {
      wire_path(8,cell_r+2,120);
    }
    // Zip tie notches
    /*
    incr=cell_d+gap/2;
    for (x = [0:incr:3*cell_d]) {
      translate([edge+cell_d-zip_tie/2+x,-3,-1]) cube([zip_tie,zip_tie,base_h+2]);
      translate([edge+cell_d-zip_tie/2+x,base_w-(zip_tie-3),-1]) cube([zip_tie,zip_tie,base_h+2]);
    }
    */
  }
}

// top_plate();
bottom_plate();
