class RecipesController < ApplicationController
    before_action :authorize, only: [:create, :update, :destroy]

    # Handle ActiveRecord Not Found exception
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # Handle ActiveRecord Unprocessable Entity - raised when a record fails to save or validate in the database.
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # GET /recipes
    def index
        recipes = Recipe.all
        render json: recipes, status: :ok
    end

    # GET /recipes/:id
    def show
        recipe = find_recipe
        render json: recipe, status: :ok
    end

    # POST /recipes
    def create
        user = find_user
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, status: :created
    end

    # PATCH/PUT /recipes/:id
    def update
        user = find_user
        recipe = find_recipe
        recipe.update!(recipe_params)
        recipe = user.find_recipe.update(recipe_params)
        render json: recipe, status: :accepted
    end

    # DELETE /recipes/:id
    def destroy
        recipe = find_recipe
        user = current_user
        recipe.destroy
        head :no_content
    end

    private

    def find_recipe
        Recipe.find(params[:id])
    end

    def find_user
        User.find(session[:user_id])
    end

    def recipe_params
        params.permit(:title, :description, :ingredients, :image_url)
    end

    def render_not_found_response
        render json: { error: "Recipe not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { error: exception.message }, status: :unprocessable_entity
    end

end
