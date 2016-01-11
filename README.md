# toy-robot
[![Build Status](https://travis-ci.org/thoiberg/toy-robot.svg?branch=master)](https://travis-ci.org/thoiberg/toy-robot)

This app simulates a Robot on a table, allowing the user to pass in instructions to move the robot.

This was written in Ruby 2.2.2, but has Travis CI builds to test:

 - Ruby 2.0.0
 - Ruby 2.1.7
 - Ruby 2.2.2

## Setup

To run this app, clone this git repository and in the top level directory, run:

    $ bundle install

To install the all the dependencies needed for execution

## Usage Instructions

To use the application run the `toy_robot.rb' script with the command file as the argument

    $ bundle exec toy_robot.rb <ROBOT_COMMANDS>

Where ROBOT_COMMANDS is the file path to a file containing valid commands. The `examples` directory has several files that can
be used as tests.

## toy-robot Commands

The command file can use the any commands on the Robot class:

    place
    move
    left
    right
    report

If the robot is not placed on the board then it cannot move or turn left or right. To place the robot call
the `place` command with the starting x and y co-ordinates and the cardinal direction it's facing (north, 
east, south, west). The robot is placed on a board 5 x 5 spaces.

    place 0,0,north

The `report` method can be called at any time to display the correct position and direction the robot is facing

    place 0,0,north
    report      # puts "0,0,north" to the command line

The robot can be moved forward in the direct it is facing by calling `move`. `move` can be called with 
an optional parameter indicating the number of steps to move, but the default is 1.

    place 0,0,north
    move    
    report      # puts "0,1,north"
    move 3
    report      # puts "0,4,north"

The robot can be turned either left or right using the relevant command. This does not change the position
on the board, just the direction it is facing

    place 0,0,north
    left 
    left
    report      # puts "0,0,south" 

If the original starting position or any future positions are not valid co-ordinates on the board then
the robot will not be set and will not respond to any future commands until the robot is placed in a
valid location

    place 10,10,north
    move
    move
    report      # puts nothing
    place 1,1,north
    move
    left
    report      # puts "1,2,west"

### Examples

There are examples of using the commands in the `spec/fixtures/` directory

## Running the Test Suite

To run the test suite simply run the following command from the top level directory of the repository

    bundle exec rspec

## License

toy-robot is licensed under the [MIT License](LICENSE)

