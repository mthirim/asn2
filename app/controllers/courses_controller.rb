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
    render "courses/histogram"
  end 

  def updateLetterGrades
    @getEnrolledStudents = Enrollment.all
    @getGrades = []
    getStudents = []

    @getEnrolledStudents.each do |getPercentage|
      @getGrades << getPercentage.percentage
      getStudents << getPercentage.id
    end

    ids = ['Max','Ap','A','Am','Bp','B','Bm','Cp','C','Cm','D','F']
    gradeCutoffs = []


    gradeCutoffs << params[:Max].to_f
    gradeCutoffs << params[:Ap].to_f
    gradeCutoffs << params[:A].to_f
    gradeCutoffs << params[:Am].to_f
    gradeCutoffs << params[:Bp].to_f
    gradeCutoffs << params[:B].to_f
    gradeCutoffs << params[:Bm].to_f
    gradeCutoffs << params[:Cp].to_f
    gradeCutoffs << params[:C].to_f
    gradeCutoffs << params[:Cm].to_f
    gradeCutoffs << params[:D].to_f
    gradeCutoffs << params[:F].to_f

    validateInput (gradeCutoffs)
    Enrollment.all.each do |current|
      setGrade(gradeCutoffs, current)
    end
  end

  def validateInput(gradesLowEnd)
    counter = 0
    gradesLowEnd.each do |grades|
      if grades == 0
        counter+= 1
      end
    end
    if counter > 0
      render "courses/histogram"
   end
 end

 def setGrade(cutoff,  curr)
  gradeLetters = ['Max', 'A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F']
  for i in 0..cutoff.size-1
    grade = gradeLetters.at(i+1)
    if curr.percentage == 100
      Enrollment.where(id: curr.id).update(lettergrade: 'A+')
    else 
      if(curr.percentage < cutoff.at(i) && curr.percentage >= cutoff.at(i+1))
        Enrollment.where(id: curr.id).update(lettergrade: grade)
        break
      end
    end
  end
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
