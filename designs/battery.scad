/*
  author: Christopher O'Brien  <obriencj@gmail.com>
  license: GPL v.3
*/


use <common.scad>;


module AG_401() {
     // rough dimensions of an antigravity 401 (4-cell) battery
     // Length = 110mm, Width = 32mm, Height = 95mm

     bat_length = 110;
     bat_width = 32;
     bat_height = 95;

     // the AG-401 has a top portion which is slightly smaller than
     // the main body of the battery.

     // todo: these numbers are just estimates
     cap_delta = 2;
     cap_height = 10;

     color("Gray") {
	  translate([bat_length / -2, bat_width / -2, 0]) {
	       cube([bat_length, bat_width, bat_height - cap_height]);

	       translate([cap_delta, cap_delta, bat_height - cap_height]) {
		    cube([bat_length - (cap_delta * 2),
			  bat_width - (cap_delta * 2),
			  cap_height]);
	       };
	  };
     };

     // todo: the terminal positions and sizes are estimations
     color("Gold") {
	  copy_rotate(z=180) {
	       translate([40, 0, bat_height])
		    cylinder(2, 8, 7);
	  };
     };
}


AG_401();


// The end.
