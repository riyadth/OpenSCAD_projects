/* Battery adapter for CR123A in SK-68 flashlight.
 * For flashlight that can accept CR123A width, but is
 * sized for a AA battery.
 */
$fn=100;

cr123a_dia=16;
cr123a_len=34.5;
aa_dia=14.5;
aa_len=50;
screw_head_height=0.75;
screw_dia=2.9;

inner_dia=screw_dia+0.5;
outer_dia=cr123a_dia;
length=(aa_len-cr123a_len)-screw_head_height;

/* Model of a screw in the core to use as a conductor */
module screw() {
    cylinder(h=screw_head_height + length, d=screw_dia);
}

/* Basic adapter with hole in the center for a screw
 * conductor */
module adapter_with_screw_conductor() {
    difference() {
        cylinder(h=length, d=outer_dia);
        cylinder(h=length, d=inner_dia);
    }
}

/* A cylinder that is wide in the center, but narrow at top
 * and bottom, to easily pass wire without need for (much)
 * drilling */
module cone_cyl(h,d) {
    cylinder(d1=d,d2=2*d,h=h/2);
    translate([0,0,h/2]) cylinder(d1=2*d,d2=d,h=h/2);
}

/* Adapter with several holes to pass wire through from top
 * to bottom, instead of using a screw or other cylindrical
 * conductor */
module adapter_with_holes_for_wire() {
    difference() {
        cylinder(h=length, d=outer_dia);
        translate([3,0,0]) cone_cyl(h=length, d=2);
        translate([-3,0,0]) cone_cyl(h=length, d=2);
        translate([0,3,0]) cone_cyl(h=length, d=2);
        translate([0,-3,0]) cone_cyl(h=length, d=2);
    }
    // Add a "bump" on the top of the adapter
    //translate([0,0,length-1]) sphere(d=4);
}

/* Adapter with notches in the sides so that bare wire can
 * be wrapped around several times, in an easier way than
 * routing wire through holes. */
module adapter_with_notches_for_wire() {
    difference() {
        cylinder(h=length, d=outer_dia);
        translate([3,-2,0]) cube([8,4,length]);
        translate([-11,-2,0]) cube([8,4,length]);
        //cylinder(h=1, d=outer_dia-1);
    }
    // Add a "bump" on the top of the adapter
    translate([-2,-3,length]) cube([4, 6, 1]);
}

/* Render the desired adapter */
adapter_with_screw_conductor();
//#screw(); // Visualize the screw
