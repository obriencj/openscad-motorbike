use <common.scad>;
use <ignition.scad>;



module cutout_sample() {

     ignition_offset = 0;
     ignition_hole_r = 20;
     b_thick = 2;

     difference() {
	  translate([-30, -25, 0]) {
	       cube([60, 50, b_thick]);
	  };
	  translate([0, 0, -0.5]) {
	       cylinder(b_thick + 1, r=ignition_hole_r);
	  };
     };

     // the ignition barrel
     translate([0, ignition_offset, b_thick]) {
	  translate([0, 0, 15 - 10.1]) {
	       gt250_ignition_crosscut_i(ignition_hole_r+2);
	  };
	  barrel(ignition_hole_r + 2, 15, ignition_hole_r);
     };

     translate([0, 0, 15 + b_thick]) {
	  barrel(ignition_hole_r, 2, 12);
     };

}


cutout_sample();


// The end.
