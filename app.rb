

class Pdf2Text < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/convert' do
    p params
    #'http://www.impressivewebs.com/jquery-tutorial-beginners.pdf'
    ext_pdf = open(params[:url])
    cp = `pdftotext '#{ext_pdf.path}' - 2>&1`

#    ext_pdf = open('http://www.impressivewebs.com/jquery-tutorial-beginners.pdf')
#    receiver = PageTextReceiver.new
#    pdf = PDF::Reader.file(ext_pdf.path, receiver)
#
#    if receiver
#      cp = receiver.content
#    end
#
    p cp
    content_type :json
    {:converted_pdf => cp}.to_json
  end


#  class PageTextReceiver
#    attr_accessor :content
#
#    def initialize
#      @content = []
#    end
#
#    # Called when page parsing starts
#    def begin_page(arg = nil)
#      @content << ""
#    end
#
#    # record text that is drawn on the page
#    def show_text(string, *params)
#      @content.last << string.strip
#    end
#
#    # there's a few text callbacks, so make sure we process them all
#    alias :super_show_text :show_text
#    alias :move_to_next_line_and_show_text :show_text
#    alias :set_spacing_next_line_show_text :show_text
#
#    # this final text callback takes slightly different arguments
#    def show_text_with_positioning(*params)
#      params = params.first
#      params.each { |str| show_text(str) if str.kind_of?(String)}
#    end
#  end

end