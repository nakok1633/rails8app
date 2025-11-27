class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    # 현재 달력 표시용
    @current_year = params[:year]&.to_i || Date.today.year
    @current_month = params[:month]&.to_i || Date.today.month
    @current_date = Date.new(@current_year, @current_month, 1)
    
    # 해당 월의 시작과 끝 날짜
    month_start = @current_date.beginning_of_month
    month_end = @current_date.end_of_month
    
    # 해당 월의 게시물만 조회 (post_date 기준)
    @posts = Post.where(post_date: month_start..month_end).order(post_date: :desc)
    
    # 월별 게시물 매핑
    @posts_by_date = @posts.group_by { |post| post.post_date }
    
    # 카테고리별 통계 - DB에서 직접 집계 (해당 월만)
    @category_stats = Post.where(post_date: month_start..month_end)
                           .group(:category)
                           .count
    
    @category_labels = @category_stats.keys.map { |category| Post::CATEGORIES[category] || category }
    @category_data = @category_stats.values
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :body, :category, :post_date, :image, { images: [] } ])
    end
end
