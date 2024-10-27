/* 
 * Spacer for wall mount of shed
 */
$fn=12;

spacer_dia=25;
spacer_len=23;
screw_dia=5.5;

module spacer() {
    difference() {
        cylinder(h=spacer_len, d=spacer_dia);
        translate([0,0,-1]) {
            cylinder(h=spacer_len+2, d=screw_dia);
        }
    }
}

/* Render the spacer */
spacer();
