height = 11;
wall=3.5;
bkt_w = 27;
bkt_l = 27;
bkt_h = 3.5;
hole_d = 4;

skirt = 10;

hole_center = (2*wall + bkt_w) / 2;
h_x1 = skirt + hole_center - 8;
h_x2 = skirt + hole_center + 8;
h_y1 = 5.25;
h_y2 = h_y1 + 14;

top_w = bkt_w + (2 * wall);
top_l = bkt_l + (2 * wall);
top_offset = skirt;
bottom_w = top_w + (2 * skirt);
bottom_l = top_l + skirt;

difference() {
    hull() {
        translate([skirt, 0, height+wall-0.1]) cube([top_w, top_l, 0.1], false);
        translate([0, 0, 0]) cube([bottom_w, bottom_l, wall], false);
    }
   translate([wall+skirt, 0, height])  cube([bkt_w,bkt_l,bkt_h], false);
   translate([h_x1, h_y1, 0]) cylinder(h=height,d= hole_d, center=false);
   translate([h_x1, h_y2, 0]) cylinder(h=height,d= hole_d, center=false);
   translate([h_x2, h_y2, 0]) cylinder(h=height,d= hole_d, center=false);
   translate([h_x2, h_y1, 0]) cylinder(h=height,d= hole_d, center=false);
}

