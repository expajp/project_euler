# coding: utf-8
# Problem 01

p [*1..999].select{ |n| n%3 * n%5 == 0 }.sum
