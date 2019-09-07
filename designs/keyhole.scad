/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


use <common.scad>;


module crosscut(height, crossthick, inner_r, outer_r, $fn=100) {
     linear_extrude(height) {
	  intersection() {
	       union() {
		    circle(r=inner_r);
		    duplicate(rotate_v=[0, 0, 90]) {
			 square([outer_r * 2, crossthick], center=true);
		    };
	       };
	       circle(r=outer_r);
	  };
     };
}


module ignition(with_cap=false, $fn=100) {

     color("Silver") {
	  cylinder(19, r=(35.1 / 2));
	  translate([0, 0, 19]) {
	       crosscut(10.1, 8, inner_r=9, outer_r=15);
	  };
     };
     translate([0, 0, 19+10.1]) {
	  difference() {
	       union() {
		    color("Silver") {
			 cylinder(2, r=12);
		    };
		    color("Gold") {
			 translate([0, 0, 2]) {
			      cylinder(9, r=12);
			 }
		    };
		    color("Silver") {
			 translate([0, 0, 11]) {
			      cylinder(0.5, r=8);
			 };
		    };
	       };
	       rotate([0, 0, 45]) {
		    translate([0, 0, 1.5]) {
			 cube([2.4, 9.65, 21], center=true);
		    };
	       };
	  };
     };

     rotate([0, 0, 45]) {
	  translate([0, -((36 / 2) - 4), -16]) {
	       color("Silver") {
		    cylinder(26, r=5);
	       };
	  };
     };

     if (with_cap) {
	  translate([0, 0, 19 + 10.1 + 2]) {
	       color("Gray") {
		    linear_extrude(8.25) {
			 difference() {
			      circle(r=(31 / 2));
			      circle(r=(23 / 2));
			 };
		    };
	       };
	  };
     };
}


ignition(true);


// The end.
