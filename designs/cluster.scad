
use <common.scad>;
use <minigauge.scad>;
use <ignition.scad>;
use <mounting.scad>;



module gt250_mini_cluster() {

     y_hole_space = 48;

     gt250_gauge_bottom();

     translate([0, 0, 21]) {
	  gt250_gauge_top();
     };

     translate([0, 0, -7]) {
	  gt250_ignition(false);
     };

     duplicate(move_v=[-90, 0, 0]) {
	  translate([45, y_hole_space, 8]) {
	       mini_gauge();
	  };
     };
}


gt250_mini_cluster();


// The end.
