/*
 * Remix of Mini Iambic Magnetic Morse Paddle by ok1cdj
 * https://www.thingiverse.com/thing:1796850
 *
 * Creative Commons - Attribution - Non-Commercial license
 */

module roundedSquare(pos=[10,10],r=2) {
	minkowski() {
		square([pos[0]-r*2,pos[1]-r*2],center=true);
		circle(r=r);
	}
}

module roundedBox(size, r, top=true, bottom=true)
{
    if (top && bottom) {
        minkowski() {
            cube([size[0]-r*2,size[1]-r*2,size[2]-r*2],true);
            sphere(r=r);
        }
    } else if (! top && ! bottom) {
        linear_extrude(size[2],center=true)
        offset(r)
        square([size[0]-r*2, size[1]-r*2], true);
    } else if (top) {
        translate([0, 0, -r])
        intersection() {
            roundedBox([size[0], size[1], size[2]+2*r], r, true, true);
            translate([0, 0, 2*r])
            cube([size[0]*2, size[1]*2, size[2]+2*r], true);
        }
    } else if (bottom) {
        rotate([0, 0, 90]) roundedBox(size, r, true, false);
    }
}

module roundedSlab(size, r) {
    hull() {
        translate([ size[0]/2-r,  size[1]/2-r, 0]) sphere(r=r);
        translate([ size[0]/2-r, -size[1]/2+r, 0]) sphere(r=r);
        translate([-size[0]/2+r, -size[1]/2+r, 0]) sphere(r=r);
        translate([-size[0]/2+r,  size[1]/2-r, 0]) sphere(r=r);
    }
}

module trim_below_z(z)
{
    for(i=[0:$children-1]) {
        intersection() {
            children(i);
            translate([-1000, -1000, z])
            cube([2000, 2000, 2000], false);
        }
    }
}

module trim_above_z(z)
{
    for(i=[0:$children-1]) {
        intersection() {
            children(i);
            translate([-1000, -1000, z-2000])
            cube([2000, 2000, 2000], false);
        }
    }
}

module alignedCube(position, size, alignment="ccc")
{
    ax = (len(alignment) < 1) ? "c" : alignment[0];
    ay = (len(alignment) < 2) ? "c" : alignment[1];
    az = (len(alignment) < 3) ? "c" : alignment[2];
    sx = (ax == "l" || ax == "L" || ax == "-") ? -1 :
        ((ax == "r" || ax == "R" || ax == "+") ? +1 : 0);
    sy = (ay == "b" || ay == "B" || ay == "-") ? -1 :
        ((ay == "t" || ay == "T" || ay == "+") ? +1 : 0);
    sz = (az == "r" || az == "R" || az == "-") ? -1 :
        ((az == "f" || az == "F" || az == "+") ? +1 : 0);
    translate([size[0]/2*sx, size[1]/2*sy, size[2]/2*sz])
    translate(position)
    cube(size, center=true);
}

module alignedCylinder(position, r, h, alignment="zc")
{
    axis = (len(alignment) < 1) ? "z" : alignment[0];
    ax   = (len(alignment) < 2) ? "c" : alignment[1];
    s    = (ax == "-") ?  -1 : ((ax == "+") ? 1 : 0);
    if (axis == "x" || axis == "X") {
        translate(position)
        translate([s*h/2, 0, 0])
        rotate([0, 90, 0])
        cylinder(r=r, h=h, center=true);
    } else if (axis == "y" || axis == "Y") {
        translate(position)
        translate([0, s*h/2, 0])
        rotate([90, 0, 0])
        cylinder(r=r, h=h, center=true);
    } else if (axis == "z" || axis == "Z") {
        translate(position)
        translate([0, 0, s*h/2])
        cylinder(r=r, h=h, center=true);
    }
}

module alignedCone(position, r1, r2, h, alignment="zc")
{
    axis = (len(alignment) < 1) ? "z" : alignment[0];
    ax   = (len(alignment) < 2) ? "c" : alignment[1];
    s    = (ax == "-") ?  -1 : ((ax == "+") ? 1 : 0);
    if (axis == "x" || axis == "X") {
        translate(position)
        translate([s*h/2, 0, 0])
        rotate([0, -90, 0])
        cylinder(r1=r1, r2=r2, h=h, center=true);
    } else if (axis == "y" || axis == "Y") {
        translate(position)
        translate([0, s*h/2, 0])
        rotate([-90, 0, 0])
        cylinder(r1=r1, r2=r2, h=h, center=true);
    } else if (axis == "z" || axis == "Z") {
        translate(position)
        translate([0, 0, s*h/2])
        cylinder(r1=r1, r2=r2, h=h, center=true);
    }
}

module chainedHull()
{
  for(i=[0:$children-2])
    hull() // here we do it another way (without a secondary loop)
    {
      children(i);
      children(i+1);
    }
}

// Extrude multiple stacked cones
// cs=[[d1,h1],[d2,h2]...]
module multicone(cs)
{
  for(i=[0:len(cs)-2])
    hull() {
        translate([0,0,cs[i][1]])
			cylinder(d=cs[i][0],h=0.00001);
        translate([0,0,cs[i+1][1]])
			cylinder(d=cs[i+1][0],h=0.00001);
    }
}

//alignedCylinder([0, 0, 0], 10, 30, "zc");
//alignedCube([0, 0, 0], [10, 20, 30], "+++");
//multicone([[5,0],[10,5],[5,10]]);
