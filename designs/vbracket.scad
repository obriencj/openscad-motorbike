/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


module v_bracket(thick=2.1, $fn=50) {
     /*
       this is the V-shaped bracket that comes with the 2.5" DCC Mini
       Gauges by default.
     */

     // todo: let's make this less of a mess.

     y_hole_space = 51;

     b_offset = 45 / 2;

     translate([0, -y_hole_space, 0])
     difference() {
	  union() {
	       hull() {
		    cylinder(thick, r=20/2);
		    translate([b_offset, y_hole_space, 0]) {
			 cylinder(thick, r=15/2);
		    };
	       };
	       hull() {
		    cylinder(thick, r=20/2);
		    translate([-b_offset, y_hole_space, 0]) {
			 cylinder(thick, r=15/2);
		    };
	       };
	  };

	  translate([0, 0, -0.5]) {
	       translate([b_offset, y_hole_space, 0]) {
		    cylinder(thick+1, r=6.5/2);
	       };
	       translate([-b_offset, y_hole_space, 0]) {
		    cylinder(thick+1, r=6.5/2);
	       };
	       cylinder(thick+1, r=10/2);


	       hull() {
		    small_r = (44 - 26) / 2;
		    translate([0, 29, 0]) {
			 cylinder(thick+1, r=small_r);
		    };
		    translate([0, 58, 0]) {
			 cylinder(thick+1, r=32/2);
		    };
	       };
	  };
     };
}


v_bracket();


// The end.
