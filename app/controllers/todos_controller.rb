class TodosController < ApplicationController
  before_action :set_todo, only: %i[ update destroy ]

  # GET /todos
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

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path, notice: "Todo was successfully created." }
        format.turbo_stream {
          render turbo_stream: turbo_stream.append("todos", partial: "todos/todo_row", locals: { todo: @todo })
        }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_todo_form",
            partial: "todos/new_todo_form",
            locals: { todo: @todo }
          )
        }
      end
    end
  end

  # PATCH/PUT /todos/1
  def update
    respond_to do |format|
      if @todo.update(todo_params)
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
      else
        @todo.reload
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            @todo,
            partial: "todos/todo_row",
            locals: { todo: @todo, show_form: true }
          )
        }
      end
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@todo) }
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
