# coding: utf-8
# Problem 04

p [*100..999].map{ |n|
  [*100..999].map{ |m| n*m }.map{ |val| val.to_s.reverse == val.to_s ? val : 0 }.max
}.max
