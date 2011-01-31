require 'spree_core'
require 'highlight_products_hooks'

module HighlightProducts
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      #Include code
      Admin::ProductsController.send(:include, HighlightProducts::AdminProductsControllerExt)
      Product.send(:include, HighlightedProducts::ProductModelExt)

    end

    config.to_prepare &method(:activate).to_proc
  end
end
