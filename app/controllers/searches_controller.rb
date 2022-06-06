class SearchesController < ApplicationController

  def search
    @model = params['search']['model']
    @content = params['search']['content']            #選択した検索方法howを@howに代入
    @how = params['search']['how']            #search_forの引数にインスタンス変数を定義

    @datas = search_for(@how, @model, @content)
    p @datas                                            #@datasに最終的な検索結果が入る
  end

   private

  def match(model, content)                     #def search_forで定義したメソッド
    if model == 'user'                         #modelがuserの場合の処理
      User.where(name: content)                 #whereでcontentと完全一致するnameを探します
    elsif model == 'book'
      Book.where(title: content)
    end
  end

  def forward(model, content)
    if model == 'user'
      User.where("name LIKE ?", "#{content}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{content}%")
    end
  end

  def backward(model, content)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{content}")
    end
  end

  def partical(model, content)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{content}%")
    end
  end

  def search_for(how, model, content)         #searchアクションで定義した情報が引数に入っている
    case how                                #検索方法のhowの中身がどれなのかwhenの条件分岐の中から探す処理
      when 'match'
        match(model, content)                 #検索方法の引数に(model, content)を定義している
      when 'forward'                        #例えばhowがmatchの場合は def match の処理に進む
        forward(model, content)
      when 'backward'                       #Viewで配列で名前つけてる
        backward(model, content)
      when 'partical'
        partical(model, content)
      else
    end
  end
end
