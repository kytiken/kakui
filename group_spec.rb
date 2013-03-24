#coding: utf-8
require './group.rb'

describe Group, "#join" do
  it "groupのmemberが正しくjoinする" do 
    group = Group.new('各位')
    group.join('hoge')
    group.join('fuga')
    group.members.should == ['hoge','fuga']
  end
end

describe Group, "#identifier" do
  it "identifierを参照する" do
    group = Group.new("各位")
    group.identifier.should == "@各位"
  end
end

describe Group, "#delete" do
  it "メンバーを削除する" do
    group = Group.new("各位")
    group.join('hoge')
    group.join('fuga')
    group.delete('hoge')
    group.members.should == ['fuga']
  end
end
