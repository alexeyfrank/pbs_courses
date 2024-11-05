module Api
  module V1
    class CoursesController < ApplicationController
      def index
        @courses = Course.includes(:author, :skills).all
      end

      def show
        @course = Course.includes(:author, :skills).find(params[:id])
      end

      def create
        @course = Ba::Courses::Create.new.call(create_course_params)

        if @course.errors.any?
          render_unprocessable_entity(@course.errors)
        else
          render :show, status: :created
        end
      end

      def update
        @course = Ba::Courses::Update.new(id: params[:id]).call(update_course_params)

        if @course.errors.any?
          render_unprocessable_entity(@course.errors)
        else
          render :show, status: :ok
        end
      end

      def destroy
        @course = Course.find(params[:id])

        if @course.destroy
          head :no_content
        else
          render_unprocessable_entity(@course.errors)
        end
      end

      def remove_author
        @course = Ba::Courses::RemoveAuthor.new(id: params[:id]).call

        if @course.errors.any?
          render_unprocessable_entity(@course.errors)
        else
          render :show, status: :ok
        end
      end

      private

      def create_course_params
        params.require(:course).permit(:title, :description, :author_id, skill_slugs: [])
      end

      def update_course_params
        params.require(:course).permit(:id, :title, :description, skill_slugs: [])
      end
    end
  end
end
