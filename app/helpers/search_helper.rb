module SearchHelper

  def ommit_last_three_characters(post_code)
    post_code[0...3]
  end
end