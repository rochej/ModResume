class SkillsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @skills = @user.skills
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @user = User.find(current_user.id)
    @skill = Skill.new
    @description  = Description.new
    render partial: 'form'
  end

  def create
    p skill_params
    pass_params = skill_params
    detail_attributes = pass_params.delete(:details)
    @skill = current_user.skills.new(pass_params)
    if @skill.save
      render :json => {taggable_type: "Skill", taggable_id: @skill.id}
    else
      flash.now[:danger] = @skill.errors.full_messages
      render :new
    end
  end

  def skill_params
    params.require(:skill).permit(:title, :details =>[:detail])
  end
end
