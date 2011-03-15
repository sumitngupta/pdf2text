class Pdf2Text < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/convert/:url' do

    receiver = PageTextReceiver.new
#    pdf = PDF::Reader.file(params[:url], receiver)
    # Use curb to get the file and deposit it in s3
    # 'http://www.fas.org/irp/world/para/manualpart1_1.pdf'

    pdf = PDF::Reader.file(, receiver)

    if receiver
      cp = endreceiver.content.inspect
    end

    content_type :json
    {converted_pdf => cp}.to_json
  end


  class PageTextReceiver
    attr_accessor :content

    def initialize
      @content = []
    end

    def begin_page(arg = nil)
      @content << ""
    end

    def show_text(string, *params)
      @content.last << string.strip
    end

    alias :super_show_text :show_text
    alias :move_to_next_line_and_show_text :show_text
    alias :set_spacing_next_line_show_text :show_text

    def show_text_with_positioning(*params)
      params = params.first
      params.each { |str| show_text(str) if str.kind_of?(String)}
    end
  end

end