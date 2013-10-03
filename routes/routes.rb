get '/' do
  prepare_to_check_solution
  generate_new_puzzle_if_necessary
  @current_solution = session[:current_solution]
  @solution = session[:solution]
  @puzzle = session[:puzzle]      
<<<<<<< HEAD
  # if request.xhr?
  #   content_type :json
  #   {
  #     :current_solution => @current_solution,
  #     :solution => @solution,
  #     :puzzle => @puzzle
  #   }.to_json
  # else
  #   haml :index
  # end
  haml :index
=======
  erb :index
>>>>>>> parent of 3feac96... converted views to haml and started capybara testing
end

post "/" do
  cells = box_order_to_row_order(params["cell"])
  session[:current_solution] = cells.map{|value| value.to_i }.join

  if params[:clicked_button] == "check_solution"
      session[:check_solution] = true
      redirect to("/")

  elsif params[:clicked_button] == "save"
    session[:check_solution] = false
    redirect to("/")

  elsif params[:clicked_button] == "check_finished_solution"
    session[:check_solution] = false
    redirect to ('/solution')
    
  end
end

get '/solution' do
  if session[:current_solution] == nil
    redirect to("/")  
  else
  	@current_solution = session[:solution]
    @solution = session[:solution]
    @puzzle = session[:puzzle]
<<<<<<< HEAD
    # erb :index
    haml :index
  end
end

get '/new_game' do
  if params["newGame"] == "easy"
    session[:current_solution] = nil
    generate_new_puzzle_if_necessary
    redirect to("/")
  elsif params["newGame"] == "hard"
    session[:current_solution] = nil
    generate_hard_puzzle
    redirect to("/")
  else
=======
    erb :index
>>>>>>> parent of 3feac96... converted views to haml and started capybara testing
  end
end

get '/easy_puzzle' do
  session[:current_solution] = nil
  generate_new_puzzle_if_necessary
  redirect to("/")
end

get '/hard_puzzle' do
  session[:current_solution] = nil
  generate_hard_puzzle
  redirect to("/")
end

get '/clear_solution' do
  @current_solution = session[:current_solution] || session[:puzzle]
  @solution = session[:solution]
  @puzzle = session[:puzzle]
<<<<<<< HEAD
  # erb :index
  redirect to("/")
=======
  erb :index
>>>>>>> parent of 3feac96... converted views to haml and started capybara testing
end

get '/restart' do
  session[:current_solution] = session[:puzzle]
  redirect to("/")
end