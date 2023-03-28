class RecipesController < ApplicationController
    before_action :verify_auth

    def index
        recipes = user.recipes.all
        app_response(message: 'success', data: todos)
    end

    def create
        recipe = user.recipes.create(recipe_params)
        if recipe.valid?
            app_response(status: :created, data: recipe)
        else
            app_response(status: :unprocessable_entity, data: recipe.errors, message: 'failed')
        end
    end

    def update
        recipe = user.recipes.find(params[:id]).update(recipe_params)
        if recipe
            app_response(data: { info: 'updated recipe successfully' })
        else
            app_response(message: 'failed', data: { info: 'something went wrong. could not update recipe' }, status: :unprocessable_entity)
        end
    end

    def destroy
        user.recipes.find(params[:id]).destroy
        app_response(message: 'success', data: { info: 'deleted recipe successfully' }, status: 204)
    end

    private

    def recipe_params
        params.permit(:title, :description, :ingredients, :img_url)
    end
end
