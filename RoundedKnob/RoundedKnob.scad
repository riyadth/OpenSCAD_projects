$fn=50;
module knob(r,l) {
    difference() {
        minkowski() { linear_extrude(l) circle(r); sphere(3); }
        translate([0,0,-4]) linear_extrude(4) circle(r+4);
        translate([0,0,-1]) linear_extrude((l/2)+1) circle(2);
        translate([r-5,0,l+8]) sphere(7);
        
        // knurling
        for (i = [0 : 10 : 350]) {
            rotate([0,0,i]) translate([r+3,0,0]) linear_extrude(l+10) rotate([0,0,45]) square(r/16);
            // rotate([0,0,i]) translate([r+3,0,0]) linear_extrude(l+10) circle(r/16);
        }
    }
}

knob(15,10);