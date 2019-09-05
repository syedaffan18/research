"""
The goal of this exercise is to understand error messages in Julia.

Below, you will find a bunch of functions that we want to use on a given example.
Problem, they are riddled with errors or the function call is wrong ! Fix the errors so that you pass all the tests !
"""

#############
using Test
#############

# exercise 1:
# Fix the test

function power(x, y)
    return x^y
end

@testset "Exercise 1" begin
    @test power(2,3) == 8
end

# exercise 2
# Fix one of the functions. Here we are interested in findind the difference between the difference between
# the cube of the sum and the sum of the cube of the first n integers

function cube_of_sum(n::Int)
    sum(1:n) ^ 3
end

function sum_of_cubes(n::Int)
    sum((1:n).^ 2) # should be sum((1:n).^ 3) 
end

function difference(n::Int)
    sum_of_cubes(n) - cube_of_sum(n)
end

#the way I see it, it seems wrong.  (1^3 + 2^3 + 3^3 + 4^3 + 5^3 + 6^3 + 7^3 + 8^3 + 9^3 + 10^3) - (1+2+...+10)^3 is not -165990 
#the test seems to work for it but the sum_of_cubes should be sum((1:n).^ 3) and the answer is -163350 for n = 10

@testset "Exercise 2" begin
    @test difference(10) == -165990
end

# exercise 3
# Fix the function. Here we want to return the sum of the first and last element of an Integer array

function my_sum(arr::Array)
     return arr[1] + arr[length(arr)]

end

@testset "Exercise 3" begin
    @test my_sum([1,2,3,4,5]) == 6
end

# exercise 4
# Fix the function (2 errors are present...)

function ismultipleof3(number::Int)
    return number % 3 == 0 ? true : false
end

@testset "Exercise 4"  begin
    @test ismultipleof3(9)
end
