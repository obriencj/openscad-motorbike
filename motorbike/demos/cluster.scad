

use <../utils/copies.scad>;
use <../models/minigauge.scad>;
use <../models/ignition.scad>;
use <../gauge_cluster.scad>;


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
	  gt250_ignition(true);
     };

     copy_translate(-pin_distance) {
	  translate([pin_distance / 2, cup_offset, 8]) {
	       mini_gauge();
	  };
     };
}


gt250_mini_cluster();


// The end.
