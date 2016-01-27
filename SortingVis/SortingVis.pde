//************************************************************
//
// Author: Nicolas Bertagnolli
//
// Description:  This code performs and visualizes selection
// sort in processing.
// 
// Additional questions:
// 1) Can you sort the color array so that the colors stick 
//    with the original rectangle they are assigned to?
// 2) Can you devise a way to sort other shapes?  Circles?
// 3) Challenge: Can you use processing documentation to figure
//    out how to sort the pixels in an image?  Hint: Look up 
//    the following functions and datatypes: PImage,
//    loadPixels(), updatePixels(), loadImage(), image(,,)
//    red(), blue(), green(), pixels[]
//    
//************************************************************






// Import a library so that we can delay the amount of time for sorting
import processing.serial.*;

// Declare an array to hold rectangle heights
int[] rectangles;
// A dummy array so that we can store the original version of our random array of heights
int[] rectangles_permanent;
// Array to hold random colors for each of the rectangles
color[] rectangle_colors;

// The current best minimum used for selection sort
int current_minimum = 100000000;
// The position of the minimum element
int min_position = -1;
// The current position of the smallest element to be filled with the next minimum
int current_position= 0;
// Holds the element at current position while the next minimum is copied to that address
int holder;
// holds the color of the current rectangle
color color_holder;
// How many rectangles to sort
int num_rectangles = 10;

// Setup the processing sketch
void setup() {
  // 600 pixels wide by 400 pixels tall
  size(600, 400);
  // creates a grey background 255 is white 0 is black
  background(200);
  // Allocate memory for 10 elements
  rectangles = new int[num_rectangles];
  // Same as above
  rectangle_colors = new int[num_rectangles];
  // same as above
  rectangles_permanent = new int[num_rectangles];
  
  // Step through all elements in the array and 
  for (int i = 0; i < rectangles.length; i++) {
    // Place a random integer between 10 and 600 into the array of rectangle heights
    rectangles[i] = round(random(10, 600));
    // Put a random rgb color into the array of rectangle colors
    rectangle_colors[i] = color(round(random(0, 255)),round(random(0, 255)),round(random(0, 255)));
  }
  // Copy the rectangles array into the rectangles_permanent array for looping
  arrayCopy(rectangles, rectangles_permanent);
}


void draw() {
  // Redraw the background if you remove this then the rectangles will be drawn on each other
  background(200);
  // Call the display rectangles function to draw the whole array of rectangle heights
  displayRectangles(rectangles, rectangle_colors);
  // delay the next opperations by 500ms to make the sorting more visible
  delay(500);
  // reset the minimum to a very large number
  current_minimum = 100000000;
  // Reset the minimum position to a nonsensical array location
  min_position = -1;
  // Check to make sure that the current position does not exceed the size of the array
  if (current_position < rectangles.length) {
  // inner loop of selection sort step through the remaining unsorted elements
  for (int i = current_position; i < rectangles.length; i++) {
    // if the rectangle height is less than the current minimum then we want to store it and remember where it is
    if (rectangles[i] < current_minimum) {
       current_minimum = rectangles[i];
       min_position = i;
    }
  }
  
  // Now that we have our smallest element we need to swap the unsorted element and the next smallest element
  // Store the unsorted element at current_position
  holder = rectangles[current_position];
  // Move the next smallest element into the appropriate spot
  rectangles[current_position] = rectangles[min_position];
  // Complete the swap
  rectangles[min_position] = holder;
  
  // Increment the current_position
  current_position += 1;
  // Make the graphic loop back to the unsorted array
  } else {
    // wait one second
   delay(1000);
   // copy our original unsorted array into the sorted one
   arrayCopy(rectangles_permanent, rectangles);
   // reset the current position
   current_position = 0;
  }

  
}

/**
* This method displays an array of rectangle heights and colors 
* @param rectangles: an integer array representing the heights of the rectangles
* @param colors: an array of colors maped to each of the rectangles
* returns  nothing
*/
void displayRectangles(int[] rectangles, color[] colors) {
   rectMode(CENTER);
   int rect_sep = width / rectangles.length ;
   for (int i = 0; i < rectangles.length; i++) {
     rect(rect_sep*i + 25/2, height - 10, 25, rectangles[i]);
     fill(colors[i]);
   }
}