class NotebooksController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user!, {only: [:show, :edit, :update, :destroy]}

	def ensure_correct_user!
		@notebook = Notebook.find(params[:id])
		if @notebook.user != current_user
			redirect_to root_path
		end
	end

	def index
		user = current_user
		@notebook = Notebook.new
		@notebooks = Notebook.where(user_id: user.id).page(params[:page]).reverse_order
	end

	def show
		@notebook = Notebook.find(params[:id])
	end

	def create
		@notebook = Notebook.new(notebook_params)
		@notebook.user_id = current_user.id
		if @notebook.save
			redirect_to notebooks_path
		else
			user = current_user
			@notebooks = Notebook.where(user_id: user.id).page(params[:page]).reverse_order
			render 'notebooks/index'
		end
	end

	def edit
		@notebook = Notebook.find(params[:id])
	end

	def update
		@notebook = Notebook.find(params[:id])
		if @notebook.update(notebook_params)
			redirect_to notebooks_path
		else
			render 'notebooks/edit'
		end
	end

	def destroy
		notebook = Notebook.find(params[:id])
		notebook.destroy
		redirect_to notebooks_path
	end

	private
	def notebook_params
		params.require(:notebook).permit(:title)
	end
end
