class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

  # GET /todos or /todos.json
  def index
    @todos = case params[:filter]
    when "completed"
               Todo.where(completed: true)
    when "pending"
               Todo.where(completed: false)
    else
               Todo.all
    end

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "todos_list",
          partial: "todos/todos_list"
        )
      end
    end
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: "Todo was successfully created." }
        format.turbo_stream {
          render turbo_stream: turbo_stream.append("todos", partial: "todos/todo_row", locals: { todo: @todo })
        }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_todo_form",
            partial: "todos/new_todo_form",
            locals: { todo: @todo }
          )
        }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: "Todo was successfully updated." }
        format.turbo_stream {
          if params[:filter].blank?
            render turbo_stream: turbo_stream.replace(
              @todo,
              partial: "todos/todo_row",
              locals: { todo: @todo }
            )
          else
            render turbo_stream: turbo_stream.remove(@todo)
          end
        }
        format.json { render :show, status: :ok, location: @todo }
      else
        @todo.reload
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            @todo,
            partial: "todos/todo_row",
            locals: { todo: @todo, show_form: true }
          )
        }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to todos_path, status: :see_other, notice: "Todo was successfully destroyed." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@todo) }
      format.json { head :no_content }
    end
  end

  private
    def set_todo
      @todo = Todo.find(params.expect(:id))
    end

    def todo_params
      params.expect(todo: [ :title, :completed ])
    end
end
