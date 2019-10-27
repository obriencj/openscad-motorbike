

use <utils/copies.scad>;
use <utils/shapes.scad>;


function us_mc_license_hole_width() = 146;


function license_points(license_w, mount_w) =
     [[-license_w/2, 0, 6],
      [-mount_w/2, 0, 12],
      [mount_w/2, 0, 12],
      [license_w/2, 0, 6],
      [mount_w/2, 0, 12],
      [-mount_w/2, 0, 12]];


module _license_bracket(license_w, mount_w, thick=2, brim=3, $fn=100) {

     points = license_points(license_w, mount_w);

     linear_extrude(thick) {
	  difference() {
	       rounded_polygon(points);

	       copy_translate(x=-license_w) {
		    translate([license_w/2, 0]) {
			 circle(3);
		    };
	       };
	       copy_translate(x=-mount_w) {
		    translate([mount_w/2, 0]) {
			 circle(4);
		    };
	       };
	  };
     };

     translate([0, 0, thick]) {
	  rounded_hollow_poly(points, brim, brim);

	  copy_translate(x=-license_w) {
	       translate([license_w/2, 0]) {
		    barrel(6, brim, 3);
	       };
	  };
	  copy_translate(x=-mount_w) {
	       translate([mount_w/2, 0]) {
		    barrel(12, brim, 9);
	       };
	  };
     };
}


module us_license_bracket(mounting_width) {
     _license_bracket(us_mc_license_hole_width(), mounting_width);
}


us_license_bracket(40);


// The end.
