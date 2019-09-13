
use <common.scad>;
use <minigauge.scad>;
use <ignition.scad>;
use <mounting.scad>;



module gt250_mini_cluster() {

     total_thick = 20;
     cup_offset = 48;
     ignition_offset = 4;
     pin_distance = 90;

     gt250_gauge_bottom();

     #translate([0, 0, total_thick]) {
	  gt250_gauge_top();
     };

     translate([0, ignition_offset, -8]) {
	  gt250_ignition(false);
     };

     duplicate(move_v=[-pin_distance, 0, 0]) {
	  translate([pin_distance / 2, cup_offset, 8]) {
	       mini_gauge();
	  };
     };
}


gt250_mini_cluster();


// The end.
