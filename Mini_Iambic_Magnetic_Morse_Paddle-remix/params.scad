/*
 * Remix of Mini Iambic Magnetic Morse Paddle by ok1cdj
 * https://www.thingiverse.com/thing:1796850
 *
 * Creative Commons - Attribution - Non-Commercial license
 */

$fs=0.1;

// Parameters - paddle
thickness=0.4*4;

dmr_correction=0.2;

// Describe the bearing to be used
bearing_d_outer=13+dmr_correction;
bearing_r_outer=bearing_d_outer/2;
bearing_h=5;
// Not used
// bearing_d_inner=4;
// bearing_r_inner=bearing_d_inner/2;

// Offset between the bearings on the common axle.
bearing_to_bearing_offset=0.5;
// The height of the "lip" that holds the bearing in place
t_above_bearing=1.4;

// Describe the magnet to be used
magnet_d=5+dmr_correction;
magnet_r=magnet_d/2;
magnet_h=1.8+0.1;

magnet_axis_dist=-15.5;
magnet_off_axis_dist=-(magnet_r-0.7);

// Basic paddle dimensions
fingerpiece_length=25;
paddle_height=2*(bearing_h+t_above_bearing)+bearing_to_bearing_offset;
// Hard code the thickness?
paddle_thickness=max(0.4*8,thickness);
paddle_length=56;       // TODO: Deprecate

// Distance from the bottom edge to the bottom of the paddle
// (ie, how far the paddles are above the table)
base_to_paddle=5;

// The maximum spacing of paddle ends
kent_spacing=21;
vibroplex_spacing=15;
finger_spacing=vibroplex_spacing;

// The maximum spacing of the contact points
// This must leave room for the contact arrangement
contact_spacing=5;

// Distance from bearing to contact point
// TODO: This should define the internal dimension of the paddle,
// and the fingerpiece length should define the rest
bearing_to_contact=31;

// Parameters - base
thickness_bottom=0.4*6;
thickness_bottom2=5;
thickness_bottom3=thickness_bottom2+1;

// Standard screw holes
m4hole_d=3.3;
m4hole_r=m4hole_d/2;
m4hole_l=thickness_bottom3+t_above_bearing;

m3hole_d=2.4;
m3hole_r=m3hole_d/2;
m3hole_l=5;
m3hole_h=thickness_bottom3+paddle_height/2;

// m25hole_d=1.9;
// m25hole_r=m25hole_d/2;

// pins_depth=6;
// pins_w=12.9;
// pins_h=2.7;

lt=35;
// lb=6+pins_depth;
// w0=12;
// w1=w0+2*m3hole_l;
outer_wall_t=0.37*4;

h_mounting_hole=thickness_bottom2;
pos_mounting_hole1=5.5;
pos_mounting_hole2=25.5;

// Dimensions of base
base_width=bearing_d_outer + (thickness * 2) + outer_wall_t + 2;
base_length1=bearing_to_contact + m3hole_r + thickness;
// Add some room for wiring, maybe a strain relief
base_length2=bearing_r_outer + thickness + outer_wall_t + 5;
base_radius=3;

adjuster_height=(paddle_height / 2) + base_to_paddle;
