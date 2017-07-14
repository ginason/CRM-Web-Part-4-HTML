require 'sinatra'
require_relative 'contact'
# require 'byebug'

get '/' do
  redirect to('/contact')
end

get '/contact' do
  @contacts = Contact.all
  erb :contact
end

get '/contact/new' do
  erb :new_contact
end

get '/contact/:id' do
  @contacts = Contact.find_by(id: params[:id].to_i)
  if @contacts
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

post '/contact/new' do
  Contact.create(
  first_name: params[:first_name],
  last_name:  params[:last_name],
  email:      params[:email],
  note:       params[:note]
  )
  redirect to('/contact')
end

get '/contact/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
  erb :edit_contact
  else
  raise Sinatra::NotFound
  end
end

put '/contact/:id' do
# byebug
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )
    redirect to('/contact')
  else
    raise Sinatra::NotFound
  end
end

delete '/contact/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contact')
  else
    raise Sinatra::NotFound
  end
end
