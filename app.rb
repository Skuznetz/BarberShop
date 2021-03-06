require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
@db = SQLite3::Database.new 'barbershop.db'
@db.execute 'CREATE TABLE IF NOT EXISTS 
"Users"
(
"id" INTEGER PRIMARY KEY AUTOINCREMENT,
"username" TEXT,
"phone" TEXT,
"datestamp" TEXT,
"barber" TEXT,
"color" TEXT
);'

end
get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	@error = "samething wrong!!!"
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do

@username = params[:username]  #вводим переменные для записи
@phone = params[:phone]
@datetime = params[:datetime]  
@barber = params[:barber]
@color =params[:color]

#хэш
hh = {:username =>'Введите имя',
	:phone=>'Введите телефон',
	:datetime =>'Введите дату и время'}

# для каждой пары ключ-значение	
#hh.each do |key, value|
   
   # если параметр пуст
   #if params[key] == ''
   	# переменной error присвоить value из хэша hh
   	# (а value из хэша hh -это сообщение об ошибке)
   	# т.е. переменной error присвоить сообщение о ошибке
   	#@error = hh[key]
 @error = hh.select {|key,_| params[key] == ""} .values.join(", ")
  if @error!=''  
    return erb :visit
    #end
   end
  # db = get_db
  db = SQLite3::Database.new 'barbershop.db'
  db.results_as_hash = true
    db.execute 'insert into
        Users
        (
            username,
            phone,
            datestamp,
            barber,
            color
        )
        values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]


	erb "OK,username is #{@username},#{@phone},#{@datetime},#{@barber},#{@color}"
end
get '/showusers' do
  erb "Hello World"
end
# def get_db
#    return SQLite3::Database.new 'barbershop.db'
#   end