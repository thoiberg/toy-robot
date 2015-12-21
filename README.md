# toy-robot
[![Build Status](https://travis-ci.org/thoiberg/toy-robot.svg?branch=master)](https://travis-ci.org/thoiberg/toy-robot)

This app simulates a Robot on a table, allowing the user to pass in instructions to move the robot.

## Usage Instructions

To use the application run the `toy_robot.rb' script with the DSL file as an argument

    bundle exec toy_robot.rb robot_dsl

The DSL can use the any commands on the Robot class:

    place
    move
    left
    right
    report

If the robot is not placed on the board then it cannot move or turn left or right. To place the robot call
the `place` command with the starting x and y co-ordinates and the cardinal direction it's facing (north, 
east, south, west)

    place(0, 0, :north)

An optional 4th argument can be passed in to supply a custom board to place the robot on, but by default
a board of 5x5 spaces is created.

    place(0, 0, :north, Board.new(10, 10))

The `report` method can be called at any time to display the correct position and direction the robot is facing

    place(0, 0, :north)
    report      # puts "0,0,north" to the command line

The robot can be moved forward in the direct it is facing by calling `move`. `move` can be called with 
an optional parameter indicating the number of steps to move, but the default is 1.

    place(0, 0, :north)
    move    
    report      # puts "0,1,north"
    move(3)
    report      # puts "0,4,north"

The robot can be turned either left or right using the relevant command. This does not change the position
on the board, just the direction it is facing

    place(0, 0, :north)
    left 
    left
    report      # puts "0,0,south" 

If the original starting position or any future positions are not valid co-ordinates on the board then
the robot will not be set and will not respond to any future commands until the robot is placed in a
valid location

    place(10, 10, :north, Board.new(5, 5))
    move
    move
    report      # puts "robot is not set on a board"
    place(1, 1, :north, Board.new(5, 5))
    move
    left
    report      # puts "1,2,west"

### Examples

There are examples of using the DSL in the `spec/fixtures/` directory

## Running the Test Suite

To run the test suite simply run the following command from the top level directory of the repository

    bundle exec rspec

