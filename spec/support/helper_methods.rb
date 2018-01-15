def rate_show(star = 3)
  star = all('div#user-rating i')[star - 1]
  star.click
end

def user_star_rating_score
  find('#user-rating')['data-rating']
end
