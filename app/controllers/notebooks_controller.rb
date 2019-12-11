class NotebooksController < ApplicationController
	def index
		user = current_user
		@notebook = Notebook.new
		@notebooks = Notebook.where(user_id: user.id)
	end

	def show
		@notebook = Notebook.find(params[:id])
	end

	def create
		notebook = Notebook.new(notebook_params)
        notebook.user_id = current_user.id
		notebook.save
		redirect_to notebooks_path
	end

	def edit
		@notebook = Notebook.find(params[:id])
	end

	def update
		notebook = Notebook.find(params[:id])
		notebook.update(rename_notebook_params)
		redirect_to notebooks_path
	end

	def destroy
		notebook = Notebook.find(params[:id])
		notebook.destroy
		redirect_to notebooks_path
	end

	private
    def notebook_params
    	params.require(:notebook).permit(:title, :user_id)
    end

    def rename_notebook_params
    	params.require(:notebook).permit(:title)
    end
end
