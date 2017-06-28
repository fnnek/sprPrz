class ReportsController < ApplicationController



  def index

    @reports = Report.where(:user_id => current_user.id)
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
    @groups = Group.with_member(current_user)
  end

  def create
    group = Group.find_by_group_code(report_params[:groups])

    @report = current_user.reports.create(report_params.except(:groups))


    if @report.save
      group.add(@report, as: 'report')
      redirect_to reports_path, notice: "Sprawozdanie #{@report.title} zostało dodane."
    else
      render 'new'
    end

  end

  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(report_params)
      flash[:success] = "Profil zaktualizowany"
      redirect_to @report
    else
      render 'show'
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_path, notice:  "Sprawozdanie #{@report.title} zostało usunięte."
  end

  private
  def report_params
    params.require(:report).permit(:title, :attachment, :groups,:student_comment,:teacher_comment, :mark)

  end



end