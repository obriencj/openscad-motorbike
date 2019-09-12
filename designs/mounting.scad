/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


use <common.scad>;
use <vbracket.scad>;
use <ignition.scad>;



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


module stubs(stubs_r) {
     // these little guys go inside of the gauge cup, to provide it a
     // solid footing, rather than having it balance on just the two
     // bolt posts.

     stub_h = 6.5;
     stub_l = 8;
     stub_w = 4;
     stub_degree = 30;

     linear_extrude(stub_h) {
	  copy_rotate(z=180) {
	       copy_rotate(z=stub_degree * 2) {
		    rotate([0, 0, -stub_degree]) {
			 translate([stubs_r - stub_l, -stub_w / 2, 0]) {
			      square([stub_l, stub_w]);
			 };
		    };
	       };
	  };
     };
}


module half_circle(r, $fn=100) {
     difference() {
	  circle(r=r);
	  translate([-r, 0, 0]) {
	       square([r * 2, r]);
	  };
     };
}


module gt250_gauge_bottom($fn=100) {

     height = 16;

     thick = 2.1;
     b_thick = 5;

     total_height = height + b_thick;

     pin_distance = 90;
     y_hole_space = 48;

     ignition_hole_r = 20;
     ignition_offset = 0;

     inner_circle_r = (14 + y_hole_space) / 2;
     outer_circle_r = inner_circle_r + 2;


     // 1. start with the initial bottom
     // 2. create a major curved body
     // 3. poke various holes in it
     // 4. add the mounting barrels

     difference() {
	  union() {
	       linear_extrude(b_thick) {
		    copy_translate(x=-pin_distance) {
			 translate([pin_distance / 2, 0, 0]) {
			      hull() {
				   circle(r=10);
				   translate([0, y_hole_space, 0]) {
					circle(r=outer_circle_r);
				   };
			      };
			 };
		    };

		    // fill in some empty space between cups
		    hull() {
			 copy_translate(x=-pin_distance) {
			      translate([pin_distance / 2, 0, 0]) {
				   circle(r=10);
			      };
			 };
			 translate([0, ignition_offset, 0]) {
			      circle(r=ignition_hole_r+2);
			 };
		    };
	       };

	       linear_extrude(total_height) {
		    copy_mirror() {
			 difference() {
			      union() {
				   square([pin_distance / 2, y_hole_space]);

				   translate([pin_distance / 2, y_hole_space, 0]) {
					circle(r=outer_circle_r);
				   };

				   hull() {
					translate([pin_distance / 2, y_hole_space, 0]) {
					     half_circle(r=outer_circle_r);
					     translate([0, ignition_offset, 0]) {
						  circle(r=ignition_hole_r+2);
					     };
					};
				   };
			      };

			      translate([pin_distance / 2, 0, 0]) {
				   resize([0, (y_hole_space - outer_circle_r) * 2, 0]) {
					circle(r=(pin_distance / 2) - (ignition_hole_r + 2));
				   };
			      };
			 };
		    };
	       };
	  };

	  // then we subtract some of it to make it thinner for the
	  // gauge mounting segments, since space is limited there.
	  translate([0, 0, thick]) {
	       linear_extrude(total_height + 1) {
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
	       cylinder(total_height + 1,
			r=(pin_distance / 2)-outer_circle_r);
	  };

	  // subtract a cyl for the bottom of the ignition key
	  translate([0, ignition_offset, -0.5]) {
	       cylinder(total_height + 1, r=ignition_hole_r);
	  };

	  // subtract a hole for the mounting barrels
	  duplicate(move_v=[-pin_distance, 0, 0]) {
	       translate([pin_distance / 2, 0, 0]) {
		    v_bracket_holes(y_hole_space=y_hole_space,
				    thick=b_thick, bottom_hole_r=3);
	       };
	  };
     };

     // the mounting barrels for the tripple tree
     duplicate(move_v=[-pin_distance, 0, 0]) {
	  translate([pin_distance / 2, 0, b_thick]) {

	       // the barrel itself
	       barrel(4, height, 3);

	       // the cups for the gauges
	       translate([0, y_hole_space, thick - b_thick]) {
		    stubs(inner_circle_r);
	       };
	  };
     };

     // the ignition barrel
     translate([0, ignition_offset, b_thick]) {
	  translate([0, 0, height - gt250_crosscut_height()]) {
	       gt250_ignition_crosscut_i(ignition_hole_r+2);
	  };
	  barrel(ignition_hole_r + 2, height, ignition_hole_r);
	  copy_rotate(z=90) {
	       rotate([0, 0, 45]) {
		    translate([ignition_hole_r + 1, 0, 0]) {
			 translate([0, -1, 0]) cube([13, 2, height]);
		    };
	       };
	  };
     };
}


module gt250_gauge_top($fn=100) {

     thick = 2.2;
     b_thick = 5;

     pin_distance = 90;

     ignition_hole_r = 20;
     ignition_offset = 0;

     difference() {
	  linear_extrude(b_thick) {
	       difference() {
		    hull() {
			 circle(r=ignition_hole_r + 2);
			 copy_translate(x=-pin_distance) {
			      translate([pin_distance / 2, 0, 0]) {
				   circle(r=10);
			      };
			 };
		    };
		    circle(r=13);
		    copy_translate(x=-pin_distance) {
			 translate([pin_distance / 2, 0, 0]) {
			      circle(r=3);
			 };
		    };
	       };
	  };

	  translate([0, 0, thick]) {
	       linear_extrude(b_thick) {
		    circle(r=32 /2);
		    copy_translate(x=-pin_distance) {
			 translate([pin_distance / 2, 0, 0]) {
			      circle(r=8);
			 };
		    };
	       };
	  };
     };
}


module gt250_gauge_prototype_3($fn=100) {

     height = 16;

     thick = 2.1;
     b_thick = 5;

     pin_distance = 90;
     y_hole_space = 48;

     ignition_hole_r = 20;
     ignition_offset = 0;

     inner_circle_r = (14 + y_hole_space) / 2;
     outer_circle_r = inner_circle_r + 2;

     difference() {
	  // the general overall shape, extruded double-thick
	  linear_extrude(b_thick) {
	       copy_translate(x=-pin_distance) {
		    translate([pin_distance / 2, 0, 0]) {
			 hull() {
			      circle(r=10);
			      translate([0, y_hole_space, 0]) {
				   circle(r=outer_circle_r);
			      };
			 };
		    };
	       };

	       // fill in some empty space between cups
	       hull() {
		    translate([-pin_distance/2, -10, 0]) {
			 square([pin_distance, y_hole_space + 10]);
		    };
		    copy_translate(x=-pin_distance) {
			 translate([pin_distance / 2, 0, 0]) {
			      circle(r=10);
			 };
		    };
		    translate([0, ignition_offset, 0]) {
			 circle(r=ignition_hole_r+2);
		    };
	       }
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
		    v_bracket_holes(y_hole_space=y_hole_space,
				    thick=b_thick, bottom_hole_r=3);
	       };
	  };
     };

     duplicate(move_v=[-pin_distance, 0, 0]) {
	  translate([pin_distance / 2, 0, b_thick]) {

	       // the mounting barrels for the tripple tree
	       barrel(4, height, 3);

	       // the cups for the gauges
	       translate([0, y_hole_space, 0]) {
		    barrel(outer_circle_r, height, inner_circle_r);

		    translate([0, 0, thick - b_thick]) {
			 stubs(inner_circle_r);
		    };
	       };
	  };
     };

     // the ignition barrel
     translate([0, ignition_offset, b_thick]) {
	  translate([0, 0, height - gt250_crosscut_height()]) {
	       gt250_ignition_crosscut_i(ignition_hole_r+2);
	  };
	  barrel(ignition_hole_r + 2, height, ignition_hole_r);
	  copy_rotate(z=90) {
	       rotate([0, 0, 45]) {
		    translate([ignition_hole_r + 1, 0, 0]) {
			 translate([0, -1, 0]) cube([13, 2, height]);
		    };
	       };
	  };
     };
}


gt250_gauge_bottom();
translate([0, -50, 0]) gt250_gauge_top();


// The end.
