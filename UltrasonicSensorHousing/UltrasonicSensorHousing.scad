$fn=100;

module crystal_model() {
    translate([0,-7,0]) hull() {
        translate([-3.25,0,0]) linear_extrude(height=5) circle(d=3.5);
        translate([ 3.25,0,0]) linear_extrude(height=5) circle(d=3.5);
    }
}

module connector_model() {
    translate([0,10,-4]) linear_extrude(height=4) square([9,9], center=true);
}

module board_model() {
    linear_extrude(height=1) square([46,21],center=true);
}

module sensor_model() {
    translate([-12.8,0,0]) linear_extrude(height=12) circle(d=17);
    translate([ 12.8,0,0]) linear_extrude(height=12) circle(d=17);
    board_model();
    crystal_model();
    connector_model();
}


module case() {
    translate([0,0,-13]) linear_extrude(height=24) square([54,28], center=true);
}
/*
difference() {
    case();
    hull() sensor_model();
}
*/

wall_thickness=3;
board_width=21;
board_length=45.5;
transducer_length=12;
transducer_diameter=17;
case_width=board_width+(wall_thickness*2);
case_length=board_length+(wall_thickness*2);

module port() {
    circle(d=transducer_diameter);
}

module perimeter() {
    minkowski() {
        square([case_length-wall_thickness,case_width-wall_thickness], center=true);
        circle(d=wall_thickness);
    }
}

module face() {
    difference() {
        perimeter();
        translate([-12.8,0,0]) port();
        translate([ 12.8,0,0]) port();
    }
}

module lower_walls() {
    difference() {
        perimeter();
        hull() {
            translate([-12.8,0,0]) circle(d=21);
            translate([ 12.8,0,0]) circle(d=21);
        }        
    }
}

module upper_walls() {
    difference() {
        perimeter();
        square([board_length,board_width], center=true);
    }
}

module main_unit() {
    linear_extrude(height=wall_thickness) face();
    linear_extrude(height=transducer_length) lower_walls();
    linear_extrude(height=14) upper_walls();
}

module lid() {
    linear_extrude(height=wall_thickness) perimeter();
    difference() {
        linear_extrude(height=6+wall_thickness) lower_walls();
        linear_extrude(height=6+wall_thickness) translate([0,-8.5,0]) square([13,10], center=true);
    }
}

main_unit();
//lid();