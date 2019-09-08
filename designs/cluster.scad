
use <common.scad>;
use <minigauge.scad>;
use <ignition.scad>;
use <mounting.scad>;



module gt250_mini_cluster() {

     gt250_mounting();

     translate([0, 12, -10]) {
	  ignition(true);
     };

     duplicate(move_v=[-90, 0, 0]) {
	  translate([45, 50, 8]) {
	       mini_gauge();
	  };
     };
}



gt250_mini_cluster();


// The end.
