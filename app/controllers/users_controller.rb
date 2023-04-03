class UsersController < ApplicationController
    before_action :authorize, only: [:show, :update, :destroy]


    # Handle ActiveRecord Not Found exception
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
 
    # Handle ActiveRecord Unprocessable Entity - raised when a record fails to save or validate in the database.
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
 
 
    # GET /Users
    def index
        users = User.all
        render json: users, status: :ok
    end
   
    # GET /users/:id
    def show
        user = User.find(session[:user_id])
        render json: user, status: :ok
    end
 
 
    # POST /users - for registration & login
    def create
        user = User.create(user_params)
        # Save user in session's hash
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end

    end
 
 
    # PATCH/PUT /users/:id - for updating user info
    def update
        user = find_user
        if user
            user.update(user_params)
            render json: user, status: :accepted
        else
            render json: { error: "User not found "}, status: :not_found
        end
    end
 
 
    # Delete /users/:id - to delete a user
    def destroy
        user = find_user
        if user
            user.destroy
            head :no_content  
        else
            render json: { error: "User not found"}, status: :not_found
        end
    end
       
    private
   
    def find_user
        User.find(params[:id])
    end
 
 
    def user_params
        params.permit(:name, :username, :email, :password, :gender)
    end
 
 
    def render_not_found_response
        render json: { error: "User not found" }, status: :not_found
    end
 
 
    def render_unprocessable_entity_response(exception)
        render json: { error: exception.message }, status: :unprocessable_entity
    end
 
end
