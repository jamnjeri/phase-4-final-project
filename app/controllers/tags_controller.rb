class TagsController < ApplicationController
    before_action :authorize, only: [:create]


    # Handle ActiveRecord Not Found exception
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # Handle ActiveRecord Unprocessable Entity -  raised when a record fails to save or validate in the database.
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
 
 
    # GET /tags
    def index
        tags = Tag.all
        render json: tags, status: :ok
    end
 
 
    # GET /tags/:id
    def show
        tag = find_tag
        render json: tag, status: :ok
    end
 
 
    # POST /tags
    def create
        tag = Tag.create(tag_params)
   
        if tag.valid?
            render json: tag, status: :accepted
        else
            render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
        end
    end
 
 
    private
 
 
    def find_tag
        Tag.find(params[:id])
    end
 
 
    def tag_params
        params.permit(:name)
    end
 
 
    def render_not_found_response
        render json: { error: "Tag not found" }, status: :not_found
    end
 
 
    def render_unprocessable_entity_response(exception)
        render json: { error: exception.message }, status: :unprocessable_entity
    end
 
end
