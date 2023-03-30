class RecipesController < ApplicationController
    before_action :verify_auth

    def index
        recipes = user.recipes.all
        app_response(message: 'success', data: todos)
    end

    # POST /recipes
    def create
        recipe = user.recipes.create(recipe_params)
        if recipe.valid?
            app_response(status: :created, data: recipe)
        else
            app_response(status: :unprocessable_entity, data: recipe.errors, message: 'failed')
        end
    end

    # PATCH/PUT /recipes/:id
    def update
        recipe = user.find_recipe.update(recipe_params)
        if recipe
            app_response(data: { info: 'updated recipe successfully' })
        else
            app_response(message: 'failed', data: { info: 'something went wrong. could not update recipe' }, status: :unprocessable_entity)
        end
    end

    # DELETE /recipes/:id
    def destroy
        user.find_recipe.destroy
        app_response(message: 'success', data: { info: 'deleted recipe successfully' }, status: 204)
    end

    private

    def find_recipe
        Recipe.find(params[:id])
    end

    def recipe_params
        params.permit(:title, :description, :ingredients, :img_url)
    end
end
