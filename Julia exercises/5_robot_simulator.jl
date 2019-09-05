"""
Write a robot simulator.

A robot factory's test facility needs a program to verify robot movements.

The robots have three possible movements:

turn right
turn left
advance
Robots are placed on a hypothetical infinite grid, facing a particular direction (north, east, south, or west) at a set of {x,y} coordinates, e.g., {3,8}, with coordinates increasing to the north and east.

The robot then receives a number of instructions, at which point the testing facility verifies the robot's new position, and in which direction it is pointing.

The letter-string "RAALAL" means:
Turn right
Advance twice
Turn left
Advance once
Turn left yet again
Say a robot starts at {7, 3} facing north. Then running this stream of instructions should leave it at {9, 4} facing west.
"""


##########

using Test

### ADD ANY OTHER Package

########

# Let me help you, let's define a direction type as an enum which limits the directions the robot can move in:
@enum DIRECTION NORTH EAST SOUTH WEST

# First let's define a Point structure with two fields x and y both Integers. We should be able to
# define a new point with Point(2,3)


#can be made mutable to change points directly instead of creating a new object in advancing 

struct Point
    x::Int64 
    y::Int64 
end

# Now let's define a Robot structure with two fields a `position` (which is a Point) and `heading` (which is a DIRECTION)
# Two things:
# 1) the robot needs to be able to move... therefore you'll need to be able to update a Robot object over and over
# 2) Let's add a smarter constructor that takes an x axis and y axis positions as argument instead of a Point

mutable struct Robot
    position::Point
    heading::DIRECTION   
end

Robot(x::Int64,y::Int64,DIRECTION) = Robot(Point(x,y),DIRECTION) #smart constructor

#Let's now define functions to allow the Robot to move and use multiple dispatch !
# To help you, we will define the following types:

#Movement is the supertype 
abstract type Movement end
struct Left <: Movement end
struct Right <: Movement end
struct Advance <: Movement end

function move!(robot::Robot, mov::Right)
    robot.heading = DIRECTION( mod((Int(robot.heading) + 1),4))
end

function move!(robot::Robot, mov::Left)
    robot.heading = DIRECTION( mod((Int(robot.heading) - 1),4))
end

function move!(robot::Robot, mov::Advance)
    if robot.heading == NORTH
         robot.position = Point(robot.position.x,robot.position.y+1)
    elseif robot.heading == EAST 
        robot.position = Point(robot.position.x+1,robot.position.y) 
    elseif robot.heading == SOUTH 
        robot.position = Point(robot.position.x,robot.position.y-1) 
    elseif robot.heading == WEST 
        robot.position = Point(robot.position.x-1,robot.position.y)  
    end
end

# Let's now create the `move!` function that makes a robot move given a sequence of
# instructions. Our robot only understands L, R and A as valid instructions. It should
# scream "I DON'T UNDERSTAND" if it recieves ckean unkown order (obviously as an error message...)

function move!(robot::Robot, instructions::String)
    for i in instructions
        if (i == 'L')
            move!(robot, Left())
        elseif (i == 'R')
            move!(robot, Right())
        elseif (i == 'A')
            move!(robot, Advance())
        else
            error("I DON'T UNDERSTAND")
        end
    end  

end


#### TESTING YOUR RESULTS


const valid_instructions = ["LAARA", "RRAAALLA"]
const invalid_instructions = "RAX"

@testset "Point" begin
    @test fieldnames(Point) == (:x, :y)
end

@testset "Robot" begin
    @test fieldnames(Robot) == (:position, :heading)
    @test typeof(Robot(1,1,NORTH)) == Robot
    @test typeof(Robot(1,1,NORTH).position) == Point
    @test Robot(1,1,NORTH).position.x == 1
    @test Robot(1,1,NORTH).position.y == 1
    @test typeof(Robot(1,1,NORTH).heading) == DIRECTION
end

const rob = Robot(0,0,NORTH)

@testset "Movement" begin
    move!(rob, Left())
    @test rob.heading == WEST
    move!(rob, Right())
    @test rob.heading == NORTH
end

const positions = [Point(-2,1), Point(-2,-1)]

@testset "Instructions" begin
    @testset "Valid Instruction: $ins" for (ins, pos) in zip(valid_instructions, positions)
        move!(rob, ins)
        @test rob.position == pos
    end

    @testset "Invalid Instruction:" begin
        try
            move!(rob, "X")
        catch e
            buf = IOBuffer()
            showerror(buf, e)
            message = String(take!(buf))
            @test message == "I DON'T UNDERSTAND"
        end
    end
end
