"""
This exercise is to test basic function definition, basic array operation as well
as math functions.
"""

####
using Test
### ADD PACKAGES YOU MIGHT NEED

## Write a function to cube an array element wise

function cube(arr::Array)
    return arr.^3
end

## Write a function that evalutes for an array sum(array)+prod(array)
## You are not allowed to use the sum and prod functions !

function add(arr::Array)
    length(arr) == 1 ? arr[1] : return (arr[1] + add(arr[2:end]))
end

function multiply(arr::Array)
    length(arr) == 1 ? arr[1] : return (arr[1] * multiply(arr[2:end]))
end


function sum_prod(arr::Array)
    return add(arr) + multiply(arr) 
end

## Write a function that returns the number of odd and even integers in an array
## as a tuple (odd_count, even_count)

function odd_even_count(arr::Array)
    odd_count = 0
    even_count= 0
    for i in 1:length(arr)
        isodd(arr[i]) == true ? odd_count = odd_count + 1 : even_count = even_count + 1
    end
    return (odd_count,even_count)
end
## Write a function to average an Array (without using mean)

function my_mean(arr::Array)
    return add(arr)/length(arr)
end

## Write a function to return the minimum of an array (without using minimum())
## can be optimized

function my_minimum(arr::Array)
    min = arr[1]
    for i in 2:length(arr)
        if min > arr[i]
            min = arr[i]
        end
    end
    return min
end

## Write a function to return the argmax of an array (hint: enumerate())
##technically I could have returned "findmax(arr)[2]" because the question doesn't stop me from using findmax but let's do it through enumerate! 


function my_argmaximum(arr::Array)
    max = arr[1]
    ind = 1
    for (index, value) in enumerate(arr)
        if value > max
            max = value 
            ind = index
        end
    end 
    return ind
 end


## Write a function to reverse an array (hint: eltype())


function reverse_helper(arr::Array, start, finish)
    if start >= finish 
        return arr
    end
    temp = arr[start]
    arr[start] = arr[finish]
    arr[finish] = temp  
    return reverse_helper(arr,start+1,finish-1)
    end 

#using @btime (or @benchmark for all details) we can see that my_reverse performs better than built-in reverse (which allocates memory to a copy 'apparently')

function my_reverse(arr::Array)
    reverse_helper(arr,1,length(arr))
end

### TESTING YOUR RESULTS
const arr = [5, 6, 3, 2, 7, 1]

@testset "Cube" begin
    @test prod(cube(arr) .== [125,216,27,8,343,1])
end

@testset "SumProd" begin
    @test sum_prod(arr) == 1284
end

@testset "Counts" begin
    @test odd_even_count(arr) == (4,2)
end

@testset "Mean" begin
    @test my_mean(arr) == 4
end

@testset "Min and argMax" begin
    @test my_minimum(arr) == 1
    @test my_argmaximum(arr) == 5
end

@testset "Reverse" begin
    @test prod(my_reverse(arr) .== [1, 7, 2, 3, 6, 5])
end
