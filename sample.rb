require 'minitest/autorun'
require 'test_helper'
require 'property'

def double(i)
  i * 2
end

properties 'double' do
  data { rand(1_000_000) }
  
  property 'is the same as adding twice' do |data|
    assert_equal data + data, double(data)
  end
end

def sort(array)
  array.sort
end

properties 'sort' do
  data do
    (rand(10) - 1).times.map { rand(1000) }
  end
  
  property 'has the same size' do |data|
    assert_equal data.size, sort(data).size
  end
  
  property 'idempotency' do |data|
    assert_equal sort(data), sort(sort(data))
  end
  
  property 'is a permutation of the original list' do |data|
    assert_permutation data, sort(data)
  end
  
  property 'is ordered' do |data|
    assert_ordered sort(data)
  end
end
