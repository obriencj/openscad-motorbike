

use <../utils/shapes.scad>;


points =
     [[-6, 10, 5],
      [0, 10, 0],
      [6, 10, 5],
      [0, 0, 2]];


linear_extrude(2) {
     difference() {
	  rounded_polygon(points);
	  rounded_polygon(adj_rounded_poly(points, -2));
     };
};


// The end.
