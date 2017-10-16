class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully deleted.' }
      format.json { head :no_content }

    end

  end


  def histogram
    @getEnrolledStudents = Enrollment.all
    @getGrades = []
    @getStudents = []

    @getEnrolledStudents.each do |getPercentage|
      @getGrades << getPercentage.percentage
      @getStudents << getPercentage.student.student_id
    end

    @gradeCutoffs = []
    @gradeLetters = ['Max', 'A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F']

    @gradeCutoffs << params[:Max]
    @gradeCutoffs << params[:Ap]
    @gradeCutoffs << params[:A]
    @gradeCutoffs << params[:Am]
    @gradeCutoffs << params[:Bp]
    @gradeCutoffs << params[:B]
    @gradeCutoffs << params[:Bm]
    @gradeCutoffs << params[:Cp]
    @gradeCutoffs << params[:C]
    @gradeCutoffs << params[:Cm]
    @gradeCutoffs << params[:D]
    @gradeCutoffs << params[:F]

    puts "hello hello hello"
    puts params[:Ap]
    puts params[:A]
    puts params[:Am]
    puts @gradeLetters.at(0)
    puts @gradeLetters.at(1)
    puts @gradeLetters.at(2)
    puts @gradeLetters.at(3)

    puts @gradeCutoffs.at(0)
    puts @gradeCutoffs.at(1)
    puts @gradeCutoffs.at(2)

    

    # for i in 0..@getGrades.size
    #   for j in 0..@gradeCutoffs.size
    #     if(@getGrades.at(i) < @gradeCutoffs.at(j) && @getGrades.at(i) >= @gradeCutoffs.at(j+1))
    #       grade =  @gradeLetters.at(j+1)
    #       Enrollment.where(student_id: @getStudents.at(i)).update(lettergrade: grade)
    #       break
    #     end
    #   end
    # end

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:course_id, :description)
    end
  end
