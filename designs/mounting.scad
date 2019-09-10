/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


use <common.scad>;
use <vbracket.scad>;



module mount_pin(pin_r, pin_h, thread_r, thread_h, $fn=100) {
     color("Silver") {
	  cylinder(pin_h, r=pin_r);
     };
     color("Gold") {
	  translate([0, 0, pin_h]) {
	       cylinder(thread_h, r=thread_r);
	  };
     };
}


module mount_barrel(barrel_r, barrel_h, bore_r, $fn=100) {
     linear_extrude(barrel_h) {
	  difference() {
	       circle(r=barrel_r);
	       circle(r=bore_r);
	  };
     };
}



module stubs(stubs_r) {
     stub_h = 6.5;
     stub_l = 8;
     stub_w = 4;
     stub_degree = 30;

     linear_extrude(stub_h) {
	  duplicate(rotate_v=[0, 0, 180]) {
	       duplicate(rotate_v=[0, 0, stub_degree * 2]) {
		    rotate([0, 0, -stub_degree]) {
			 translate([stubs_r - stub_l, -stub_w / 2, 0]) {
			      square([stub_l, stub_w]);
			 };
		    };
	       };
	  };
     };
}


module gt250_mounting($fn=100) {

     thick = 2.1;
     b_thick = 5;

     pin_distance = 90;
     y_hole_space = 50;

     ignition_hole_r = 20;
     ignition_offset = ignition_hole_r - 8;

     outer_circle_r = (17 + y_hole_space) / 2;
     inner_circle_r = (12 + y_hole_space) / 2;

     difference() {
	  // the general overall shape, extruded double-thick
	  linear_extrude(b_thick) {
	       duplicate(move_v=[-pin_distance, 0, 0]) {
		    translate([pin_distance / 2, 0, 0]) {
			 hull() {
			      circle(r=10);
			      translate([0, y_hole_space, 0]) {
				   circle(r=outer_circle_r);
			      };
			 };
		    };
	       };

	       translate([-pin_distance/2, -10, 0]) {
		    square([pin_distance, y_hole_space + 10]);
	       };
	  };

	  // then we subtract some of it to make it thinner for the
	  // gauge mounting segments, since space is limited there.
	  translate([0, 0, thick]) {
	       linear_extrude(thick + 1) {
		    duplicate(move_v=[-pin_distance, 0, 0]) {
			 translate([pin_distance / 2, 0, 0]) {
			      translate([0, y_hole_space, 0]) {
				   circle(r=inner_circle_r);
			      };
			 };
		    };
	       };
	  };

	  // subtract a cyl between the gauges to produce a nice
	  // rounded look
	  translate([0, y_hole_space, -0.5]) {
	       cylinder(b_thick + 1,
			r=(pin_distance / 2)-outer_circle_r);
	  };

	  // subtract a cyl for the bottom of the ignition key
	  translate([0, ignition_offset, -0.5]) {
	       cylinder(b_thick + 1, r=ignition_hole_r);
	  };

	  // subtract a hole for the mounting barrels
	  duplicate(move_v=[-pin_distance, 0, 0]) {
	       translate([pin_distance / 2, 0, 0]) {
		    v_bracket_holes(thick=b_thick, bottom_hole_r=3);
	       };
	  };
     };

     duplicate(move_v=[-pin_distance, 0, 0]) {
	  translate([pin_distance / 2, 0, b_thick]) {

	       // the mounting barrels for the tripple tree
	       mount_barrel(4, 15, 3);

	       // the cups for the gauges
	       translate([0, y_hole_space, 0]) {
		    mount_barrel(outer_circle_r, 15, inner_circle_r);

		    translate([0, 0, thick - b_thick]) {
			 stubs(inner_circle_r);
		    };
	       };
	  };
     };

     // the ignition barrel
     translate([0, ignition_offset, b_thick]) {
	  mount_barrel(ignition_hole_r + 2, 15, ignition_hole_r);
	  duplicate(rotate_v=[0, 0, 90]) {
	       rotate([0, 0, 45]) {
		    translate([ignition_hole_r + 1, 0, 0]) {
			 translate([0, -1, 0]) cube([5, 2, 15]);
		    };
	       };
	  };
     };
}


gt250_mounting();


// The end.
