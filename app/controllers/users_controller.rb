class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @offset, @limit = api_offset_and_limit
    @users =  User.find :all,
                        :limit  =>  @limit,
                        :offset =>  @offset
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => {:success => true, :Data => @users}, :callback => params[:callback] }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  # http://wgo-ror.herokuapp.com/users/authenticate?userName=ramy&password=123456
  def authenticate     
     usr = params[:userName]
     pwd = params[:password]
     @getUser = User.find(:all, :conditions => "userName = '#{usr}' AND password = '#{pwd}'")     
     if (@getUser!=[])       
       respond_to do |format| 
        format.html { render :json => {:success => true, :Data => @getUser}, :callback => params[:callback] }
        format.json { render :json => {:success => true, :Data => @getUser}, :callback => params[:callback] }
       end
     else           
      respond_to do |format|
        format.html { render :json => {:success => false, :Data => @getUser}, :callback => params[:callback] }
        format.json { render :json => {:success => false, :Data => @getUser}, :callback => params[:callback] }
      end 
     end
  end
  
  # http://wgo-ror.herokuapp.com/users/insertUser?userName=yrkapil&password=123456&email=yrkapil@gmail.com
  def insertUser
    query = "INSERT INTO users (userName,password,email,created_at,updated_at) VALUES (params[:userName], params[:password], params[:email],current_date,current_date)"
    ActiveRecord::Base.connection.execute(query); 
  end
  
  # http://wgo-ror.herokuapp.com/users/saveUser?id=1&userName=yrkapil&password=123456&email=yrkapil@gmail.com  
  def saveUser
     @user = User.find(params[:id])              
     @user.update_attributes(:userName => params[:userName], :password => params[:password], :email => params[:email] )
  end 
  
  
end
