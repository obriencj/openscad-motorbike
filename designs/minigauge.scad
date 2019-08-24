/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


use <common.scad>;



module v_bracket(thick=2.1) {
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


module gauge_plug(height=23, thread=13) {
     stub = height - thread;

     color("Gold") {
	  cylinder(thread, r=12/2);
     }

     color("Silver") {
	  translate([0, 0, thread]) {
	       cylinder(stub-2, r=15/2);
	  };
	  translate([0, 0, thread + stub - 2]) {
	       cylinder(2, r=20/2);
	  };
     };
}


module mini_gauge(bracket=false, $fn=50) {
     rim_r = 67 / 2;
     rim_h = 10.5;

     body_r = 61 / 2;
     body_h = 53.5 - rim_h;

     // mounting bolt, overall
     bolt_r = 6 / 2;
     bolt_l = 13;
     bolt_offset = 45 / 2;

     // bump, washer, and nut
     bolt_lost_r = 9 / 2;
     bolt_lost_l = 6;

     face_r = rim_r - 4.5;
     face_inset = 3;

     plug_height = 26;
     plug_thread = 13;

     difference() {
	  union() {
	       color("Silver") {

		    // primary housing
		    cylinder(body_h, r=body_r);

		    // top rim
		    translate([0, 0, body_h]) {
			 cylinder(rim_h, r=rim_r);
		    }
	       };

	       // bolts
	       duplicate(rotate_v=[0, 0, 180]) {
		    // the overall length of the bolt from the
		    // body
		    color("Gold") {
			 translate([bolt_offset, 0, -bolt_l]) {
			      cylinder(bolt_l, r=bolt_r);
			 };
		    };

		    color("Silver") {
			 // the body has a raised area the bolts
			 // protrude from, plus a mandatory nut and
			 // washer to hold the internals in place. The
			 // remainder is for mounting the unit.
			 translate([bolt_offset, 0, -bolt_lost_l]) {
			      cylinder(bolt_lost_l, r=bolt_lost_r, $fn=6);
			 };
		    };
	       };

	       translate([0, 0, -plug_height]) {
		    gauge_plug(height=plug_height, thread=plug_thread);
	       };
	  };

	  // subtract for inset face
	  translate([0, 0, (body_h + rim_h) - face_inset]) {
	       cylinder(face_inset + 1, r=face_r);
	  };
     };

     if (bracket == true) {
	  bracket_thick = 2.1;
	  bracket_down = bolt_lost_l + bracket_thick;

	  translate([0, 0, -bracket_down]) {
	       color("Silver") v_bracket(thick=bracket_thick);
	  };

	  bracket_bolt_l = 4.8;
	  bracket_bolt_down = bracket_down + bracket_bolt_l;

	  duplicate(rotate_v=[0, 0, 180]) {
	       color("Silver") {
		    translate([bolt_offset, 0, -bracket_bolt_down]) {
			 cylinder(bracket_bolt_l, r=bolt_lost_r, $fn=6);
		    };
	       };
	  };
     };
}


mini_gauge(bracket=true);


// The end.
