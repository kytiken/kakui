# coding: utf-8

require './kakui.rb'

describe Kakui, "#join" do
  it "各位のメンバーがmemberに保存できる" do
    kakui = Kakui.new
    kakui.join("hoge")
    kakui.members.should == ["hoge"]
  end

  it "各位のメンバーがmemberに2人保存できる" do
    kakui = Kakui.new
    kakui.join("hoge")
    kakui.join("fuga")
    kakui.members.should == ["hoge", "fuga"]
  end
end

describe Kakui, "#destination" do
  it "各位にリプライを飛ばす宛先の文字列が返される" do
    kakui = Kakui.new
    kakui.join("hoge")
    kakui.join("fuga")
    kakui.destination.should == "@hoge @fuga "
  end
end

describe Kakui, "#scan" do
  it "ツイートに＠各位 join命令が入っていたらmemberに追加する" do
    kakui = Kakui.new
    kakui.scan("@各位 join hoge")
    kakui.members.should == ["hoge"]
  end

  it "ツイートに@各位 remove命令が入っていたらmemberを削除する" do
    kakui = Kakui.new
    kakui.join('hoge')
    kakui.join('fuga')
    kakui.join('piyo')
    kakui.scan('@各位 remove piyo')
    kakui.members.should == ['hoge', 'fuga']
  end
end

describe Kakui, "#descern" do
  it "Kakuiに対する命令かどうかを判別して@各位 joinが入っていたらjoinという文字列を返す" do
    kakui = Kakui.new
    kakui.tweet = "@各位 join hoge"
    kakui.descern.should == "join"
  end

  it "Kakuiに対する命令かどうかを判別して@各位が入っていなかったらfalseを返す" do
    kakui = Kakui.new
    kakui.tweet = "hogefugapiyo"
    kakui.descern.should == nil
  end

  it "Kakuiに対する命令かどうか判別して@皆様 joinがはいっていたらjoinという文字列を返す" do
    kakui = Kakui.new
    Kakui::COMMANDS << /@皆様/
    kakui.tweet = "@皆様 join hoge"
    kakui.descern.should == "join"
  end

  it "Kakuiに対する命令かどうかを判別して@皆様が入っていなかったらfalseを返す" do
    kakui = Kakui.new
    kakui.tweet = "hogefugapiyo"
    kakui.descern.should == nil
  end

  it "Kakuiに対する命令かどうか判別して@もえかしゅくらすた joinがはいっていたらjoinという文字列を返す" do
    kakui = Kakui.new
    Kakui::COMMANDS << /@もえかしゅくらすた/
    kakui.tweet = "@もえかしゅくらすた join hoge"
    kakui.descern.should == "join"
  end


end

describe Kakui, "#create_reply_text" do
  it "Kakuiのメンバーにリプライの文面を作る" do
    kakui = Kakui.new
    kakui.join('hoge')
    kakui.create_reply_text("ツイートの文面").should == "@hoge ツイートの文面"
  end
end

describe Kakui, "#reply" do
  it "Kakuiのメンバーにリプライを送る" do
    kakui = Kakui.new
    kakui.join("kytiken")
  end
end

describe Kakui, "#remove" do
  it "Kakuiのメンバーを削除する" do
    kakui = Kakui.new
    kakui.join('hoge')
    kakui.join('fuga')
    kakui.join('piyo')
    kakui.remove('piyo')
    kakui.members.should == ['hoge', 'fuga']
  end
end

describe Kakui, "#create_show_members_text" do
  it "Kakuiのメンバーを一覧する" do
    kakui = Kakui.new
    kakui.join('hoge')
    kakui.join('fuga')
    kakui.join('piyo')
    kakui.create_show_members_text.should == "members = [hoge, fuga, piyo]"
  end
end

