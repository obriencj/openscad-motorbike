

use <utils/copies.scad>;
use <utils/shapes.scad>;



module tail_light_bracket() {

}


function license_points(license_w, mount_w) =
     [[-license_w/2, 0, 6],
      [-mount_w/2, 0, 12],
      [mount_w/2, 0, 12],
      [license_w/2, 0, 6],
      [mount_w/2, 0, 12],
      [-mount_w/2, 0, 12]];


module license_bracket(license_w=155, mount_w=50, thick=2, brim=3, $fn=100) {

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


license_bracket();


// The end.
