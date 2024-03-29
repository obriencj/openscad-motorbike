/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


use <../utils/copies.scad>;


function gt250_crosscut_inner_r() = 9.5;
function gt250_crosscut_outer_r() = 15;
function gt250_crosscut_height() = 9;
function gt250_crosscut_thick() = 8;

function gt250_crosscut_angle() = 5;


module crosscut(height, crossthick, inner_r, outer_r, $fn=100) {
     linear_extrude(height) {
	  intersection() {
	       union() {
		    circle(inner_r);
		    copy_rotate(z=90) {
			 square([outer_r * 2, crossthick], center=true);
		    };
	       };
	       circle(outer_r);
	  };
     };
}


module gt250_ignition_crosscut() {
     rotate([0, 0, gt250_crosscut_angle()]) {
	  crosscut(gt250_crosscut_height(),
		   gt250_crosscut_thick(),
		   gt250_crosscut_inner_r(),
		   gt250_crosscut_outer_r());
     };
}


module gt250_ignition_crosscut_i(r=16, $fn=100) {
     difference() {
	  cylinder(gt250_crosscut_height(), r=r);
	  translate([0, 0, -0.5]) {
	       rotate([0, 0, gt250_crosscut_angle()]) {

		    // because the ignition slides in from below, the
		    // crosscut cannot be smaller than the threaded
		    // segment that would be above it
		    crosscut(gt250_crosscut_height() + 1,
			     gt250_crosscut_thick() + 0.25,
			     12.25,
			     gt250_crosscut_outer_r() + 0.25);
	       };
	  };
     };
}


module gt250_ignition(with_cap=false, $fn=100) {

     color("Silver") {
	  cylinder(19, r=(35.1 / 2));
	  translate([0, 0, 19]) {
	       gt250_ignition_crosscut();
	  };
     };

     translate([0, 0, 19 + gt250_crosscut_height()]) {
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
	  translate([0, 0, 19 + gt250_crosscut_height() + 2]) {
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


gt250_ignition(true);


// The end.
