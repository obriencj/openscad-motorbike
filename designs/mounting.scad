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
			 translate([stubs_r - stub_l, -stub_w / 2]) {
			      square([stub_l, stub_w]);
			 };
		    };
	       };
	  };
     };
}


module gt250_gauge_bottom($fn=100) {

     // the thickness of the thin parts inside the cups
     thin_thick = 2.1;

     // the thickness of the rest of the base
     base_thick = 4;

     // the height of the mounting barrels
     height = 16;

     // total height of the part, base plus pin and cup height
     total_height = height + base_thick;

     // total space between the centers of the mounting pins
     pin_distance = 90;

     // distance on Y axis to shift the gauge cups (measured from the
     // mounting pins)
     cup_offset = 48;

     // how thick the cup walls should be
     cup_wall_thick = 2;

     // interior radius of the gauge cups. Diameter of the DCC
     // mini-gauge is 61mm, so add a little bit of space
     cup_inner_r = 62 / 2;
     cup_outer_r = cup_inner_r + cup_wall_thick;

     ignition_hole_r = 20;
     ignition_r = ignition_hole_r + cup_wall_thick;
     ignition_offset = 4;

     pin_spacing = 12;

     base_poly = [
	  [0, ignition_offset, ignition_r],
	  [-pin_distance / 2, 0, pin_spacing],
	  [-pin_distance / 2, cup_offset, cup_outer_r],
	  [0, cup_offset, -((pin_distance / 2) - cup_outer_r)],
	  [pin_distance / 2, cup_offset, cup_outer_r],
	  [pin_distance / 2, 0, pin_spacing],
	  ];

     tall_poly = [
	  [0, ignition_offset, ignition_r],
	  // [-(ignition_r + 10), (cup_offset - cup_outer_r) - 10, -10],
	  [-pin_distance / 2, 0, -pin_spacing],
	  [-pin_distance / 2, cup_offset, cup_outer_r],
	  [0, cup_offset, -((pin_distance / 2) - cup_outer_r)],
	  [pin_distance / 2, cup_offset, cup_outer_r],
	  // [(ignition_r + 10), (cup_offset - cup_outer_r) - 10, -10],
	  [pin_distance / 2, 0, -pin_spacing],
	  ];

     difference() {
	  union() {
	       rounded_polygon(base_poly, thick=base_thick, $fn=$fn);
	       translate([0, 0, base_thick]) {
		    rounded_polygon(tall_poly, thick=height, $fn=$fn);
	       };
	  };

	  copy_translate(x=-pin_distance) {
	       // subtract the interior cup volume
	       translate([pin_distance / 2, cup_offset, thin_thick]) {
		    render() {
			 translate([0, 0, 4]) {
			      cylinder(total_height, r=cup_inner_r);
			 };
			 cylinder(4, cup_inner_r - 4, cup_inner_r);
		    };
	       };

	       // subtract the holes from the bottom of the cup
	       translate([pin_distance / 2, 0, 0]) {
		    v_bracket_holes(y_hole_space=cup_offset,
				    thick=base_thick,
				    bottom_hole_r=3);
	       };
	  };

	  // hole for the ignition
	  translate([0, ignition_offset, -0.5]) {
	       cylinder(total_height + 1, r=ignition_hole_r);
	  };

	  // decoration on bottom of cups
	  copy_translate(x=-pin_distance) {
	       translate([pin_distance / 2, cup_offset - 4, 0]) {
		    rotate_extrude(angle=180) {
			 translate([cup_outer_r + 6, 0, 0]) {
			      circle(5, $fn=4);
			 };
		    };
	       };
	  };
     };

     copy_translate(x=-pin_distance) {
	  translate([pin_distance / 2, 0, base_thick]) {
	       // the mounting barrels
	       barrel(4, height, 3);

	       // the stubs inside the gauge cups
	       translate([0, cup_offset, thin_thick - base_thick]) {
		    stubs(cup_inner_r);
	       };

	       // decoration on top of cups
	       translate([0, cup_offset, height]) {
		    intersection() {
			 barrel(cup_outer_r, 4, cup_inner_r);
			 cylinder(5, cup_outer_r, cup_outer_r - 1);
		    };
	       };
	  };
     };

     // the ignition cutout re-inserted into the hole
     translate([0, ignition_offset, base_thick]) {
	  translate([0, 0, height - gt250_crosscut_height()]) {
	       gt250_ignition_crosscut_i(ignition_r);
	  };
     };
}


module gt250_gauge_top($fn=100) {

     thin_thick = 2.1;
     base_thick = 5;

     cup_wall_thick = 2;

     pin_distance = 90;
     pin_spacing = 12;

     ignition_hole_r = 20;
     ignition_r = ignition_hole_r + cup_wall_thick;
     ignition_offset = 4;

     keycap_ir = 25 / 2;
     keycap_or = 32 / 2;

     difference() {
	  linear_extrude(base_thick) {
	       hull() {
		    translate([0, ignition_offset]) {
			 circle(r=ignition_r);
		    };
		    copy_translate(x=-pin_distance) {
			 translate([pin_distance / 2, 0]) {
			      circle(r=pin_spacing);
			 };
		    };
	       };
	  };

	  // holes
	  translate([0, 0, -0.5]) {
	       linear_extrude(base_thick + 1) {
		    translate([0, ignition_offset]) {
			 circle(r=keycap_ir);
		    };
		    copy_translate(x=-pin_distance) {
			 translate([pin_distance / 2, 0]) {
			      circle(r=3);
			 };
		    };
	       };
	  };

	  // insets
	  translate([0, 0, thin_thick]) {
	       linear_extrude(base_thick) {
		    translate([0, ignition_offset]) {
			 circle(r=keycap_or);
		    };
		    copy_translate(x=-pin_distance) {
			 translate([pin_distance / 2, 0]) {
			      circle(r=7);
			 };
		    };
	       };
	  };
     };

     translate([0, ignition_offset, base_thick]) {
	  barrel(ignition_r, 1, keycap_or);
     };

     copy_translate(x=-pin_distance) {
	  translate([pin_distance / 2, 0, base_thick]) {
	       barrel(pin_spacing, 1, 7);
	  };
     };
}


gt250_gauge_bottom();
translate([0, -50, 0]) gt250_gauge_top();


// The end.
