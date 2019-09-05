"""
Clean up user-entered phone numbers so that they can be sent SMS messages.

The North American Numbering Plan (NANP) is a telephone numbering system used by many countries in North America like the United States, Canada or Bermuda. All NANP-countries share the same international country code: 1.

Your task is to clean up differently formatted telephone numbers by removing punctuation and the country code (1) if present.

For example, the inputs

- +1 (613)-995-0253
- 613-995-0253
- 1 613 995 0253
- 613.995.0253

should all produce the output

6139950253

If a phone number is invalid, then the function `clean` should return nothing.

The format is usually represented as

(NXX)-NXX-XXXX

where N is any digit from 2 through 9 and X is any digit from 0 through 9.


This exercise tests your understanding of:

- function definition
- Control flow
- Pattern metching
- Strings
- (depending on how you write it, recursiveness and regex)

Useful things to look at in order to complete this exercise:
- if, elseif, else
- replace()
- character indexing in strings
- join()
- `.!=`
"""

using Test

#ADD BELOW ANY ADDITIONAL PACKAGES YOU MIGHT NEED

#### DEFINING THE TEST NUMBERS
const expected_number = "2234567890"
const valid_10digit_num = (
        "(223) 456-7890",
        "223.456.7890",
        "223 456  7890   ",
)
const valid_11digit_num = (
        "12234567890",
        "  1 223 456 7890 ",
        "+1 (223) 456-7890",
)
const invalid_num = (
        "1223456789",
        "22234567890",
        "321234567890",
        "223-abc-7890",
        "223-@:!-7890",
        "(023) 456-7890",
        "(123) 456-7890",
        "(223) 056-7890",
        "(223) 156-7890",
)

### WRITE YOUR CODE BELOW
# TO HELP YOU WE RECOMMEND WRITING A HELPER FUNCTION `replace_punct` which


function replace_punct(phone_number::String)::String 
    return replace(phone_number, r"([\s()\-\+\.])" =>"" )
end

function remove_punct(phone_number::String)
    replace_punct(phone_number)
end


# the idea is to filter out special characters or anything that is not a digit. Occursin should have worked faster but then the regex would get complex.

function has_weird_chars(phone_number::String)::Bool
    r = replace(phone_number, r"([+\d])" =>"")
    if length(r) == 0
        return false 
    else 
        return true 
    end
end 

function is_valid_n(n::Char)::Bool
    #if the char is not convertible, the parse function will throw the natural Argument error. 
    integer = parse(Int,n)
    if (integer >= 2 && integer <= 9) return true else return false end
end

function is_valid_length(n::String)::Bool
    if (length(n) == 10) return true else return false end  
end 

#could have gone with the manipulation of the original var phone_number only instead of allocating more memory to a new var pn 

function clean(phone_number::String)
    pn = remove_punct(phone_number) #phone_number with removed punctuation
    if pn[1] == '1'
        pn = pn[2:end] #remove the leading (1)
    end
    if (has_weird_chars(pn) == true)
        return nothing  
    elseif (is_valid_n(pn[1]) == false || is_valid_n(pn[4]) == false  )
        return nothing  
    elseif (is_valid_length(pn) == false)
        return nothing 
    else 
        return pn
    end 
end

### TESTING YOUR CODE
@testset "clean 10-digit number" begin
    @testset "$number" for number in valid_10digit_num
        @test clean(number) == expected_number
    end
end

@testset "clean 11-digit number starting with 1" begin
    @testset "$number" for number in valid_11digit_num
        @test clean(number) == expected_number
    end
end

@testset "detect invalid number" begin
    @testset "$number" for number in invalid_num
        @test clean(number) == nothing
    end
end
