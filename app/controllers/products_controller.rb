class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    #@products = Product.find(:all)
    @products = initialize_grid(Product, :erb_mode => true, :conditions => ["quantity > 0"])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = "#{@product.quantity} #{@product.name} were deposited at #{@product.location}."
        format.html { redirect_to(products_path) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  # POST /products/1/take
  def take
    @product = Product.find(params[:id])
    quantity_desired = params[:quantity_desired].to_i
    if @product.quantity >= quantity_desired
      remaining = @product.quantity - quantity_desired
      @product.update_attribute('quantity', remaining)
      flash[:notice] = "You have taken #{quantity_desired} #{@product.name} from #{@product.location}, #{@product.quantity} remain."
    else
      flash[:error] = "You are attempting to take more than exist, please live within our means and try again."
    end
    respond_to do |format|
      format.html { redirect_to(products_path) }
    end
  end
  
  # POST /products/1/replace
  def replace
    @product = Product.find(params[:id])
    respond_to do |format|
      if Product.increment_counter('quantity', params[:id])
        @product.reload
        flash[:notice] = "You have replaced one #{@product.name} at #{@product.location}, #{@product.quantity} now available."
        format.html { redirect_to(products_path) }
        #format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        #format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
end
