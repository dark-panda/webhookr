
require 'test_helper'
require 'webhookr/ostruct_utils'
require 'ostruct'

class OstructUtilsTest < ActiveSupport::TestCase
  def setup
    @hash = { a: { b: { c: 1 } }, a1: [ { b1: { c1: 1 } } ] }
    @converted = Webhookr::OstructUtils.to_ostruct(@hash)
  end

  test "should be an OpenStruct" do
    assert(@converted.is_a?(OpenStruct))
  end

  test "should have a nested OpenStruct" do
    assert(@converted.a.is_a?(OpenStruct))
  end

  test "should have a nested nested OpenStruct" do
    assert(@converted.a.b.is_a?(OpenStruct))
  end

  test "should have a nested nested nested value of 1" do
    assert(@converted.a.b.c == 1)
  end

  test "should replace a nested hash in an array" do
    assert(@converted.a1.first.b1.c1 == 1)
  end
end
