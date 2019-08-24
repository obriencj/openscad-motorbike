/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


use <common.scad>;


module mini_gauge($fn=50) {
     // super-rough initial mini-gauge. Need real measurements

     rim_r = 30;
     rim_h = 10;

     body_r = 28;
     body_h = 50;

     bolt_r = 2.5;
     bolt_l = 8;
     bolt_offset = 17;

     face_r = rim_r - 2;
     face_inset = 2;

     color("Silver") {
	  difference() {
	       union() {
		    // primary housing
		    cylinder(body_h, r=body_r);

		    // top rim
		    translate([0, 0, body_h]) {
			 cylinder(rim_h, r=rim_r);
		    }

		    // bolts
		    duplicate(rotate_v=[0, 0, 180]) {
			 translate([bolt_offset, 0, -bolt_l]) {
			      cylinder(bolt_l, r=bolt_r);
			 };
		    };
	       };

	       // subtract for inset face
	       translate([0, 0, (body_h + rim_h) - face_inset]) {
		    cylinder(face_inset + 1, r=face_r);
	       };
	  };
     };
}


mini_gauge();


// The end.
