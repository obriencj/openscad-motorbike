/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/



module v_bracket_holes(thick=2.1,
		       gauge_hole_r=3.25, x_hole_space=45,
		       bottom_hole_r=5, y_hole_space=50,
		       cable_hole_r=14,
		       $fn=50) {

     b_offset = x_hole_space / 2;

     translate([0, 0, -0.5]) {
	  if(gauge_hole_r > 0) {
	       translate([b_offset, y_hole_space, 0]) {
		    cylinder(thick+1, r=gauge_hole_r);
	       };
	       translate([-b_offset, y_hole_space, 0]) {
		    cylinder(thick+1, r=gauge_hole_r);
	       };
	  };
	  if(bottom_hole_r > 0) {
	       cylinder(thick+1, r=bottom_hole_r);
	  };

	  // these holes aren't visibile normally, as the V bracket
	  // subtracts the area they'd be in.
	  hull() {
	       small_r = (44 - 26) / 2;
	       translate([0, 30, 0]) {
		    cylinder(thick+1, r=small_r);
	       };

	       translate([0, y_hole_space, 0]) {
		    cylinder(thick+1, r=cable_hole_r);
	       };
	  };
     };
}



module simplified_bracket(thick=2.1,
			  gauge_hole_r=3.25, x_hole_space=45,
			  bottom_hole_r=5, y_hole_space=50,
			  cable_hole_r=14,
			  $fn=50) {

     difference() {
	  linear_extrude(thick) {
	       hull() {
		    circle(r=20/2);
		    translate([0, y_hole_space, 0]) {
			 circle(r=(15 + y_hole_space) / 2);
		    };
	       };
	  };

	  v_bracket_holes(thick, gauge_hole_r, x_hole_space,
			  bottom_hole_r, y_hole_space, cable_hole_r,
			  $fn=$fn);
     };
}


module v_bracket(thick=2.1,
		 gauge_hole_r=3.25, x_hole_space=45,
		 bottom_hole_r=5, y_hole_space=50,
		 $fn=50) {
     /*
       this is the V-shaped bracket that comes with the 2.5" DCC Mini
       Gauges by default.
     */

     // todo: let's make this less of a mess.

     // distance between bolts, split in half since we'll duplicate
     b_offset = x_hole_space / 2;

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

	  // the interior rounded V of the bracket
	  translate([0, 0, -0.5]) {
	       hull() {
		    small_r = (44 - 26) / 2;
		    translate([0, 30, 0]) {
			 cylinder(thick+1, r=small_r);
		    };
		    translate([0, 58, 0]) {
			 cylinder(thick+1, r=32/2);
		    };
	       };
	  };

	  v_bracket_holes(thick,
			  gauge_hole_r, x_hole_space,
			  bottom_hole_r, y_hole_space,
			  $fn=$fn);
     };
}


v_bracket();


// The end.
