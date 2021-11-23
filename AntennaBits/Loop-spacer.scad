/*
 * Magnetic loop antenna bits
 *
 * Spacer for two-turn magnetic loop antenna, using 7D-FB cable (cheap RG-8
 * equivalent)
 */
$fn=75;

cable_d=10+1;
cable_r=cable_d/2;
cable_thick=2.4;
zip_w=3;
zip_d=1;
outer_d=cable_d+cable_thick+zip_d;
spacer_h=2;
spacer_l=80;
spacer_w=outer_d+0;
cable_h=spacer_h+zip_w+3;
center_hole_d=4;

/* side is -1 or +1 */
module cable_end(side=-1) {
  difference () {
    union() {
      translate([0,0,spacer_h]) cylinder(d=outer_d,h=zip_w+1);
      translate([0,0,spacer_h+zip_w+1]) cylinder(d1=outer_d,d2=outer_d+1,h=1);
      translate([0,0,spacer_h+zip_w+2]) cylinder(d=outer_d+1,h=1);
    }
    translate([side*spacer_w/2+(side*1),0,spacer_w/4]) cube([spacer_w, 2*spacer_w, spacer_w], center=true);
  }
}

// First prototype. Doesn't print well, ends are too detailed.
module type_1() {
  difference() {
    union() {
      // Two ends
      cable_end(-1);
      translate([spacer_l,0,0]) cable_end(1);
      // The spacer body
      translate([0,-spacer_w/2,0]) {
        minkowski() {
          cube([spacer_l,spacer_w,spacer_h]);
          sphere(r=1);
        }
      }
    }
    // Cut out paths for cable
    translate([0,0,-2]) cylinder(d=cable_d, h=2*cable_h);
    translate([spacer_l,0,-2]) cylinder(d=cable_d, h=2*cable_h);
    // Holes
    /*
    for (off=[-2:1:2]) {
      translate([spacer_l/2+(off*(spacer_l/4)),0,-1]) cylinder(d=5,h=spacer_h+2);
    }
    */
  }
}

/* Arc cable support structure for use with zip ties
 * Used in type_2 and type_3 spacers
 */
module cable_support(l,thickness) {
  large_r=cable_r+thickness;
  translate([0,-l/2,0]) {
    rotate([90,0,180]) {
      difference() {
        cylinder(r=large_r,h=l);
        translate([cable_r,large_r,-1]) {
          cylinder(r=cable_r,h=l+2);
        }
        translate([-(large_r+1),-(2*large_r),-1]) {
          cube([2*large_r+2,2*large_r,l+2]);
        }
        translate([cable_r,-1,-1]) {
          cube([thickness,2*thickness,l+2]);
        }
      }
    }
  }
}

module type_2_end() {
  difference() {
    union() {
      cable_support(spacer_w,spacer_h);
      /* Other end -- mirror() instead
      translate([spacer_l,0,0])
        rotate([0,0,180])
          cable_support(spacer_w,spacer_h);
          */
      translate([0,-spacer_w/2,0]) {
        cube([spacer_l/2,spacer_w,spacer_h]);
      }
    }
    // Zip tie holes
    translate([cable_r+spacer_h+(zip_w/2),spacer_w/4,-1]) {
      cylinder(d=zip_w,h=spacer_h+2);
    }
    translate([cable_r+spacer_h+(zip_w/2),-spacer_w/4,-1]) {
      cylinder(d=zip_w,h=spacer_h+2);
    }
  }
}

/*
 * Type 2 was slow to print due to holes for zip ties, and also resulted in
 * messier prints due to blobs and such. (Tunable on the printer, but not
 * desirable -- I want this to be easier to print.)
 */
module type_2() {
  difference() {
    // Two ends, mirrored
    union() {
      type_2_end();
      translate([spacer_l,0,0]) {
        mirror([1,0,0]) {
          type_2_end();
        }
      }
    }
    // Centered hole
    translate([spacer_l/2,0,-1]) {
      cylinder(d=center_hole_d,h=spacer_h+2);
    }
  }
}

/* Type 3 is the final iteration
 * T-shaped end. Use 2 zip ties to wrap cable to the end.
 * Bumps prevent zip tie from falling of sides.
 * Center support is triangle shaped for rigidity
 */
module type_3_end() {
  nubbin_d=3;
  nubbin_r=nubbin_d/2;
  end_w=spacer_w+(2*zip_w)+(2*nubbin_d);
  cable_support(end_w,spacer_h);

  hull() {
    // Base plate
    translate([0,-spacer_w/2,0]) {
      cube([spacer_l/2,spacer_w,spacer_h]);
    }

    // Bar down the middle
    translate([0,-spacer_h/2,0]) {
      cube([spacer_l/2,spacer_h,spacer_h+cable_r]);
    }
  }

  // Nubbin on top
  rotate([0,45,0]) {
    translate([nubbin_r,((end_w)/2)-nubbin_r,cable_r+spacer_h]) {
      sphere(r=nubbin_r);
    }
  }
  rotate([0,45,0]) {
    translate([nubbin_r,-((end_w)/2)+nubbin_r,cable_r+spacer_h]) {
      sphere(r=nubbin_r);
    }
  }
}

// Create the full spacer from two halves (mirrored)
module type_3() {
  union() {
    type_3_end();
    translate([spacer_l,0,0]) {
      mirror([1,0,0]) {
        type_3_end();
      }
    }
  }
}

// Render the spacer
type_3();
