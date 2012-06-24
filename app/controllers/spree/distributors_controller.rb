module Spree
  class DistributorsController < BaseController
    def show
      options = {:distributor_id => params[:id]}
      options.merge(params.reject { |k,v| k == :id })

      @searcher = Config.searcher_class.new(options)
      @products = @searcher.retrieve_products
      render :template => 'spree/products/index'
    end

    def select
      distributor = Distributor.find params[:id]

      order = current_order(true)

      if order.line_items.empty?
        order.distributor = distributor
        order.save!
      end

      redirect_back_or_default(root_path)
    end

    def deselect
      order = current_order(true)

      if order.line_items.empty?
        order.distributor = nil
        order.save!
      end

      redirect_back_or_default(root_path)
    end
  end
end
