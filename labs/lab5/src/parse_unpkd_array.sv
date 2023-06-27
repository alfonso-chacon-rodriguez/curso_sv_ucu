module parse_unpkd_array;
  	// The following two representations of fixed arrays are the same
  	// myFIFO and urFIFO have 8 locations where each location can hold an integer value
  	// 0,1 | 0,2 | 0,3 | ... | 0,7
  	int   myFIFO  [0:7];
  	int   urFIFO  [8];

   	// Multi-dimensional arrays
  	// 0,0 | 0,1 | 0,2
  	// 1,0 | 1,1 | 1,2
  	int   myArray  [2][3];

  	initial begin
      myFIFO[5] = 32'hface_cafe;     // Assign value to location 5 in 1D array
      myArray [1][1] = 7;	         // Assign to location 1,1 in 2D array

      // Iterate through each element in the array
      foreach (myFIFO[i])
        $display ("myFIFO[%0d] = 0x%0h", i, myFIFO[i]);

      // Iterate through each element in the multidimensional array
      foreach (myArray[i])
        foreach (myArray[i][j])
          $display ("myArray[%0d][%0d] = %0d", i, j, myArray[i][j]);

	end
endmodule