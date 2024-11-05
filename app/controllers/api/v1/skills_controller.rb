module Api
  module V1
    class SkillsController < ApplicationController
      def index
        @skills = Skill.all
      end

      def show
        @skill = Skill.find(params[:id])
      end

      def create
        @skill = Skill.new(skill_params)

        if @skill.save
          render :show, status: :created
        else
          render "api/v1/errors", locals: { errors: @skill.errors }, status: :unprocessable_entity
        end
      end

      def update
        @skill = Skill.find(params[:id])
        if @skill.update(skill_params)
          render :show, status: :ok
        else
          render "api/v1/errors", locals: { errors: @skill.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @skill = Skill.find(params[:id])

        if @skill.destroy
          head :no_content
        else
          render "api/v1/errors", locals: { errors: @skill.errors }, status: :unprocessable_entity
        end
      end

      private

      def skill_params
        params.require(:skill).permit(:name, :slug)
      end
    end
  end
end 