use <common.scad>;
use <ignition.scad>;



module cutout_sample($fn=100) {

     ignition_offset = 0;
     ignition_hole_r = 20;
     b_thick = 2;

     base_w = 50;
     base_h = 44;

     crosscut_height = 9;

     difference() {
	  linear_extrude(b_thick) {
	       hull() {
		    circle(r=ignition_hole_r + 2);
		    translate([-(ignition_hole_r + 2),
			       -(ignition_hole_r + 2), 0]) {
			 square([(ignition_hole_r + 2) * 2,
				 (ignition_hole_r + 2) / 2]);
		    };
	       };
	  };
	  translate([0, 0, -0.5]) {
	       cylinder(b_thick + 1, r=ignition_hole_r);
	  };
     };

     // the ignition barrel
     translate([0, ignition_offset, b_thick]) {
	  translate([0, 0, 15 - crosscut_height]) {
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
