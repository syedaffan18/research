data BTrie a = Node a (BTrie a) (BTrie a) | Nil

--Decimal to binary
toBin::Int-> [Int]
toBin 0 = [0]
toBin n = reverse (helper n)

helper 0 = []
helper n | n `mod` 2 == 1 = 1 : helper (n `div` 2)
         | n `mod` 2 == 0 = 0 : helper (n `div` 2)


--1 Add

add:: BTrie (Maybe Int) -> Maybe Int -> Maybe Int -> BTrie (Maybe Int)
add x Nothing _ = x
add x y z = addHelp x (toBin y) z

addHelp::BTrie (Maybe Int) -> [Int] -> Maybe Int