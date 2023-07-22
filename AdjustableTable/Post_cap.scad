/*
 * Accessories for adjustable table
 */
$fn=128;
 
post_od=37.6;
post_id=33.5;
post_center_od=12.6;
post_center_id=8.7;
post_slot_w=7;
cap_thickness=3;
cap_depth=7;
wye_thickness=5;
gap_angle=20;

module wye_leg(thickness) {
    translate([-thickness/2, 0, cap_thickness])
        cube([thickness, 20, cap_depth+1]);
}

module wye() {
    wye_leg(2*wye_thickness);
    rotate([0,0,-360/3])
        wye_leg(wye_thickness);
    rotate([0,0,360/3])
        wye_leg(wye_thickness);
    translate([0,0,cap_thickness])
        cylinder(h=cap_depth+1, d=post_center_od+2);
}

module gap_fill() {
    translate([0,0,cap_thickness])
        rotate([0,0,90-(gap_angle/2)])
            rotate_extrude(angle=gap_angle)
                translate([-((post_id/2)+((post_od-post_id)/2)),0])
                    square([(post_od-post_id)/2,cap_depth-1]);
}

module cap() {
    cylinder(h=1, d1=post_od-2, d2=post_od);
    translate([0,0,1])
        cylinder(h=cap_thickness-1, d=post_od);
    translate([0,0,cap_thickness])
        cylinder(h=cap_depth-1, d=post_id);
    translate([0,0,cap_thickness+cap_depth-1])
        cylinder(h=1, d1=post_id, d2=post_id-2);
    gap_fill();
}

difference() {
    cap();
    wye();
}