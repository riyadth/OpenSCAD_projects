/*
 * Battery holder for Lithium cells
 *
 * 4S LiFePo4 32700 cells
 */
$fn=75;

cell_d=30;
cell_r=cell_d/2;
edge=3;
gap=2;
notch=15;
base_w=cell_d+(2*edge);
base_l=(cell_d*4)+(2*edge)+gap;
base_h=8;
base_thick=3;
zip_tie=4;

// TODO: Round corners
difference() {
  minkowski() {
    hull() {
      translate([cell_r+edge,cell_r+edge,0]) cylinder(h=base_h,r=cell_r+edge);
      translate([7*cell_r+edge+gap,cell_r+edge,0]) cylinder(h=base_h,r=cell_r+edge);
    }
    sphere(r=1);
  }
  // Cell holders
  translate([(cell_r+edge),(cell_r+edge),base_thick]) cylinder(h=base_h,d=cell_d);
  translate([(3*cell_r+edge),(cell_r+edge),base_thick]) cylinder(h=base_h,d=cell_d);
  translate([(5*cell_r+edge)+gap,(cell_r+edge),base_thick]) cylinder(h=base_h,d=cell_d);
  translate([(7*cell_r+edge)+gap,(cell_r+edge),base_thick]) cylinder(h=base_h,d=cell_d);
  // Cut-outs for lower connections
  translate([cell_d+edge-(notch/2),cell_r+edge-(notch/2),base_thick]) cube([notch,notch,notch]);
  translate([3*cell_d+edge+gap-(notch/2),cell_r+edge-(notch/2),base_thick]) cube([notch,notch,notch]);
  // Zip tie notches
  incr=cell_d+gap/2;
  for (x = [0:incr:3*cell_d]) {
    translate([edge+cell_d-zip_tie/2+x,-3,-1]) cube([zip_tie,zip_tie,base_h+2]);
    translate([edge+cell_d-zip_tie/2+x,base_w-(zip_tie-3),-1]) cube([zip_tie,zip_tie,base_h+2]);
  }
}
