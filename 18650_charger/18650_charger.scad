/*
 * 18650 button-top adapter for Tenergy universal charger
 *
 * How can it be "universal" if it can't hold an 18650 button-top battery?
 */
$fn=75;


neg_term_width=11;
neg_term_notch=5;
adapt_d=25;
adapt_r=adapt_d/2;
adapt_h=16;
adapt_l=40+neg_term_notch;
screw_d=4;
arc_d=9;
top_w=32;

/* Adapter to fit charger that routes contacts through wires to cell holder */
module charger_adapter() {
  difference() {
    union() {
      cylinder(d=adapt_d,h=adapt_l);
      translate([-top_w/2,-(adapt_r-arc_d),0]) {
        cube([top_w,top_w,adapt_l]);
      }
    }
    translate([-((top_w+2)/2),4,-1]) {
      cube([top_w+2,top_w,adapt_l+2]);
    }
    translate([0,-1,-1]) {
      cylinder(d=screw_d,h=adapt_l+2);
    }
    translate([0,0,adapt_l-neg_term_notch+neg_term_notch]) {
      cube([neg_term_width,adapt_d+2,neg_term_notch*2], center=true);
    }
  }
}

/* Cell holder for 18650 button-top battery */
module cell_holder() {
}

charger_adapter();
